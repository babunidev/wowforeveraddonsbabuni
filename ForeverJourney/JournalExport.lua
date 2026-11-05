local addonName, FJ = ...

-- Book Creator export is deliberately separate from the restore/backup format.
-- Only displayable journal data is included. Never export raw SavedVariables.
FJ.JournalExport = {}

local Export = FJ.JournalExport
local VERSION = 1
-- Prefer one copyable code for an ordinary-sized journal.
-- WoW EditBox limits can vary, so JournalExportUI checks the actual text
-- and automatically switches to a smaller part size if necessary.
local DEFAULT_CHUNK_SIZE = 30000
local FALLBACK_CHUNK_SIZE = 12000
local MAX_BYTES = 3 * 1024 * 1024
local MAX_ENTRIES = 20000

local function JsonString(value)
    value = type(value) == "string" and value or tostring(value or "")

    local escapes = {
        ['"'] = '\\"',
        ['\\'] = '\\\\',
        ['\b'] = '\\b',
        ['\f'] = '\\f',
        ['\n'] = '\\n',
        ['\r'] = '\\r',
        ['\t'] = '\\t'
    }

    return '"' .. value:gsub('[%z\1-\31\\"]', function(char)
        return escapes[char] or string.format("\\u%04X", string.byte(char))
    end) .. '"'
end

local function JsonNumber(value)
    local n = tonumber(value)
    if not n or n ~= n or n == math.huge or n == -math.huge then
        return "null"
    end
    return tostring(n)
end

local function JsonBoolean(value)
    return value == true and "true" or "false"
end

local function JsonOptionalString(value)
    if type(value) == "string" and value ~= "" then
        return JsonString(value)
    end
    return "null"
end

local function JsonEntry(memory)
    local raw = memory.raw or {}
    local location = memory.location or {}
    local semanticType = memory.semanticType or raw.type

    -- Personal notes attached to automatic events are independent of descriptions.
    local personalNote = type(raw.personalNote) == "string"
        and raw.personalNote or nil

    return table.concat({
        '{"type":', JsonOptionalString(semanticType),
        ',"typeLabel":', JsonOptionalString(memory.type),
        ',"source":', JsonOptionalString(memory.source),
        ',"title":', JsonOptionalString(memory.title),
        ',"description":', JsonOptionalString(memory.description),
        ',"personalNote":', JsonOptionalString(personalNote),
        ',"favorite":', JsonBoolean(memory.favorite),
        ',"timestamp":', JsonNumber(memory.timestamp),
        ',"location":', JsonOptionalString(location.name),
        '}'
    })
end

local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"

local function Base64Encode(data)
    local result = {}
    local n = #data

    for i = 1, n, 3 do
        local a, b, c = string.byte(data, i, i + 2)
        local number = a * 65536 + (b or 0) * 256 + (c or 0)

        local c1 = math.floor(number / 262144) % 64 + 1
        local c2 = math.floor(number / 4096) % 64 + 1
        local c3 = math.floor(number / 64) % 64 + 1
        local c4 = number % 64 + 1

        result[#result + 1] = alphabet:sub(c1, c1)
        result[#result + 1] = alphabet:sub(c2, c2)
        result[#result + 1] = b and alphabet:sub(c3, c3) or "="
        result[#result + 1] = c and alphabet:sub(c4, c4) or "="
    end

    return table.concat(result)
end

local function Adler32(data)
    local a, b = 1, 0
    for i = 1, #data do
        a = (a + data:byte(i)) % 65521
        b = (b + a) % 65521
    end
    return string.format("%08X", b * 65536 + a)
end

local function BuildJSON()
    if not FJ.ViewModel or not FJ.ViewModel.GetAllMemories
        or not FJ.ViewModel.GetOverview then
        return nil, "VIEWMODEL_NOT_READY"
    end

    local overview = FJ.ViewModel.GetOverview()
    local character = overview and overview.character or {}
    local journey = overview and overview.journey or {}
    local memories = FJ.ViewModel.GetAllMemories() or {}

    if #memories > MAX_ENTRIES then
        return nil, "TOO_MANY_MEMORIES"
    end

    -- Stable reading order. Never mutate the ViewModel's original table.
    local ordered = {}
    for index, memory in ipairs(memories) do
        if type(memory) == "table" then
            ordered[#ordered + 1] = { entry = memory, index = index }
        end
    end

    table.sort(ordered, function(a, b)
        local ta = tonumber(a.entry.timestamp) or 0
        local tb = tonumber(b.entry.timestamp) or 0
        if ta == tb then return a.index < b.index end
        return ta < tb
    end)

    local entries = {}
    local totalBytes = 0
    for _, item in ipairs(ordered) do
        local encoded = JsonEntry(item.entry)
        totalBytes = totalBytes + #encoded + 1
        if totalBytes > MAX_BYTES then
            return nil, "JOURNAL_TOO_LARGE"
        end
        entries[#entries + 1] = encoded
    end

    local locale = type(GetLocale) == "function" and GetLocale() or "enUS"
    local json = table.concat({
        '{"format":"FJJOURNAL","formatVersion":', tostring(VERSION),
        ',"addonVersion":', JsonOptionalString(FJ.Version),
        ',"locale":', JsonString(locale),
        ',"exportedAt":', JsonNumber(time()),
        ',"character":{"name":', JsonOptionalString(character.name),
        ',"race":', JsonOptionalString(character.race),
        ',"class":', JsonOptionalString(character.class),
        ',"level":', JsonNumber(character.level),
        '},"journey":{"startedAt":', JsonNumber(journey.recordingStartedAt or journey.startedAt),
        ',"deaths":', JsonNumber(journey.deaths),
        ',"completedQuests":', JsonNumber(journey.completedQuests),
        ',"totalPlayed":', JsonNumber(journey.totalPlayed),
        '},"memories":[', table.concat(entries, ','), ']}'
    })

    if #json > MAX_BYTES then
        return nil, "JOURNAL_TOO_LARGE"
    end

    return json, nil, #entries
end

function Export.Build(chunkSize)
    chunkSize = chunkSize == FALLBACK_CHUNK_SIZE
        and FALLBACK_CHUNK_SIZE or DEFAULT_CHUNK_SIZE

    local json, err, count = BuildJSON()
    if not json then return nil, err end

    -- All copied parts are ASCII, including journals containing Cyrillic text.
    local encoded = Base64Encode(json)
    local checksum = Adler32(json)
    local total = math.ceil(#encoded / chunkSize)
    local parts = {}

    for index = 1, total do
        local startByte = (index - 1) * chunkSize + 1
        local chunk = encoded:sub(startByte, index * chunkSize)
        parts[index] = string.format(
            "FJBOOK1:%d/%d:%s:%s",
            index, total, checksum, chunk
        )
    end

    return {
        parts = parts,
        count = count,
        total = total,
        jsonBytes = #json,
        checksum = checksum,
        chunkSize = chunkSize
    }, nil
end

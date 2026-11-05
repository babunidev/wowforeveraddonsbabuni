-- Persistent storage for Flourish Forever.
-- Forever is realmless, so profiles are keyed by character GUID.

local function AdoptPreviousStorage()
    if type(FlourishForeverStorage) ~= "table" and type(ROARitFOREVERStorage) == "table" then
        FlourishForeverStorage = ROARitFOREVERStorage
    end
end

local function EnsureRoot()
    AdoptPreviousStorage()

    if type(FlourishForeverStorage) ~= "table" then
        FlourishForeverStorage = {}
    end

    if type(FlourishForeverStorage.profiles) ~= "table" then
        FlourishForeverStorage.profiles = {}
    end
end

local function LegacyKeys()
    local keys = {}
    local name = UnitName("player")
    if not name or name == "" then
        return keys
    end

    keys[#keys + 1] = name

    local realm = (GetRealmName and GetRealmName()) or ""
    if realm ~= "" then
        keys[#keys + 1] = name .. "-" .. realm
    end

    return keys
end

local function BindCharacterDB()
    EnsureRoot()

    local guid = UnitGUID("player")
    if not guid or guid == "" then
        return nil
    end

    local profile = FlourishForeverStorage.profiles[guid]

    -- Migrate a profile created by an earlier name/realm-keyed version.
    if type(profile) ~= "table" then
        for _, oldKey in ipairs(LegacyKeys()) do
            local oldProfile = FlourishForeverStorage.profiles[oldKey]
            if type(oldProfile) == "table" then
                profile = oldProfile
                FlourishForeverStorage.profiles[oldKey] = nil
                break
            end
        end
    end

    if type(profile) ~= "table" then
        profile = {}
    end

    FlourishForeverStorage.profiles[guid] = profile
    FlourishForeverDB = profile
    return profile, guid
end

FlourishForever_BindCharacterDB = BindCharacterDB

function FlourishForever_StorageStatus()
    local _, guid = BindCharacterDB()
    if not guid then
        return "character profile unavailable"
    end
    return "standard SavedVariables; profile " .. guid
end

local storageFrame = CreateFrame("Frame")
storageFrame:RegisterEvent("PLAYER_LOGIN")
storageFrame:SetScript("OnEvent", function()
    BindCharacterDB()
end)

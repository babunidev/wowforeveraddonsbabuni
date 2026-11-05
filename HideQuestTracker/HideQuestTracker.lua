-- Hide Quest Tracker
-- Removes the Objective Tracker from the right side of the screen.
-- Built for World of Warcraft: Forever 1.60.1 (Interface 16001).
--
-- The tracker calls Show again whenever a quest updates, so hiding it once
-- is not enough. This addon hides it every time the game tries to show it.

local TRACKER_NAMES = {
    "ObjectiveTrackerFrame",
    "WatchFrame",
    "QuestWatchFrame",
}

local hooked = {}
local announced = false
local missingAnnounced = false

local function ShouldHide()
    return not HideQuestTrackerDB or HideQuestTrackerDB.hidden ~= false
end

local function Suppress(frame)
    if not frame or hooked[frame] then
        return false
    end
    hooked[frame] = true

    -- Quest updates call Show again. Hide as soon as that call finishes.
    hooksecurefunc(frame, "Show", function(self)
        if ShouldHide() then
            self:Hide()
        end
    end)

    if ShouldHide() then
        frame:Hide()
    end
    return true
end

local function Apply()
    local found = false
    for _, name in ipairs(TRACKER_NAMES) do
        local frame = _G[name]
        if frame then
            Suppress(frame)
            found = found or hooked[frame]
        end
    end
    return found
end

local function AnnounceHidden()
    if announced or not ShouldHide() then
        return
    end
    announced = true
    print("|cffffcc00Hide Quest Tracker:|r Objective Tracker hidden. Type /hqt to show it again.")
end

local watcher = CreateFrame("Frame")
watcher:RegisterEvent("ADDON_LOADED")
watcher:RegisterEvent("PLAYER_LOGIN")
watcher:RegisterEvent("PLAYER_ENTERING_WORLD")
watcher:SetScript("OnEvent", function(_, event, name)
    if event == "ADDON_LOADED" and name == "HideQuestTracker" then
        HideQuestTrackerDB = HideQuestTrackerDB or {}
        if HideQuestTrackerDB.hidden == nil then
            HideQuestTrackerDB.hidden = true
        end
    end

    if Apply() and ShouldHide() then
        AnnounceHidden()
    end
end)

-- Blizzard_ObjectiveTracker can finish loading after this addon.
C_Timer.NewTicker(0.5, function(ticker)
    Apply()
    ticker.tries = (ticker.tries or 0) + 1

    local modern = _G.ObjectiveTrackerFrame
    local classic = _G.WatchFrame or _G.QuestWatchFrame
    local ready = (modern and hooked[modern])
        or (not modern and classic and hooked[classic] and ticker.tries >= 4)

    if ready then
        AnnounceHidden()
        ticker:Cancel()
    elseif ticker.tries >= 20 then
        ticker:Cancel()
        if not missingAnnounced and ShouldHide() then
            missingAnnounced = true
            print("|cffffcc00Hide Quest Tracker:|r Could not find the Objective Tracker.")
        end
    end
end)

local function SetHidden(hidden)
    HideQuestTrackerDB = HideQuestTrackerDB or {}
    HideQuestTrackerDB.hidden = hidden
    if hidden then
        announced = true
        for frame in pairs(hooked) do
            frame:Hide()
        end
        print("|cffffcc00Hide Quest Tracker:|r Objective Tracker hidden.")
    else
        for _, name in ipairs(TRACKER_NAMES) do
            local frame = _G[name]
            if frame then
                frame:Show()
            end
        end
        print("|cffffcc00Hide Quest Tracker:|r Objective Tracker shown.")
    end
end

SLASH_HIDEQUESTTRACKER1 = "/hqt"
SLASH_HIDEQUESTTRACKER2 = "/hidequesttracker"
SlashCmdList.HIDEQUESTTRACKER = function(message)
    message = (message or ""):lower():gsub("^%s+", ""):gsub("%s+$", "")
    if message == "show" or message == "off" then
        SetHidden(false)
    elseif message == "hide" or message == "on" then
        SetHidden(true)
    else
        SetHidden(not ShouldHide())
    end
end

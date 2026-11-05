--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
e.sewPrint("Loading...","debug")
local a=CreateFrame("Frame")
a:RegisterEvent("ADDON_LOADED")
a:SetScript("OnEvent",function(o,i,a)
if a~=t then return end
o:UnregisterEvent(i)
local t,a=pcall(function()
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
e.debugEnabled=StryksEmoteWheelDB.debug or false
e.version=C_AddOns.GetAddOnMetadata(t,"Version")or"?"
e.debugLog=StryksEmoteWheelDB.debugLog or{}
while#e.debugLog>e.DEBUG_LOG_MAX do
table.remove(e.debugLog,1)
end
StryksEmoteWheelDB.debugLog=e.debugLog
e.sewPrint("ADDON_LOADED fired","debug")
if StryksEmoteWheelDB.x and StryksEmoteWheelDB.y then
e.trigger:ClearAllPoints()
e.trigger:SetPoint("CENTER",UIParent,"CENTER",StryksEmoteWheelDB.x,StryksEmoteWheelDB.y)
e.sewPrint("Position restored: ("..StryksEmoteWheelDB.x..", "..StryksEmoteWheelDB.y..")","debug")
else
e.sewPrint("Loaded at (0, 0) - no saved position","debug")
end
if StryksEmoteWheelDB.spx and StryksEmoteWheelDB.spy then
e.settingsPanel:ClearAllPoints()
e.settingsPanel:SetPoint("CENTER",UIParent,"CENTER",StryksEmoteWheelDB.spx,StryksEmoteWheelDB.spy)
end
e.bgTexture=StryksEmoteWheelDB.bgTexture or e.DEFAULT_BG_TEXTURE
e.bgTextureAlpha=tonumber(StryksEmoteWheelDB.bgTextureAlpha)or e.DEFAULT_BG_TEXTURE_ALPHA
if e.updateBgTextureControls then e.updateBgTextureControls()end
if e.applyBgTexture then e.applyBgTexture()end
local a=StryksEmoteWheelDB.theme or e.DEFAULT_THEME_NAME
for o,t in ipairs(e.THEMES)do
if t.name==a then e.applyTheme(t);break end
end
e.applyIcon(StryksEmoteWheelDB.icon or e.DEFAULT_ICON_FILE)
if StryksEmoteWheelDB.wheelRadius then
e.wheelSizeSlider:SetValue(StryksEmoteWheelDB.wheelRadius)
end
if StryksEmoteWheelDB.customEmotes then
for a,t in pairs(StryksEmoteWheelDB.customEmotes)do
if e.CUSTOM_EMOTES[a]and t.name and t.text then
e.CUSTOM_EMOTES[a].name=t.name
e.CUSTOM_EMOTES[a].text=t.text
end
end
if e.refreshCustomTab then e.refreshCustomTab()end
end
if StryksEmoteWheelDB.emotes then
for o,t in pairs(StryksEmoteWheelDB.emotes)do
local a=tostring(t):match("^CUSTOM:(%d+)$")
if a then
local t=tonumber(a)
if e.CUSTOM_EMOTES[t]then
e.EMOTES[o]=e.CUSTOM_EMOTES[t]
end
else
for i,a in ipairs(e.AVAILABLE_EMOTES)do
if a.cmd==t then
e.EMOTES[o]=a
break
end
end
end
end
if e.refreshWheelDisplay then e.refreshWheelDisplay()end
if e.refreshWheelSlotsTab then e.refreshWheelSlotsTab()end
end
if StryksEmoteWheelDB.emoticons then
for a,t in pairs(StryksEmoteWheelDB.emoticons)do
if t==false or e.EMOTICON_BY_ID[t]then
e.SLOT_EMOTICONS[a]=t
end
end
end
if tonumber(StryksEmoteWheelDB.wheelPage)and e.setWheelPage then
e.setWheelPage(tonumber(StryksEmoteWheelDB.wheelPage))
end
e.textOnly=StryksEmoteWheelDB.textOnly and true or false
if e.updateTextOnlyCheckbox then e.updateTextOnlyCheckbox()end
if e.refreshWheelDisplay then e.refreshWheelDisplay()end
if e.refreshWheelSlotsTab then e.refreshWheelSlotsTab()end
if StryksEmoteWheelDB.keyBind then
e.keyBind=StryksEmoteWheelDB.keyBind
end
if StryksEmoteWheelDB.padBind then
e.padBind=StryksEmoteWheelDB.padBind
if e.updatePadOverrideBinding then e.updatePadOverrideBinding()end
end
if(StryksEmoteWheelDB.keyBind or StryksEmoteWheelDB.padBind)and e.updateKeyBindDisplay then
e.updateKeyBindDisplay()
end
if StryksEmoteWheelDB.radialMode~=nil then
e.radialMode=StryksEmoteWheelDB.radialMode
if e.updateRadialCheckbox then e.updateRadialCheckbox()end
end
if StryksEmoteWheelDB.controllerStick then
e.controllerStick=StryksEmoteWheelDB.controllerStick
if e.updateStickDisplay then e.updateStickDisplay()end
end
e.triggerOpacity=StryksEmoteWheelDB.triggerOpacity or 1.0
if e.applyTriggerOpacity then e.applyTriggerOpacity()end
if e.updateOpacitySlider then e.updateOpacitySlider()end
e.hideTrigger=StryksEmoteWheelDB.hideTrigger or false
if e.applyHideTrigger then e.applyHideTrigger()end
if e.updateHideTriggerCheckbox then e.updateHideTriggerCheckbox()end
StryksEmoteWheelDB.seenInit=true
end)
if t then
e.sewPrint("Load complete","debug")
else
e.sewPrint("ERROR: "..tostring(a),"warn")
end
end)
e.resetAllSettings=function()
StryksEmoteWheelDB={}
e.trigger:ClearAllPoints()
e.trigger:SetPoint("CENTER",UIParent,"CENTER",0,0)
e.settingsPanel:ClearAllPoints()
e.settingsPanel:SetPoint("CENTER",UIParent,"CENTER",0,0)
e.bgTexture=e.DEFAULT_BG_TEXTURE
e.bgTextureAlpha=e.DEFAULT_BG_TEXTURE_ALPHA
if e.updateBgTextureControls then e.updateBgTextureControls()end
if e.applyBgTexture then e.applyBgTexture()end
for a,t in ipairs(e.THEMES)do
if t.name==e.DEFAULT_THEME_NAME then e.applyTheme(t);break end
end
e.applyIcon(e.DEFAULT_ICON_FILE)
e.wheelSizeSlider:SetValue(e.DEFAULT_WHEELSIZE)
for a,t in ipairs(e.DEFAULT_EMOTES)do
e.EMOTES[a]={name=t.name,cmd=t.cmd}
end
for a,t in ipairs(e.DEFAULT_CUSTOM_EMOTES)do
e.CUSTOM_EMOTES[a].name=t.name
e.CUSTOM_EMOTES[a].text=t.text
end
for t,a in ipairs(e.CUSTOM_EMOTES)do
e.EMOTES[#e.DEFAULT_EMOTES+t]=a
end
for t in pairs(e.SLOT_EMOTICONS)do
e.SLOT_EMOTICONS[t]=nil
end
e.textOnly=false
if e.updateTextOnlyCheckbox then e.updateTextOnlyCheckbox()end
if e.refreshCustomTab then e.refreshCustomTab()end
if e.setWheelPage then e.setWheelPage(1)end
if e.refreshWheelDisplay then e.refreshWheelDisplay()end
if e.refreshWheelSlotsTab then e.refreshWheelSlotsTab()end
e.keyBind=nil
e.padBind=nil
if e.updatePadOverrideBinding then e.updatePadOverrideBinding()end
if e.updateKeyBindDisplay then e.updateKeyBindDisplay()end
e.radialMode=true
if e.updateRadialCheckbox then e.updateRadialCheckbox()end
e.controllerStick=2
if e.updateStickDisplay then e.updateStickDisplay()end
e.triggerOpacity=1.0
if e.applyTriggerOpacity then e.applyTriggerOpacity()end
if e.updateOpacitySlider then e.updateOpacitySlider()end
e.hideTrigger=false
if e.applyHideTrigger then e.applyHideTrigger()end
if e.updateHideTriggerCheckbox then e.updateHideTriggerCheckbox()end
e.sewPrint("Reset to defaults.","info")
end
SLASH_SEW1="/sew"
SlashCmdList["SEW"]=function(t)
local t=t:match("^%s*(%S*)"):lower()
if t=="show"then
e.hideTrigger=not e.hideTrigger
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.hideTrigger=e.hideTrigger
if e.applyHideTrigger then e.applyHideTrigger()end
if e.updateHideTriggerCheckbox then e.updateHideTriggerCheckbox()end
elseif t=="settings"then
local e=e.settingsPanel
if e:IsShown()then e:Hide()else e:Show()end
elseif t=="reset"then
e.resetAllSettings()
elseif t=="info"then
local l,d,t,r=GetBuildInfo()
local t
if WOW_PROJECT_ID then
local e={
[WOW_PROJECT_MAINLINE]="Retail",
[WOW_PROJECT_CLASSIC]="Classic Era",
}
t=e[WOW_PROJECT_ID]or("Unknown ("..tostring(WOW_PROJECT_ID)..")")
else
t="Unknown (no WOW_PROJECT_ID)"
end
local o,s=e.trigger:GetCenter()
local n=StryksEmoteWheelDB and StryksEmoteWheelDB.x
local h=StryksEmoteWheelDB and StryksEmoteWheelDB.y
local function a(e)
if not e then return"none"end
return(e.mod and e.mod~=""and(e.mod.."+")or"")..(e.key or"?")
end
local i={[1]="Left",[2]="Right"}
e.sewPrint("Addon version:   "..(e.version or"?"),"info")
e.sewPrint("WoW client:      "..l.." (build "..d..", toc "..tostring(r)..")","info")
e.sewPrint("WoW project:     "..t,"info")
e.sewPrint("Trigger hidden:  "..tostring(e.hideTrigger or false),"info")
e.sewPrint("Snap to cursor:  "..tostring(e.radialMode or false),"info")
e.sewPrint("Key bind:        "..a(e.keyBind),"info")
e.sewPrint("Pad bind:        "..a(e.padBind),"info")
e.sewPrint("Controller stick:"..(i[e.controllerStick]or tostring(e.controllerStick)),"info")
e.sewPrint("GamePad enabled: "..tostring(C_GamePad and C_GamePad.IsEnabled and C_GamePad.IsEnabled()or false),"info")
e.sewPrint("Saved position:  ("..tostring(n)..", "..tostring(h)..")","info")
e.sewPrint("Trigger center:  ("..string.format("%.1f",o or 0)..", "..string.format("%.1f",s or 0)..")","info")
e.sewPrint("Frame strata:    "..e.trigger:GetFrameStrata(),"info")
elseif t=="debug"then
e.toggleDebugMode()
elseif t=="sticktest"then
e.slashSticktest()
elseif t=="padtest"then
e.slashPadtest()
elseif t=="cursor"then
SetCursor("Interface/cursor/ui-cursor-move.blp")
e.sewPrint("Cursor set - check your mouse.","info")
elseif t=="help"then
e.sewPrint("/sew show     - toggle the trigger button visible/hidden","info")
e.sewPrint("/sew settings - open or close the Settings panel","info")
e.sewPrint("/sew reset    - restore all defaults (position, theme, icon, size, slots)","info")
e.sewPrint("/sew info     - show version, position, and frame info","info")
e.sewPrint("/sew debug    - toggle verbose debug messages","info")
e.sewPrint("/sew help     - show this command list","info")
else
e.sewPrint("Type /sew help for a list of commands.","info")
end
end
local t=CreateFrame("Frame")
t.name="Stryk's Emote Wheel"
local a=t:CreateFontString(nil,"ARTWORK","GameFontNormalLarge")
a:SetPoint("TOPLEFT",16,-16)
a:SetText("Stryk's Emote Wheel")
local i=t:CreateFontString(nil,"ARTWORK","GameFontHighlight")
i:SetPoint("TOPLEFT",a,"BOTTOMLEFT",0,-8)
i:SetText("Click the button below to open the Stryk's Emote Wheel settings.")
local o=CreateFrame("Button",nil,t,"UIPanelButtonTemplate")
o:SetSize(180,22)
o:SetPoint("TOPLEFT",i,"BOTTOMLEFT",0,-12)
o:SetText("Open Settings")
o:SetScript("OnClick",function()
if not e.settingsPanel:IsShown()then e.settingsPanel:Show()end
if SettingsPanel and SettingsPanel:IsShown()then
HideUIPanel(SettingsPanel)
elseif InterfaceOptionsFrame and InterfaceOptionsFrame:IsShown()then
HideUIPanel(InterfaceOptionsFrame)
end
end)
local function i(t)
t:SetText(e.hideTrigger and"Show Trigger"or"Hide Trigger")
end
local a=CreateFrame("Button",nil,t,"UIPanelButtonTemplate")
a:SetSize(180,22)
a:SetPoint("TOPLEFT",o,"BOTTOMLEFT",0,-6)
i(a)
a:SetScript("OnClick",function()
e.hideTrigger=not e.hideTrigger
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.hideTrigger=e.hideTrigger
if e.applyHideTrigger then e.applyHideTrigger()end
if e.updateHideTriggerCheckbox then e.updateHideTriggerCheckbox()end
i(a)
end)
local e=CreateFrame("Button",nil,t,"UIPanelButtonTemplate")
e:SetSize(180,22)
e:SetPoint("TOPLEFT",a,"BOTTOMLEFT",0,-6)
e:SetText("Reset to Default")
e:SetScript("OnClick",function()
StaticPopup_Show("SEW_RESET_ALL_CONFIRM")
end)
if Settings and Settings.RegisterCanvasLayoutCategory then
local e=Settings.RegisterCanvasLayoutCategory(t,t.name)
Settings.RegisterAddOnCategory(e)
elseif InterfaceOptions_AddCategory then
InterfaceOptions_AddCategory(t)
end

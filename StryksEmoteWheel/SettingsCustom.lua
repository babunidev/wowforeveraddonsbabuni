--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
local a=e.tab2Content
local c=e.CELL_H
local n=e.MARGIN
local o={1.00,0.35,0.30}
local i=n+30
local w=128
local f=i+w+10
local u=28
local l=-72
e.addSectionHeader(a,"Custom Emotes",n,-6)
local t=e.createText(a,
"Your own /em lines. Put them on any slot from the Wheel tab's Emote list.","dim")
t:SetPoint("TOPLEFT",a,"TOPLEFT",n,-30)
local function t(o,i)
local e=e.createText(a,string.upper(o),"accentDim","GameFontNormalSmall")
e:SetPoint("TOPLEFT",a,"TOPLEFT",i,-54)
return e
end
t("#",n+4)
t("Name",i+2)
t("Text sent with /em",f+2)
local t=a:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
t:SetPoint("TOPLEFT",a,"TOPLEFT",n,l-12*u-16)
t:SetPoint("RIGHT",a,"RIGHT",-(n+200),0)
t:SetJustifyH("LEFT")
t:SetText(" ")
e.shadowText(t)
local function r(a)
e.stopTween(t)
t:SetAlpha(1)
t:SetText(a)
t:SetTextColor(o[1],o[2],o[3],1)
end
local function d()
e.stopTween(t)
t:SetText(" ")
end
local function y()
local a=e.CFG.col.labelHot
t:SetText("Saved.")
t:SetTextColor(a[1],a[2],a[3],1)
t:SetAlpha(1)
C_Timer.After(1.2,function()
if t:GetText()=="Saved."then
e.tween(t,1,0,0.6,function(e)t:SetAlpha(e)end)
end
end)
end
local function o(o,t)
t=t:match("^%s*(.-)%s*$")
if t==""then
return false,"Name can't be empty."
end
if#t>e.CUSTOM_NAME_MAX_LEN then
return false,"Name must be "..e.CUSTOM_NAME_MAX_LEN.." characters or fewer."
end
local a=t:lower()
for o,e in ipairs(e.ALL_EMOTES)do
if e.name:lower()==a then
return false,"\""..t.."\" is already a built-in emote name."
end
end
for i,e in ipairs(e.CUSTOM_EMOTES)do
if i~=o and e.name:lower()==a then
return false,"\""..t.."\" is already used by another custom emote."
end
end
return true
end
local function p(e)
if e:match("^%s*(.-)%s*$")==""then
return false,"Text can't be empty."
end
return true
end
local s,h={},{}
e.refreshCustomTab=function()
for e,t in ipairs(e.CUSTOM_EMOTES)do
if s[e]then s[e]:SetText(t.name)end
if h[e]then h[e]:SetText(t.text)end
end
d()
end
local function m(t)
local o,l=o(t,s[t]:GetText())
local a,i=p(h[t]:GetText())
local n=e.CUSTOM_EMOTES[t].name.."\n"..e.CUSTOM_EMOTES[t].text
if o then
e.CUSTOM_EMOTES[t].name=s[t]:GetText():match("^%s*(.-)%s*$")
else
s[t]:SetText(e.CUSTOM_EMOTES[t].name)
r(l)
end
if a then
e.CUSTOM_EMOTES[t].text=h[t]:GetText()
else
h[t]:SetText(e.CUSTOM_EMOTES[t].text)
r(i)
end
if o and a then
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.customEmotes=StryksEmoteWheelDB.customEmotes or{}
StryksEmoteWheelDB.customEmotes[t]={name=e.CUSTOM_EMOTES[t].name,text=e.CUSTOM_EMOTES[t].text}
if e.refreshWheelDisplay then e.refreshWheelDisplay()end
if e.refreshCustomPickerRows then e.refreshCustomPickerRows()end
if e.refreshWheelSlotsTab then e.refreshWheelSlotsTab()end
if n~=e.CUSTOM_EMOTES[t].name.."\n"..e.CUSTOM_EMOTES[t].text then
y()
else
d()
end
end
end
for o=1,12 do
local d=l-(o-1)*u
local u=e.CUSTOM_EMOTES[o]
local t=e.createText(a,string.format("%02d",o),"dim","GameFontNormalSmall")
t:SetPoint("TOPLEFT",a,"TOPLEFT",n+2,d-6)
local t=e.createEditBox(a,w,c,"Name")
t:SetPoint("TOPLEFT",a,"TOPLEFT",i,d)
t:SetMaxLetters(e.CUSTOM_NAME_MAX_LEN)
t:SetTextInsets(8,30,0,0)
t:SetText(u.name)
s[o]=t
local r=t:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
r:SetPoint("RIGHT",t,"RIGHT",-7,0)
r:Hide()
local function l()
local t=#(t:GetText()or"")
local a=e.CFG.col
local a=(t>=e.CUSTOM_NAME_MAX_LEN)and a.labelHot or a.labelNorm
r:SetText(t.."/"..e.CUSTOM_NAME_MAX_LEN)
r:SetTextColor(a[1],a[2],a[3],t>=e.CUSTOM_NAME_MAX_LEN and 1 or 0.45)
end
local i=e.createEditBox(a,100,c,"What your character does")
i:SetPoint("TOPLEFT",a,"TOPLEFT",f,d)
i:SetPoint("RIGHT",a,"RIGHT",-n,0)
i:SetMaxLetters(100)
i:SetText(u.text)
h[o]=i
t:SetScript("OnEnterPressed",function(e)e:ClearFocus()end)
t:HookScript("OnEditFocusLost",function()r:Hide();m(o)end)
t:HookScript("OnEditFocusGained",function()l();r:Show()end)
t:HookScript("OnTextChanged",l)
t:SetScript("OnEscapePressed",function(t)t:SetText(e.CUSTOM_EMOTES[o].name);t:ClearFocus()end)
t:SetScript("OnTabPressed",function()i:SetFocus()end)
i:SetScript("OnEnterPressed",function(e)e:ClearFocus()end)
i:HookScript("OnEditFocusLost",function()m(o)end)
i:SetScript("OnEscapePressed",function(t)t:SetText(e.CUSTOM_EMOTES[o].text);t:ClearFocus()end)
i:SetScript("OnTabPressed",function()
local e=s[o+1]or s[1]
e:SetFocus()
end)
end
local o=e.createButton(a,"Reset to Default",180,c)
o:SetPoint("TOPRIGHT",a,"TOPRIGHT",-n,l-12*u-10)
StaticPopupDialogs["SEW_RESET_CUSTOM_CONFIRM"]={
text="Reset all 12 custom emotes to their default names and text?",
button1="Reset",
button2="Cancel",
OnAccept=function()
for t,a in ipairs(e.DEFAULT_CUSTOM_EMOTES)do
e.CUSTOM_EMOTES[t].name=a.name
e.CUSTOM_EMOTES[t].text=a.text
end
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.customEmotes={}
for a,t in ipairs(e.CUSTOM_EMOTES)do
StryksEmoteWheelDB.customEmotes[a]={name=t.name,text=t.text}
end
e.refreshCustomTab()
if e.refreshWheelDisplay then e.refreshWheelDisplay()end
if e.refreshWheelSlotsTab then e.refreshWheelSlotsTab()end
if e.refreshCustomPickerRows then e.refreshCustomPickerRows()end
end,
timeout=0,
whileDead=true,
hideOnEscape=true,
preferredIndex=3,
}
o:SetScript("OnClick",function()
StaticPopup_Show("SEW_RESET_CUSTOM_CONFIRM")
end)
a:HookScript("OnShow",e.refreshCustomTab)

--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
e.PANEL_W=660
e.PANEL_H=600
local a="StryksEmoteWheelSettingsPanel"
e.settingsPanel=CreateFrame("Frame",a,UIParent)
local t=e.settingsPanel
t:SetSize(e.PANEL_W,e.PANEL_H)
t:SetPoint("CENTER",UIParent,"CENTER",0,0)
t:SetFrameStrata("DIALOG")
t:SetMovable(true)
t:EnableMouse(true)
t:SetClampedToScreen(true)
if t.SetDontSavePosition then t:SetDontSavePosition(true)end
t:Hide()
if UISpecialFrames then table.insert(UISpecialFrames,a)end
local function i()
local o,t=t:GetCenter()
local a,i=UIParent:GetCenter()
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.spx=o-a
StryksEmoteWheelDB.spy=t-i
end
e.skinFrame(t,{texture=true,alpha=0.97})
do
local a=t:CreateAnimationGroup()
local e=a:CreateAnimation("Alpha")
if e.SetFromAlpha then
e:SetFromAlpha(0)
e:SetToAlpha(1)
end
e:SetDuration(0.16)
e:SetSmoothing("OUT")
local e=a:CreateAnimation("Scale")
if e.SetScaleFrom then
e:SetScaleFrom(1,1)
e:SetScaleTo(1,1)
elseif e.SetFromScale then
e:SetFromScale(1,1)
e:SetToScale(1,1)
end
e:SetDuration(0.18)
e:SetSmoothing("OUT")
t:HookScript("OnShow",function()
a:Stop()
a:Play()
if PlaySound then pcall(PlaySound,839)end
end)
t:HookScript("OnHide",function()
if PlaySound then pcall(PlaySound,840)end
end)
end
local a=t:CreateFontString(nil,"OVERLAY")
e.setTitleFont(a,20)
a:SetPoint("TOP",t,"TOP",0,-14)
a:SetText("Stryk's Emote Wheel")
e.shadowText(a,1)
local o=e.createFadeLine(t,320,0.45)
o:SetPoint("TOP",t,"TOP",0,-44)
e.onTheme(function(e)
local e=e.labelHot
a:SetTextColor(e[1],e[2],e[3],1)
end)
local a=e.createCloseButton(t,function()t:Hide()end)
a:SetPoint("TOPRIGHT",t,"TOPRIGHT",-10,-10)
a:SetFrameLevel(t:GetFrameLevel()+10)
local a=CreateFrame("Frame",nil,t)
a:SetPoint("TOPLEFT",t,"TOPLEFT",6,-6)
a:SetPoint("TOPRIGHT",t,"TOPRIGHT",-40,-6)
a:SetHeight(50)
a:EnableMouse(true)
a:RegisterForDrag("LeftButton")
a:SetScript("OnDragStart",function()t:StartMoving()end)
a:SetScript("OnDragStop",function()
t:StopMovingOrSizing()
if t.SetUserPlaced then t:SetUserPlaced(false)end
SetCursor(nil)
i()
end)
a:SetScript("OnEnter",function()SetCursor("Interface/cursor/ui-cursor-move.blp")end)
a:SetScript("OnLeave",function()SetCursor(nil)end)
local i=28
local o=-62
local s=40
local h=math.floor((e.PANEL_W-s*2)/4)
e.TAB_Y,e.TAB_H,e.TAB_SIDE,e.TAB_W=o,i,s,h
local function n(n,r)
local a=CreateFrame("Button",nil,t)
a:SetSize(h,i)
a:SetPoint("TOPLEFT",t,"TOPLEFT",s+(r-1)*h,o)
local t=a:CreateFontString(nil,"OVERLAY","GameFontNormal")
t:SetPoint("CENTER",a,"CENTER",0,1)
t:SetText(n)
e.shadowText(t,1)
return a,t
end
e.tab1Btn,e.tab1BtnLabel=n("Wheel",1)
e.tab2Btn,e.tab2BtnLabel=n("Custom",2)
e.tab3Btn,e.tab3BtnLabel=n("Controls",3)
e.tab4Btn,e.tab4BtnLabel=n("Debug",4)
local a=e.createDivider(t)
a:SetPoints(18,18,o-i-1)
local o=o-i-10
local a=34
e.CONTENT_W=e.PANEL_W
e.CONTENT_H=e.PANEL_H+o-a
local function a()
local a=CreateFrame("Frame",nil,t)
a:SetPoint("TOPLEFT",t,"TOPLEFT",0,o)
a:SetSize(e.CONTENT_W,e.CONTENT_H)
return a
end
e.tab1Content=a()
e.tab2Content=a()
e.tab2Content:Hide()
e.tab3Content=a()
e.tab3Content:Hide()
e.tab4Content=a()
e.tab4Content:Hide()
e.CELL_H=24
e.ROW_H=30
e.MARGIN=22
function e.addSectionHeader(a,n,i,o,t)
local t=e.createHeader(a,n,t or(e.CONTENT_W-2*e.MARGIN))
t:SetPoint("TOPLEFT",a,"TOPLEFT",i or e.MARGIN,o or-6)
return t
end
function e.addRow(a,t,s,n,h,o,i)
local t=e.createText(a,t,"label","GameFontNormalSmall")
t:SetPoint("TOPLEFT",a,"TOPLEFT",s,n-(e.CELL_H-12)/2)
t:SetJustifyH("LEFT")
if o then
o:ClearAllPoints()
o:SetPoint("TOPRIGHT",a,"TOPLEFT",s+h,n)
end
if i then
local e=e.createText(a,i,"dim","GameFontNormalSmall")
e:SetPoint("TOPLEFT",t,"BOTTOMLEFT",0,-3)
e:SetJustifyH("LEFT")
t.hint=e
end
return t
end

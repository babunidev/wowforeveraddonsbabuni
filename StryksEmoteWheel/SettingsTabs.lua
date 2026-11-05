--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local i,e=...
local d=e.CFG
local t=e.settingsPanel
e.currentTab=1
do
local o=t:CreateTexture(nil,"ARTWORK")
local a=t:CreateTexture(nil,"ARTWORK")
for t,e in ipairs({o,a})do
e:SetHeight(1)
e:SetColorTexture(1,1,1,1)
end
o:SetPoint("BOTTOMLEFT",t,"BOTTOMLEFT",18,30)
o:SetPoint("BOTTOMRIGHT",t,"BOTTOM",0,30)
a:SetPoint("BOTTOMLEFT",t,"BOTTOM",0,30)
a:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-18,30)
e.onTheme(function(t)
local t=t.wheelBorder
e.setGradient(o,"HORIZONTAL",t[1],t[2],t[3],0,t[1],t[2],t[3],0.3)
e.setGradient(a,"HORIZONTAL",t[1],t[2],t[3],0.3,t[1],t[2],t[3],0)
end)
end
local a=e.createText(t,
"v"..((C_AddOns and C_AddOns.GetAddOnMetadata(i,"Version"))or"?"),"dim","GameFontNormalSmall")
a:SetPoint("BOTTOM",t,"BOTTOM",0,11)
local function n(i,o,h,s)
local a=t:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
a:SetPoint(o,t,o,h,11)
a:SetText(i)
e.shadowText(a)
local o=false
local function i(t)
t=t or d.col
if o then
local e=t.labelHot
a:SetTextColor(e[1],e[2],e[3],1)
else
local e=t.labelNorm
a:SetTextColor(e[1],e[2],e[3],0.5)
end
end
e.onTheme(i)
local e=CreateFrame("Button",nil,t)
e:SetPoint("TOPLEFT",a,"TOPLEFT",-4,4)
e:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",4,-4)
e:SetScript("OnClick",s)
e:SetScript("OnEnter",function()o=true;i()end)
e:SetScript("OnLeave",function()o=false;i()end)
return a
end
n("/sew help","BOTTOMLEFT",20,function()SlashCmdList["SEW"]("help")end)
local a="https://reddit.com/u/stryker2k2"
StaticPopupDialogs["SEW_AUTHOR_LINK"]={
text="Press Ctrl+C to copy the link, then paste it into your browser:",
button1="Close",
hasEditBox=true,
editBoxWidth=260,
OnShow=function(e)
local e=e.editBox or _G[e:GetName().."EditBox"]
e:SetText(a)
e:HighlightText()
e:SetFocus()
end,
EditBoxOnEnterPressed=function(e)e:GetParent():Hide()end,
EditBoxOnEscapePressed=function(e)e:GetParent():Hide()end,
EditBoxOnTextChanged=function(e)
if e:GetText()~=a then
e:SetText(a)
e:HighlightText()
end
end,
timeout=0,
whileDead=true,
hideOnEscape=true,
preferredIndex=3,
}
n("@stryker2k2","BOTTOMRIGHT",-20,function()StaticPopup_Show("SEW_AUTHOR_LINK")end)
t:HookScript("OnHide",function()
e.closeAllDropdowns()
end)
local h={
{btn=e.tab1Btn,lbl=e.tab1BtnLabel,content=e.tab1Content},
{btn=e.tab2Btn,lbl=e.tab2BtnLabel,content=e.tab2Content},
{btn=e.tab3Btn,lbl=e.tab3BtnLabel,content=e.tab3Content},
{btn=e.tab4Btn,lbl=e.tab4BtnLabel,content=e.tab4Content},
}
local a=t:CreateTexture(nil,"ARTWORK",nil,3)
a:SetHeight(2)
a:SetColorTexture(1,1,1,1)
local s=e.artTexture(t,"soft_glow","ARTWORK",2,"ADD")
s:SetPoint("CENTER",a,"CENTER",0,0)
local i,o=0,0
local function r()
a:ClearAllPoints()
a:SetPoint("TOP",t,"TOPLEFT",i,e.TAB_Y-e.TAB_H+2)
a:SetWidth(math.max(1,o))
s:SetSize(o+40,26)
end
local function l(t)
return e.TAB_SIDE+(t-0.5)*e.TAB_W,h[t].lbl:GetStringWidth()+18
end
local function n(t)
t=t or d.col
local t,o=t.labelHot,t.labelNorm
for n,i in ipairs(h)do
if n==e.currentTab then
i.lbl:SetTextColor(t[1],t[2],t[3],1)
elseif i.hovered then
i.lbl:SetTextColor(o[1],o[2],o[3],0.95)
else
i.lbl:SetTextColor(o[1],o[2],o[3],0.55)
end
end
a:SetColorTexture(t[1],t[2],t[3],1)
s:SetVertexColor(t[1],t[2],t[3],0.45)
end
e.paintTabs=n
e.onTheme(n)
e.setActiveTab=function(s)
local d=e.currentTab
e.currentTab=s
e.closeAllDropdowns()
for a,t in ipairs(h)do
if a==s then
t.content:SetAlpha(0)
t.content:Show()
e.tween(t.content,0,1,0.18,function(e)t.content:SetAlpha(e)end)
else
t.content:Hide()
end
end
n()
local h,n=l(s)
if d~=s and t:IsVisible()and o>0 then
local t,s=i,o
e.tween(a,0,1,0.22,function(e)
i,o=t+(h-t)*e,s+(n-s)*e
r()
end)
else
e.stopTween(a)
i,o=h,n
r()
end
if PlaySound and d~=s and t:IsVisible()then pcall(PlaySound,841)end
if e.updateStickDisplay then e.updateStickDisplay()end
if e.updateKeyBindDisplay then e.updateKeyBindDisplay()end
end
for o,a in ipairs(h)do
a.btn:SetScript("OnClick",function()e.setActiveTab(o)end)
a.btn:SetScript("OnEnter",function()a.hovered=true;n()end)
a.btn:SetScript("OnLeave",function()a.hovered=false;n()end)
end
t:HookScript("OnShow",function()
e.stopTween(a)
i,o=l(e.currentTab)
r()
end)
e.setActiveTab(1)

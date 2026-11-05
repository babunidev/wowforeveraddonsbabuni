--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local G,e=...
local a=e.CFG
local x=e.EMOTES
local H=math.pi*2
local W=math.pi/2
local r=math.cos
local l=math.sin
local K=math.sqrt
local w=math.floor
local k=math.max
local V=math.atan2
local h,m=e.WHEEL_EXTENT,e.HUB_EXTENT
local L=e.mix
local v=0
e.textOnly=false
local f=4
local function g(e)return w((e or a.wheelRadius)*0.30+0.5)end
local function D(t)return w(t*0.26+0.5)end
e.hubRadiusFor=D
local U=1.085
local d=1
e.wheelPage=d
local b
local j
local c=false
local y=false
local u=false
local n=nil
local S=false
local R=0
local i=0
e.lastAttemptedEmote=nil
local t=CreateFrame("Frame")
local o=false
local function s(t)
local a=(Ambiguate and Ambiguate(t,"none"))or t
return t==""or a==UnitName("player")
end
e.isSelfChatSender=s
t:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
t:RegisterEvent("CHAT_MSG_EMOTE")
t:SetScript("OnEvent",function(t,t,t,e)
if not o and s(e)then
o=true
end
end)
local function N()
if v<1 then return end
local t=GetTime()
if t-i<1.0 then return end
i=t
local t=x[(d-1)*a.numSlices+v]
if not t then return end
e.lastAttemptedEmote=t.name
e.sewPrint("Attempting emote: "..t.name,"debug")
o=false
local n,i
local a
if t.cmd then
n,i=pcall(DoEmote,t.cmd)
a="CHAT_MSG_TEXT_EMOTE"
elseif t.text then
n,i=pcall(SendChatMessage,t.text,"EMOTE")
a="CHAT_MSG_EMOTE"
else
return
end
if not n then
e.sewPrint("Emote failed: "..t.name.." - "..tostring(i),"warn")
else
local t=t.name
C_Timer.After(1.0,function()
if o then
e.sewPrint("PASS (confirmed via "..a.."): "..t,"debug")
else
e.sewPrint("FAIL (no confirming event - likely silently blocked): "..t,"debug")
end
end)
end
end
local function p(a)
local t=e.SLOT_EMOTICONS[a]
if t==false then return nil end
if t then return e.EMOTICON_BY_ID[t]end
local t=x[a]
if not t then return nil end
local t=e.EMOTICON_ID_BY_NAME[t.name]or(t.cmd and e.EMOTICON_ID_BY_CMD[t.cmd])
return e.EMOTICON_BY_ID[t]
end
e.getSlotEmoticon=p
e.faces={}
local M=H/a.numSlices
local function s(e)return(e-1)*M+M/2 end
local function i(n,e,o)
e.h=o
local t=a.col
local a,i=L(t.labelHot,t.wheelBorder,0.5),t.labelHot
e.wedge:SetVertexColor(a[1],a[2],a[3],0.85*o)
e.flare:SetVertexColor(i[1],i[2],i[3],0.95*o)
local t=L(t.labelNorm,t.labelHot,math.max(o,n.selected==e.index and 0.7 or 0))
local a=n.fade or 1
e.lbl:SetTextColor(t[1],t[2],t[3],a)
e.icon:SetVertexColor(t[1],t[2],t[3],a)
local t=o>=0.5
if t~=e.big then
e.big=t
local a=e.lbl:GetFont()
if a then e.lbl:SetFont(a,e.baseSize+(t and 2 or 0),"")end
end
local t=n.iconSize+f*o
e.icon:SetSize(t,t)
end
local t={}
t.__index=t
function t:layout(t)
self.radius=t
local o=self.frame
local a=2*h*t
for t,e in ipairs(self.wheelLayers)do e:SetSize(a,a)end
self.shadow:SetPoint("CENTER",o,"CENTER",0,-k(2,w(t*0.035+0.5)))
self.bgTex:SetSize(2*t,2*t)
self.iconSize=g(t)
local i=w(t*0.6632+0.5)
local n=math.max(0.9,math.min(1.3,t/95))
for h,e in ipairs(self.slices)do
local t=e.lbl:GetFont()
e.baseSize=w(e.templateSize*n+0.5)
if t then e.lbl:SetFont(t,e.baseSize+(e.big and 2 or 0),"")end
e.wedge:SetSize(a,a)
e.flare:SetSize(a,a)
local t=s(h)
local t,a=l(t)*i,r(t)*i
e.lbl:ClearAllPoints()
e.lbl:SetPoint("CENTER",o,"CENTER",t,a)
e.icon:ClearAllPoints()
e.icon:SetPoint("CENTER",o,"CENTER",t,a)
local t=self.iconSize+f*e.h
e.icon:SetSize(t,t)
end
local e=self.hub
local t=D(t)
local a=2*m*t
for o,t in ipairs(e.layers)do t:SetSize(a,a)end
e.shadow:SetPoint("CENTER",e,"CENTER",0,-1.5)
e.fill:SetSize(2*h*t,2*h*t)
e.icon:SetSize(2*t,2*t)
end
function t:paint(t)
local e,a,o=t.wheelBorder,t.wheelBg,t.spoke
self.shadow:SetVertexColor(0,0,0,0.75)
self.glow:SetVertexColor(e[1],e[2],e[3],0.18)
self.disc:SetVertexColor(a[1],a[2],a[3],a[4]or 1)
self.shade:SetVertexColor(0,0,0,1)
local a=t.labelNorm
self.sheen:SetVertexColor(a[1],a[2],a[3],0.05)
self.lines:SetVertexColor(o[1],o[2],o[3],math.min(1,(o[4]or 1)*1.3))
self.sel:SetVertexColor(e[1],e[2],e[3],0.55)
for t,e in ipairs(self.slices)do
i(self,e,e.h)
end
self.rim:SetVertexColor(e[1],e[2],e[3],1)
self.rimSpec:SetVertexColor(1,1,1,0.15)
local t,a=self.hub,t.innerCircle
t.shadow:SetVertexColor(0,0,0,0.8)
t.fill:SetVertexColor(a[1],a[2],a[3],1)
t.inner:SetVertexColor(0,0,0,0.9)
t.ring:SetVertexColor(e[1],e[2],e[3],1)
t.spec:SetVertexColor(1,1,1,0.5)
end
function t:setHot(t)
if t==self.hot then return end
local a=self.hot
self.hot=t
if a>0 then
local t=self.slices[a]
e.tween(t,t.h,0,0.22,function(e)i(self,t,e)end)
end
if t>0 then
local t=self.slices[t]
e.tween(t,t.h,1,0.10,function(e)i(self,t,e)end)
end
end
function t:setSelected(t)
local a=self.selected
self.selected=t
for t,e in ipairs({a,t})do
local e=self.slices[e]
if e then i(self,e,e.h)end
end
if t<1 then self.sel:Hide();return end
local t=s(t)
self.sel:Show()
if not self.selAngle or not self.frame:IsVisible()then
e.stopTween(self.sel)
self.selAngle=t
e.rotateTexture(self.sel,t)
return
end
local a=self.selAngle
local t=(t-a)%H
if t>math.pi then t=t-H end
e.tween(self.sel,a,a+t,0.25,function(t)
self.selAngle=t
e.rotateTexture(self.sel,t)
end)
end
function t:renderSlice(t,o)
local t=self.slices[t]
local a=x[o]
t.lbl:SetText(a and a.name or"")
local e=a and not e.textOnly and p(o)
if e then
t.icon:SetTexture(e.file)
t.icon:Show()
t.lbl:Hide()
else
t.icon:Hide()
t.lbl:Show()
end
end
function t:render(t)
local o=(d-1)*a.numSlices
for e=1,a.numSlices do self:renderSlice(e,o+e)end
if t and self.frame:IsVisible()then
e.tween(self.slices,0,1,0.22,function(e)
self.fade=e
for t,e in ipairs(self.slices)do i(self,e,e.h)end
end)
end
end
function t:setIcon(e)
self.hub.icon:SetTexture(e)
end
function e.buildWheelFace(o,r)
local t=setmetatable({frame=o,slices={},hot=0,selected=0},t)
local function i(s,i,n,a)
local e=e.artTexture(o,s,i,n,a)
e:SetPoint("CENTER",o,"CENTER",0,0)
return e
end
t.shadow=i("wheel_shadow","BACKGROUND",-8)
t.glow=i("wheel_glow","BACKGROUND",-7,"ADD")
t.disc=i("wheel_disc","BACKGROUND",-6)
t.bgTex=e.addBgTexture(o,"BACKGROUND",-5)
t.bgTex:ClearAllPoints()
t.bgTex:SetPoint("CENTER",o,"CENTER",0,0)
e.addCircleMask(t.bgTex,o)
t.shade=i("wheel_shade","BORDER",0)
t.sheen=i("wheel_sheen","BORDER",1,"ADD")
t.lines=i("wheel_lines","BORDER",2)
t.sel=i("wheel_wedge","ARTWORK",0,"ADD")
t.sel:Hide()
t.rim=i("wheel_rim","ARTWORK",3)
t.rimSpec=i("wheel_rim_spec","ARTWORK",4,"ADD")
t.wheelLayers={t.shadow,t.glow,t.disc,t.shade,t.sheen,t.lines,
t.sel,t.rim,t.rimSpec}
for a=1,a.numSlices do
local h=i("wheel_wedge","ARTWORK",1,"ADD")
e.rotateTexture(h,s(a))
local n=i("wheel_flare","ARTWORK",5,"ADD")
e.rotateTexture(n,s(a))
local i=o:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
e.shadowText(i,1)
local o=o:CreateTexture(nil,"OVERLAY")
o:Hide()
local s,e=i:GetFont()
t.slices[a]={lbl=i,icon=o,wedge=h,flare=n,h=0,
baseSize=e or 10,templateSize=e or 10,big=false,index=a}
end
local a=CreateFrame("Frame",nil,o)
a:SetPoint("CENTER",o,"CENTER",0,0)
a:SetSize(1,1)
a:SetFrameLevel(o:GetFrameLevel()+3)
a.shadow=e.artTexture(a,"hub_shadow","BACKGROUND",1)
a.fill=e.artTexture(a,"wheel_disc","BORDER",0)
a.icon=a:CreateTexture(nil,"ARTWORK",nil,0)
a.icon:SetTexCoord(0.08,0.92,0.08,0.92)
a.inner=e.artTexture(a,"hub_inner","ARTWORK",1)
a.ring=e.artTexture(a,"hub_ring","OVERLAY",0)
a.spec=e.artTexture(a,"hub_ring_spec","OVERLAY",1,"ADD")
for o,t in ipairs({a.shadow,a.fill,a.icon,a.inner,a.ring,a.spec})do
t:SetPoint("CENTER",a,"CENTER",0,0)
end
e.addCircleMask(a.icon,a)
a.layers={a.shadow,a.inner,a.ring,a.spec}
t.hub=a
local a=t.glow:CreateAnimationGroup()
local i=a:CreateAnimation("Alpha")
local n=false
if n then
i:SetFromAlpha(0.55)
i:SetToAlpha(1.0)
i:SetDuration(2.6)
i:SetSmoothing("IN_OUT")
a:SetLooping("BOUNCE")
end
local function i()
if n and not a:IsPlaying()then a:Play()end
end
o:HookScript("OnShow",i)
i()
t:layout(r)
e.onTheme(function(e)t:paint(e)end)
table.insert(e.faces,t)
return t
end
local f={
[0]="LEFT",[1]="BOTTOMLEFT",[2]="BOTTOM",[3]="BOTTOMRIGHT",[4]="RIGHT",
[-1]="TOPLEFT",[-2]="TOP",[-3]="TOPRIGHT",[-4]="RIGHT",
}
local i
local function t()
if i then i:Hide()end
end
local Y
local q
local function F()
if v<1 or not e.wheel:IsShown()then t();return end
if not Y[v].icon:IsShown()then t();return end
local o=x[(d-1)*a.numSlices+v]
if not o then t();return end
local t=s(v)
local t=W-t
local n=w(V(l(t),r(t))/(W/2)+0.5)
local a=a.wheelRadius*U+6
i.text:SetText(o.name)
i:SetWidth(i.text:GetStringWidth()+26)
i:ClearAllPoints()
i:SetPoint(f[n],e.wheel,"CENTER",r(t)*a,l(t)*a)
if not i:IsShown()then
i:SetAlpha(0)
i:Show()
e.tween(i,0,1,0.12,function(e)i:SetAlpha(e)end)
end
end
local function k(t)
if t==v then return end
v=t
q:setHot(t)
F()
end
e.setActiveSlice=k
local function f()
k(0)
if e.wheel.EnableGamePadStick then e.wheel:EnableGamePadStick(false)end
e.wheel:Hide()
end
local function T()
e.wheel:ClearAllPoints()
e.wheel:SetPoint("CENTER",e.trigger,"CENTER")
e.wheel:Show()
if e.wheel.EnableGamePadStick then e.wheel:EnableGamePadStick(true)end
end
e.trigger=CreateFrame("Button",nil,UIParent)
local t=e.trigger
t:SetSize(a.triggerSize,a.triggerSize)
t:SetPoint("CENTER",UIParent,"CENTER",0,0)
t:SetFrameStrata("MEDIUM")
t:EnableMouse(true)
t:SetMovable(true)
local s=w(a.triggerSize/2/1.17+0.5)
local o=2*m*s
local l=e.artTexture(t,"hub_shadow","BACKGROUND",-2)
l:SetSize(o,o)
l:SetPoint("CENTER",t,"CENTER",0,-2)
local r=e.artTexture(t,"ring_glow","BACKGROUND",-1,"ADD")
r:SetSize(o*1.08,o*1.08)
r:SetPoint("CENTER")
local z=e.artTexture(t,"wheel_disc","BORDER",0)
z:SetSize(2*h*s,2*h*s)
z:SetPoint("CENTER")
local g=e.artTexture(t,"wheel_disc","BORDER",1)
g:SetSize(2*h*s,2*h*s)
g:SetPoint("CENTER")
local p=t:CreateTexture(nil,"ARTWORK",nil,0)
p:SetSize(2*s,2*s)
p:SetPoint("CENTER")
p:SetTexture("Interface\\Icons\\Ability_Warrior_Warcry")
p:SetTexCoord(0.1,0.9,0.1,0.9)
e.addCircleMask(p,t)
local m=e.artTexture(t,"hub_inner","ARTWORK",1)
m:SetSize(o,o)
m:SetPoint("CENTER")
local s=e.artTexture(t,"hub_ring","OVERLAY",0)
s:SetSize(o,o)
s:SetPoint("CENTER")
local h=e.artTexture(t,"hub_ring_spec","OVERLAY",1,"ADD")
h:SetSize(o,o)
h:SetPoint("CENTER")
local o=false
local _=0
local function C(t)
t=t or a.col
local a,i,t,n=t.wheelBorder,t.innerCircle,t.centerInner,t.labelHot
l:SetVertexColor(0,0,0,0.75)
z:SetVertexColor(i[1],i[2],i[3],1)
g:SetVertexColor(t[1],t[2],t[3],t[4]or 0.4)
m:SetVertexColor(0,0,0,0.85)
if o then
local e=L(a,{0.5,0.5,0.5},0.8)
s:SetVertexColor(e[1],e[2],e[3],1)
else
s:SetVertexColor(a[1],a[2],a[3],1)
end
h:SetVertexColor(1,1,1,0.5)
r:SetVertexColor(n[1],n[2],n[3],0.9*_)
end
e.onTheme(C)
local function B(t)
e.tween(r,_,t and 1 or 0,t and 0.15 or 0.35,function(e)_=e;C()end)
end
local g=false
local _=false
local E="You can't emote while dead."
local A="Emotes are blocked during boss encounters."
local O="Emotes are blocked in Battlegrounds and Arenas."
local I="Emotes are blocked during Mythic+ Dungeons."
local m=false
local l=false
local r=false
local s=false
local z=847
local function h(t)
e.sewPrint(t,"warn")
PlaySound(z)
end
local function z()
if g or not _ then return end
if IsShiftKeyDown()then
SetCursor("Interface/cursor/ui-cursor-move.blp")
else
SetCursor(nil)
end
end
local P=CreateFrame("Frame")
P:RegisterEvent("MODIFIER_STATE_CHANGED")
P:SetScript("OnEvent",z)
t:SetScript("OnEnter",function(e)
_=true
z()
B(not o)
GameTooltip:SetOwner(e,"ANCHOR_RIGHT")
GameTooltip:ClearLines()
GameTooltip:AddLine("Stryk's Emote Wheel",1,0.82,0,1)
GameTooltip:AddLine(" ")
if l then
GameTooltip:AddLine(E,1,0.3,0.3,1)
elseif m then
GameTooltip:AddLine(A,1,0.3,0.3,1)
elseif r then
GameTooltip:AddLine(O,1,0.3,0.3,1)
elseif s then
GameTooltip:AddLine(I,1,0.3,0.3,1)
else
GameTooltip:AddLine("|cFFE5D198Left Click|r  Open / Close",1,1,1,1)
GameTooltip:AddLine("|cFFE5D198Shift + Drag|r  Reposition",1,1,1,1)
GameTooltip:AddLine("|cFFE5D198Right Click|r  Settings",1,1,1,1)
end
GameTooltip:Show()
end)
t:SetScript("OnLeave",function(e)
GameTooltip:Hide()
_=false
z()
B(false)
end)
t:SetScript("OnMouseDown",function(a,e)
if e~="LeftButton"then return end
if IsShiftKeyDown()then
g=true
f()
SetCursor("Interface/cursor/ui-cursor-move.blp")
t:StartMoving()
end
end)
t:SetScript("OnMouseUp",function(o,a)
if a=="LeftButton"then
if g then
g=false
t:StopMovingOrSizing()
z()
local t,a=t:GetCenter()
local e,o=UIParent:GetCenter()
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.x=t-e
StryksEmoteWheelDB.y=a-o
return
end
if UnitIsDeadOrGhost("player")then
h(E)
return
end
if m then
h(A)
return
end
if r then
h(O)
return
end
if s then
h(I)
return
end
if e.wheel:IsShown()then f()else T()end
elseif a=="RightButton"then
local e=e.settingsPanel
if e then if e:IsShown()then e:Hide()else e:Show()end end
end
end)
local function g()
e.sewPrint("updateBlockedState: boss="..tostring(m).." dead="..tostring(l).." bg="..tostring(r).." mplus="..tostring(s),"debug")
if m or l or r or s then
e.sewPrint("updateBlockedState: desaturating icon","debug")
p:SetDesaturated(true)
o=true
if e.wheel:IsShown()then f()end
else
e.sewPrint("updateBlockedState: restoring icon","debug")
p:SetDesaturated(false)
o=false
end
C()
end
local o=CreateFrame("Frame")
o:RegisterEvent("PLAYER_ENTERING_WORLD")
o:RegisterEvent("ENCOUNTER_START")
o:RegisterEvent("ENCOUNTER_END")
o:RegisterEvent("PLAYER_DEAD")
o:RegisterEvent("PLAYER_ALIVE")
o:RegisterEvent("PLAYER_UNGHOST")
o:RegisterEvent("ADDON_ACTION_BLOCKED")
pcall(o.RegisterEvent,o,"CHALLENGE_MODE_START")
pcall(o.RegisterEvent,o,"CHALLENGE_MODE_COMPLETED")
pcall(o.RegisterEvent,o,"CHALLENGE_MODE_RESET")
o:SetScript("OnEvent",function(i,t,a,o)
if t=="ADDON_ACTION_BLOCKED"then
if a==G then
local e=e.lastAttemptedEmote and(" while attempting \""..e.lastAttemptedEmote.."\"")or""
h("Disabled by Blizzard Security Protection ("..tostring(o)..")"..e..".")
end
return
elseif t=="PLAYER_ENTERING_WORLD"then
e.sewPrint("PLAYER_ENTERING_WORLD fired","debug")
if StryksEmoteWheelDB and StryksEmoteWheelDB.playerDead then
e.sewPrint("Restored playerDead from DB","debug")
l=true
end
local a=r
local o,t=GetInstanceInfo()
r=(t=="pvp"or t=="arena")
if r and not a then
e.sewPrint("Entered Battleground/Arena ("..tostring(t)..")","debug")
elseif a and not r then
e.sewPrint("Left Battleground/Arena","debug")
end
if C_ChallengeMode and C_ChallengeMode.IsChallengeModeActive then
local t=s
s=C_ChallengeMode.IsChallengeModeActive()or false
if s and not t then
e.sewPrint("Reconciled: already in an active Mythic+ run","debug")
elseif t and not s then
e.sewPrint("Reconciled: no longer in a Mythic+ run","debug")
end
end
g()
return
elseif t=="PLAYER_ALIVE"then
C_Timer.After(1,function()
if not UnitIsDeadOrGhost("player")then
e.sewPrint("PLAYER_ALIVE confirmed alive","debug")
l=false
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.playerDead=nil
g()
end
end)
return
elseif t=="ENCOUNTER_START"then m=true
elseif t=="ENCOUNTER_END"then m=false
elseif t=="CHALLENGE_MODE_START"then
s=true
e.sewPrint("Mythic+ run started","debug")
elseif t=="CHALLENGE_MODE_COMPLETED"or t=="CHALLENGE_MODE_RESET"then
s=false
e.sewPrint("Mythic+ run ended ("..t..")","debug")
elseif t=="PLAYER_DEAD"then
l=true
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.playerDead=true
elseif t=="PLAYER_UNGHOST"then
l=false
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.playerDead=nil
end
g()
e.sewPrint(t,"debug")
end)
local o=false
local function z()
if not WorldMapFrame:IsShown()then return false end
if WorldMapFrame.IsMaximized then return WorldMapFrame:IsMaximized()and true or false end
return true
end
local function g()
if z()then
if not o then
o=true
f()
t:Hide()
if e.settingsPanel then e.settingsPanel:Hide()end
end
elseif o then
o=false
t:Show()
end
end
WorldMapFrame:HookScript("OnShow",function()
if e.settingsPanel then e.settingsPanel:Hide()end
g()
C_Timer.After(0,g)
end)
WorldMapFrame:HookScript("OnHide",g)
WorldMapFrame:HookScript("OnSizeChanged",function()
C_Timer.After(0,g)
end)
e.hideTrigger=false
e.triggerOpacity=1.0
local o=t.Show
t.Show=function(t)
if not e.hideTrigger then o(t)end
end
e.applyHideTrigger=function()
if e.hideTrigger then
t:Hide()
else
o(t)
t:SetAlpha(e.triggerOpacity)
end
end
e.applyTriggerOpacity=function()
t:SetAlpha(e.triggerOpacity)
end
t:HookScript("OnEnter",function(e)
e:SetAlpha(1.0)
end)
t:HookScript("OnLeave",function(t)
t:SetAlpha(e.triggerOpacity)
end)
local g=false
local function z(t)return w(t*U+0.5)*2+20 end
e.wheel=CreateFrame("Frame",nil,UIParent)
local o=e.wheel
o:SetSize(z(a.wheelRadius),z(a.wheelRadius))
o:SetFrameStrata("HIGH")
o:EnableMouse(true)
o:SetMovable(true)
o:Hide()
a.innerRadius=D(a.wheelRadius)
q=e.buildWheelFace(o,a.wheelRadius)
e.liveFace=q
Y=q.slices
do
local t=o:CreateAnimationGroup()
local e=t:CreateAnimation("Alpha")
if e.SetFromAlpha then
e:SetFromAlpha(0)
e:SetToAlpha(1)
end
e:SetDuration(0.12)
e:SetSmoothing("OUT")
local e=t:CreateAnimation("Scale")
if e.SetScaleFrom then
e:SetScaleFrom(0.97,0.97)
e:SetScaleTo(1,1)
elseif e.SetFromScale then
e:SetFromScale(0.97,0.97)
e:SetToScale(1,1)
end
e:SetDuration(0.14)
e:SetSmoothing("OUT")
o:HookScript("OnShow",function()
t:Stop()
t:Play()
end)
end
i=CreateFrame("Frame",nil,o)
i:SetHeight(22)
i:SetFrameLevel(o:GetFrameLevel()+20)
i:Hide()
do
local t=i:CreateTexture(nil,"BACKGROUND")
t:SetPoint("TOPLEFT",i,"TOPLEFT",1,-1)
t:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",-1,1)
local n=e.addBorder(i,0,1,"BORDER")
i.text=i:CreateFontString(nil,"OVERLAY","GameFontNormal")
i.text:SetPoint("CENTER",i,"CENTER",0,0)
e.shadowText(i.text,1)
e.onTheme(function(e)
local e,a,o=e.wheelBg,e.wheelBorder,e.labelHot
t:SetColorTexture(e[1],e[2],e[3],0.96)
n:SetColor(a[1],a[2],a[3],0.9)
i.text:SetTextColor(o[1],o[2],o[3],1)
end)
end
local P=30
local _=8
local i=12
local Q=26
local C=_+12
local G=56
local _={}
local function Y()
return w(a.wheelRadius*U+0.5)+12+i
end
local function B(e)
local t=_[e]
local n=Y()
local s=d+e
local s=s>=1 and s<=a.numWheelPages
local a=n+C/2
local i=s and(n-i-8)or(n-C/2)
t.btn:SetSize(s and G or Q,a-i)
t.btn:ClearAllPoints()
t.btn:SetPoint("CENTER",o,"CENTER",0,e*(a+i)/2)
end
b=function()
local e=a.col
local t,o,i=e.labelHot,e.spoke,e.labelNorm
for s,e in pairs(_)do
local n=d+s
local a=n>=1 and n<=a.numWheelPages
if a then
local t=e.hovered and L(t,{1,1,1},0.35)or t
e.tex:SetVertexColor(t[1],t[2],t[3],1)
else
e.tex:SetVertexColor(o[1],o[2],o[3],0.45)
end
e.glow:SetVertexColor(t[1],t[2],t[3],(a and e.hovered)and 0.6 or 0)
e.label:SetText(a and("Wheel "..n)or"")
e.label:SetTextColor(i[1],i[2],i[3],e.hovered and 1 or 0.8)
B(s)
end
end
local function U(t)
t=math.max(1,math.min(a.numWheelPages,t))
if t==d then return end
d=t
e.wheelPage=t
if StryksEmoteWheelDB then StryksEmoteWheelDB.wheelPage=t end
b()
j(true)
F()
if e.refreshWheelSlotsTab then e.refreshWheelSlotsTab()end
end
e.setWheelPage=U
e.refreshWheelDisplay=function()
b()
j()
end
local function C()U(d+1)end
local function L()U(d-1)end
local function U()
local a=Y()
for t,e in pairs(_)do
e.tex:ClearAllPoints()
e.tex:SetPoint("CENTER",o,"CENTER",0,t*a)
B(t)
e.label:ClearAllPoints()
e.label:SetPoint("CENTER",o,"CENTER",0,t*(a-i))
end
end
do
for t,i in ipairs({1,-1})do
local n=e.artTexture(o,"soft_glow","OVERLAY",0,"ADD")
n:SetSize(34,34)
local a=e.artTexture(o,"chevron","OVERLAY",1)
a:SetSize(P,P)
if i==1 then a:SetTexCoord(0,1,1,0)end
n:SetPoint("CENTER",a,"CENTER",0,0)
local t=CreateFrame("Button",nil,o)
t:SetFrameLevel(o:GetFrameLevel()+6)
t:SetScript("OnClick",(i==1)and C or L)
local o=o:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
o:SetJustifyH("CENTER")
e.shadowText(o,1)
local e={tex=a,glow=n,btn=t,label=o,hovered=false}
_[i]=e
local a="Scroll Wheel "..((i==1)and"Up"or"Down")
t:SetScript("OnEnter",function(t)
e.hovered=true
b()
GameTooltip:SetOwner(t,"ANCHOR_CURSOR")
GameTooltip:ClearLines()
GameTooltip:AddLine(a,1,1,1,1)
GameTooltip:Show()
end)
t:SetScript("OnLeave",function()
e.hovered=false
b()
GameTooltip:Hide()
end)
end
U()
end
e.onTheme(function()b()end)
j=function(t)
for a,e in ipairs(e.faces)do e:render(t)end
end
j()
local function b(t,a)
for o,e in ipairs(e.faces)do e:renderSlice(t,a)end
end
local i=false
o:SetScript("OnUpdate",function(o)
if e.slotPreviewActive then return end
local t,e=GetCursorPosition()
local n=o:GetEffectiveScale()
t,e=t/n,e/n
local o,n=o:GetCenter()
if not o then return end
local e,t=t-o,e-n
local o=K(e*e+t*t)
if o<a.innerRadius then
if not u then k(0)end
if not g then
if IsShiftKeyDown()and not i then
SetCursor("Interface/cursor/ui-cursor-move.blp")
i=true
elseif not IsShiftKeyDown()and i then
SetCursor(nil)
i=false
end
end
return
elseif o>a.wheelRadius then
if not u then k(0)end
if i and not g then
SetCursor(nil)
i=false
end
return
end
if i and not g then
SetCursor(nil)
i=false
end
local e=W-V(t,e)
if e<0 then e=e+H end
local e=w(e/M)+1
if e>a.numSlices then e=a.numSlices end
k(e)
end)
o:SetScript("OnMouseDown",function(a,e)
if e~="LeftButton"then return end
if IsShiftKeyDown()then
g=true
t:Hide()
SetCursor("Interface/cursor/ui-cursor-move.blp")
o:StartMoving()
end
end)
o:SetScript("OnMouseUp",function(n,a)
if a=="LeftButton"then
if g then
g=false
o:StopMovingOrSizing()
SetCursor(nil)
i=false
local i,n=o:GetCenter()
local a,e=UIParent:GetCenter()
local e,a=i-a,n-e
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"CENTER",e,a)
o:ClearAllPoints()
o:SetPoint("CENTER",t,"CENTER")
t:Show()
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.x=e
StryksEmoteWheelDB.y=a
return
end
if v>0 then
N()
if not y then f()end
else
f()
end
elseif a=="RightButton"then
local e=e.settingsPanel
if e then if e:IsShown()then e:Hide()else e:Show()end end
end
end)
o:EnableMouseWheel(true)
o:SetScript("OnMouseWheel",function(t,e)
if e>0 then C()else L()end
end)
e.applyThemeCore=function(t)
for o,t in pairs(t.col)do a.col[o]=t end
e.paintAll()
if e.applyBgTexture then e.applyBgTexture()end
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.theme=t.name
end
e.applyTheme=e.applyThemeCore
e.applyWheelSize=function(t)
a.wheelRadius=t
a.labelRadius=math.floor(t*0.6632+0.5)
a.innerRadius=D(t)
o:SetSize(z(t),z(t))
q:layout(t)
U()
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.wheelRadius=t
end
e.applyIconCore=function(t)
p:SetTexture(t)
p:SetDesaturated(m or l or r or s)
for a,e in ipairs(e.faces)do e:setIcon(t)end
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.icon=t
end
e.applyIcon=e.applyIconCore
e.applyEmoteCore=function(o,t)
local a=(d-1)*a.numSlices+o
x[a]=t
b(o,a)
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.emotes=StryksEmoteWheelDB.emotes or{}
if t.cmd then
StryksEmoteWheelDB.emotes[a]=t.cmd
else
for o,e in ipairs(e.CUSTOM_EMOTES)do
if e==t then
StryksEmoteWheelDB.emotes[a]="CUSTOM:"..o
break
end
end
end
end
e.applyEmote=e.applyEmoteCore
e.applyEmoticonCore=function(o,i)
local t=(d-1)*a.numSlices+o
e.SLOT_EMOTICONS[t]=i
b(o,t)
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.emoticons=StryksEmoteWheelDB.emoticons or{}
StryksEmoteWheelDB.emoticons[t]=i
end
e.applyEmoticon=e.applyEmoticonCore
e.setTextOnly=function(t)
e.textOnly=t and true or false
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.textOnly=e.textOnly or nil
j()
F()
end
local a={
"CharacterFrame","CharacterFrameModeTabs",
"PlayerSpellsFrame",
"SpellBookFrame",
"ProfessionsFrame","ProfessionsFrameBg",
"ProfessionsBookFrame",
"BankFrame",
"ContainerFrame1","ContainerFrame2","ContainerFrame3","ContainerFrame4",
"ContainerFrame5","ContainerFrame6","ContainerFrame7",
"WorldMapFrame",
"QuestLogFrame","AdventureMapFrame",
"MailFrame",
"AuctionHouseFrame",
"LFGParentFrame","TokenDetailFrame",
"CollectionsJournal","WardrobeCollectionFrame",
"DressUpFrame",
"CommunitiesFrame","FriendsFrame",
"DamageMeter",
"PlayerFrame","TargetFrame","BuffFrame",
"CompactPartyFrame","PartyFrame","CompactRaidFrameContainer",
"QuestObjectiveTracker",
"Minimap","MinimapCluster","GameTimeFrame",
"QuickJoinToastButton",
"BagsBar",
"MicroMenu",
"UtilityCooldownViewer","StanceBar","StatusTrackingBarManager",
"MainMenuBarArtFrame","MainMenuBarPerformanceBarFrame",
"GameMenuFrame","SettingsPanel",
"ChatFrame1","ChatFrame2","ChatFrame3","ChatFrame4","ChatFrame5",
"ChatFrame6","ChatFrame7","ChatFrame8","ChatFrame9","ChatFrame10",
}
local i={}
for t,e in ipairs(a)do i[e]=true end
local d={
"^ActionButton%d+$",
"^MultiBar.+Button%d+$",
"^ChatFrame",
"^ChatFrame%d+$",
"^GeneralDockManager",
}
local function o()
local function o(t)
while t do
local e=t:GetName()
if e and type(e)=="string"and i[e]then return e end
t=t:GetParent()
end
end
local function n(t)
for a,e in ipairs(d)do
if t:find(e)then return t.."(pattern:"..e..")"end
end
end
if GetMouseFoci then
for t,e in ipairs(GetMouseFoci())do
local t=e
while t do
local e=t:GetName()
if e and type(e)=="string"then
if i[e]then return e.."(focus-walk)"end
local e=n(e)
if e then return e end
end
t=t:GetParent()
end
end
for e,t in ipairs(a)do
local e=_G[t]
if e and e:IsVisible()and e:IsMouseOver()then return t end
end
end
local e=o(GetMouseFocus and GetMouseFocus())
if e then return e.."(focus-walk)"end
for e,t in ipairs(a)do
local e=_G[t]
if e and e:IsVisible()and e:IsMouseOver()then return t end
end
return nil
end
local function w()
return o()~=nil
end
local v={
GlobalFXBackgroundModelScene=true,GlobalFXMediumModelScene=true,
GlobalFXDialogModelScene=true,ContainerFrameContainer=true,
MotionSicknessFrame=true,TimerTracker=true,UIParent=true,WorldFrame=true,
ChatConfigBackgroundFrame=true,ChatConfigChatSettingsLeft=true,
ChatConfigOtherSettingsSystem=true,ChatConfigTextToSpeechMessageSettings=true,
CombatConfigMessageSourcesDoneTo=true,AddonDialogBackground=true,
HelpBrowser=true,PingSystemTutorialInset=true,AddonListInset=true,
PrivateRaidBossEmoteFrameAnchor=true,SpellActivationOverlayFrame=true,
}
local function p()
local t=o()
if t then
e.sewPrint("keybind fired and blocked by: "..t)
return true
end
local t=false
if t then
local o={}
local a={}
if EnumerateFrames then
e.sewPrint("Enumerating Frames (gonna be laggy)...","debug")
local t=EnumerateFrames()
while t do
local e=t:GetName()
local n,s=pcall(t.IsMouseOver,t)
if e and type(e)=="string"and t:IsVisible()and n and s then
if not i[e]and not v[e]then
local t=false
for o,a in ipairs(d)do
if e:find(a)then t=true;break end
end
if not t then
a[#a+1]=e.." "
end
end
o[#o+1]=e..""
end
t=EnumerateFrames(t)
end
end
local e=#a>0 and(" | unknown: "..table.concat(a," "))or""
local e=#o>0 and(" | all: "..table.concat(o," "))or""
return"open"..e
end
return nil
end
e.keyBind=nil
e.padBind=nil
e.activeInputDevice="keyboard"
e.radialMode=true
local o={
LSHIFT="SHIFT",RSHIFT="SHIFT",
LCTRL="CTRL",RCTRL="CTRL",
LALT="ALT",RALT="ALT",
}
local function d(e)
if e=="SHIFT"then return IsShiftKeyDown()
elseif e=="CTRL"then return IsControlKeyDown()
elseif e=="ALT"then return IsAltKeyDown()
else
if GetCVar then
if e==GetCVar("GamePadEmulateCtrl")then return IsControlKeyDown()end
if e==GetCVar("GamePadEmulateShift")then return IsShiftKeyDown()end
if e==GetCVar("GamePadEmulateAlt")then return IsAltKeyDown()end
end
if IsGamePadButtonDown then
local t,e=pcall(IsGamePadButtonDown,e)
if t and e then return true end
end
return IsKeyDown(e)
end
end
local a=CreateFrame("Frame","SEWKeyListener",UIParent)
a:SetSize(1,1)
a:SetPoint("CENTER")
a:SetFrameStrata("TOOLTIP")
a:EnableMouse(false)
a:EnableKeyboard(true)
a:SetPropagateKeyboardInput(true)
if a.EnableGamePadButton then a:EnableGamePadButton(true)end
a:Show()
a:SetScript("OnKeyDown",function(i,a)
if e.padTestMode then e.sewPrint("padtest OnKeyDown: "..tostring(a),"info")end
if e.wheel:IsShown()then
if a=="UP"then
C()
return
elseif a=="DOWN"then
L()
return
end
end
local i=o[a]or a
local a=nil
if e.padBind and e.padBind.key and GetCVar then
local t=(i=="CTRL"and GetCVar("GamePadEmulateCtrl"))
or(i=="SHIFT"and GetCVar("GamePadEmulateShift"))
or(i=="ALT"and GetCVar("GamePadEmulateAlt"))
if t and t~=""and t==e.padBind.key then a=t end
if not a and i==e.padBind.key then
a=i
end
end
local o=a and"controller"or"keyboard"
if o~=e.activeInputDevice then
e.activeInputDevice=o
if e.updateKeyBindDisplay then e.updateKeyBindDisplay()end
end
local o=a and e.padBind or e.keyBind
if not o or not o.key then return end
local i=a or i
if i~=o.key then return end
local i=(not o.mod)or d(o.mod)
if not i then return end
if e.debugEnabled then
p()
end
if not e.wheel:IsShown()then
if l or m or r or s then
local e=GetTime()
if e-R>=2 then
R=e
if l then h(E)
elseif m then h(A)
elseif r then h(O)
else h(I)end
end
return
end
if w()then return end
if e.radialMode then
local e,a=GetCursorPosition()
local o=UIParent:GetEffectiveScale()
e,a=e/o,a/o
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"BOTTOMLEFT",e,a)
c=true
end
T()
y=true
if a then u=true end
n=o
end
end)
local function p(d,i)
if e.wheel:IsShown()then return end
if l or m or r or s then
local e=GetTime()
if e-R>=2 then
R=e
if l then h(E)
elseif m then h(A)
elseif r then h(O)
else h(I)end
end
return
end
if w()then return end
if e.activeInputDevice~="controller"then
e.activeInputDevice="controller"
if e.updateKeyBindDisplay then e.updateKeyBindDisplay()end
end
if e.radialMode then
local a,e=GetCursorPosition()
local o=UIParent:GetEffectiveScale()
a,e=a/o,e/o
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"BOTTOMLEFT",a,e)
c=true
end
T()
y=true
u=i
n=d
end
local function o(e)
N()
f()
if c then
local a=StryksEmoteWheelDB and StryksEmoteWheelDB.x or 0
local e=StryksEmoteWheelDB and StryksEmoteWheelDB.y or 0
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"CENTER",a,e)
end
y=false
c=false
u=false
n=nil
end
a:SetScript("OnUpdate",function(a)
local a=e.padBind
if a and a.index and not e.capturingBind then
local e=e.getMappedStateButtons()
local e=e and(e[a.index]and true or false)or false
if e and not S then
local e=(not a.mod)or d(a.mod)
if e then p(a,true)end
elseif not e and S then
if u and n==a then o(a)end
end
S=e
else
S=false
end
if not y then return end
if not(n and n.key)then
y=false;n=nil;return
end
if n.index then return end
if not d(n.key)then
N()
f()
if c then
local e=StryksEmoteWheelDB and StryksEmoteWheelDB.x or 0
local a=StryksEmoteWheelDB and StryksEmoteWheelDB.y or 0
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"CENTER",e,a)
end
y=false
c=false
n=nil
end
end)
pcall(function()a:RegisterEvent("GAMEPAD_DISCONNECTED")end)
a:SetScript("OnEvent",function(o,a)
if a=="GAMEPAD_DISCONNECTED"then
if u then
f()
if c then
local e=StryksEmoteWheelDB and StryksEmoteWheelDB.x or 0
local a=StryksEmoteWheelDB and StryksEmoteWheelDB.y or 0
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"CENTER",e,a)
end
y=false
c=false
u=false
n=nil
end
e.activeInputDevice="keyboard"
if e.updateKeyBindDisplay then e.updateKeyBindDisplay()end
end
end)
a:SetScript("OnGamePadButtonDown",function(a,o)
if e.padTestMode then e.sewPrint("padtest OnGamePadButtonDown: "..tostring(o),"info")end
if e.activeInputDevice~="controller"then
e.activeInputDevice="controller"
if e.updateKeyBindDisplay then e.updateKeyBindDisplay()end
end
local a=e.padBind
if not a or not a.key then return end
if o~=a.key then return end
local o=(not a.mod)or d(a.mod)
if not o then return end
if not e.wheel:IsShown()then
if w()then return end
if e.radialMode then
local a,e=GetCursorPosition()
local o=UIParent:GetEffectiveScale()
a,e=a/o,e/o
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"BOTTOMLEFT",a,e)
c=true
end
T()
y=true
u=true
n=a
end
end)
a:SetScript("OnGamePadButtonUp",function(a,e)
if not u then return end
if not n or e~=n.key then return end
N()
f()
if c then
local a=StryksEmoteWheelDB and StryksEmoteWheelDB.x or 0
local e=StryksEmoteWheelDB and StryksEmoteWheelDB.y or 0
t:ClearAllPoints()
t:SetPoint("CENTER",UIParent,"CENTER",a,e)
end
y=false
c=false
u=false
n=nil
end)
e.updatePadOverrideBinding=function()end

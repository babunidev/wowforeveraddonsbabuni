--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
local t=e.tab3Content
local i=e.CELL_H
local a=e.MARGIN
local o=300
local h=a
local c=e.CONTENT_W-a-o
e.addSectionHeader(t,"Open the Wheel",h,-6,o)
e.addSectionHeader(t,"Trigger Button",c,-6,o)
local s=150
local function d(r,d,n)
local a=e.createIconButton(t,"close",i,12)
a:SetPoint("TOPRIGHT",t,"TOPLEFT",h+o,n)
local s=e.createButton(t,"",s,i+2,{keycap=true,template="GameFontNormal"})
local o=e.addRow(t,r,h,n,o)
s:SetPoint("TOPRIGHT",a,"TOPLEFT",-4,1)
local e=e.createText(t,d,"dim","GameFontNormalSmall")
e:SetPoint("TOPLEFT",t,"TOPLEFT",h,n-i-8)
a:HookScript("OnEnter",function(e)
GameTooltip:SetOwner(e,"ANCHOR_RIGHT")
GameTooltip:SetText("Clear")
GameTooltip:Show()
end)
a:HookScript("OnLeave",function()GameTooltip:Hide()end)
return s,a,o
end
local r,g=d("Keyboard","Ctrl, Alt or Shift can be part of it",-36)
local d,k=d("Controller","LB or LT can be part of it",-96)
local b,w=r.label,d.label
local i={
CTRL="Ctrl",SHIFT="Shift",ALT="Alt",
PADLSHOULDER="LB",PADRSHOULDER="RB",
PADLTRIGGER="LT",PADRTRIGGER="RT",
PADLSTICK="LS",PADRSTICK="RS",
}
local function n(t)
if not t or not t.key then return"Not Bound"end
local a=(t.mod~="")and t.mod or nil
local a=a and((i[a]or a).." + ")or""
local t=i[t.key]or t.key
return a..t
end
e.updateKeyBindDisplay=function()
b:SetText(n(e.keyBind))
w:SetText(n(e.padBind))
local t=e.activeInputDevice~="controller"
r:SetActive(t and e.keyBind~=nil)
d:SetActive((not t)and e.padBind~=nil)
end
e.updateKeyBindDisplay()
local a=CreateFrame("Frame",nil,UIParent)
a:SetSize(1,1)
a:SetPoint("CENTER")
a:EnableMouse(false)
a:EnableKeyboard(true)
a:SetPropagateKeyboardInput(false)
if a.EnableGamePadButton then a:EnableGamePadButton(true)end
a:Hide()
local p={
LSHIFT="SHIFT",RSHIFT="SHIFT",
LCTRL="CTRL",RCTRL="CTRL",
LALT="ALT",RALT="ALT",
}
local v={
PADLSHOULDER=true,
PADLTRIGGER=true,
}
local i=nil
local n="keyboard"
local l={}
local function s(t,n,o)
local i=t.label
if n then
local n,h=t.textAlpha or 1,o and 0.35 or 1
e.tween(i,n,h,0.45,function(e)t.textAlpha=e;t.paint()end,function()
if a:IsShown()then s(t,true,not o)end
end)
else
e.stopTween(i)
t.textAlpha=1
t.paint()
end
end
local function m()
i=nil
e.capturingBind=false
a:Hide()
s(r,false)
s(d,false)
e.updateKeyBindDisplay()
end
local function f()
if not C_GamePad then return nil end
if C_GamePad.GetAllDeviceIDs then
for t,e in ipairs(C_GamePad.GetAllDeviceIDs())do
if e and e~=0 then
local e=C_GamePad.GetDeviceMappedState and C_GamePad.GetDeviceMappedState(e)
if e and e.buttons then return e.buttons end
end
end
end
local e=C_GamePad.GetActiveDeviceID and C_GamePad.GetActiveDeviceID()
if e and e~=0 then
local e=C_GamePad.GetDeviceMappedState and C_GamePad.GetDeviceMappedState(e)
return e and e.buttons
end
end
local function y()
local e=f()
if e then
for e,t in pairs(e)do
l[e]=l[e]or t
end
end
end
local function u(o,t,i)
if n=="controller"then
e.padBind={key=o,mod=t,index=i}
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.padBind=e.padBind
if e.updatePadOverrideBinding then e.updatePadOverrideBinding()end
e.sewPrint("Controller bind set: key="..tostring(o).." mod="..tostring(t).." index="..tostring(i),"debug")
else
e.keyBind={key=o,mod=t}
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.keyBind=e.keyBind
end
m()
end
a:SetScript("OnKeyDown",function(e,t)
if t=="UNKNOWN"then return end
if t=="ESCAPE"then
m()
return
end
local e=p[t]
if e then
if n=="controller"and GetCVar then
local e=(e=="CTRL"and GetCVar("GamePadEmulateCtrl"))
or(e=="SHIFT"and GetCVar("GamePadEmulateShift"))
or(e=="ALT"and GetCVar("GamePadEmulateAlt"))
if e and e~=""then
y()
i=e
end
return
end
i=e
return
end
if n=="controller"then return end
u(t,i)
end)
a:SetScript("OnKeyUp",function(a,t)
local t=p[t]
if not t then return end
if n=="controller"and GetCVar then
local e=(t=="CTRL"and GetCVar("GamePadEmulateCtrl"))
or(t=="SHIFT"and GetCVar("GamePadEmulateShift"))
or(t=="ALT"and GetCVar("GamePadEmulateAlt"))
if e and e~=""and e==i then
u(e,nil)
return
end
end
if t==i then
if t=="SHIFT"and n=="keyboard"then
e.sewPrint("Shift alone can't be bound to open the wheel - it conflicts with Shift+Drag repositioning. Try Shift plus another key.","warn")
m()
return
end
u(t,nil)
end
end)
a:SetScript("OnGamePadButtonDown",function(t,e)
if n=="keyboard"then return end
if v[e]then
y()
i=e
return
end
local t=nil
local a=f()
if a then
for e,a in pairs(a)do
if a and not l[e]then
t=e
break
end
end
end
u(e,i,t)
end)
a:SetScript("OnGamePadButtonUp",function(t,e)
if n=="keyboard"then return end
if v[e]and e==i then
u(e,nil)
end
end)
t:HookScript("OnHide",function()
if a:IsShown()then m()end
end)
r:SetScript("OnClick",function()
n="keyboard"
i=nil
b:SetText("Press a key...")
s(d,false)
s(r,true)
a:Show()
end)
g:SetScript("OnClick",function()
e.keyBind=nil
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.keyBind=nil
e.updateKeyBindDisplay()
end)
d:SetScript("OnClick",function()
n="controller"
i=nil
w:SetText("Press a button...")
l={}
local t=f()
if t then
for t,e in pairs(t)do l[t]=e end
end
e.capturingBind=true
s(r,false)
s(d,true)
a:Show()
end)
k:SetScript("OnClick",function()
e.padBind=nil
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.padBind=nil
if e.updatePadOverrideBinding then e.updatePadOverrideBinding()end
e.updateKeyBindDisplay()
end)
local a=-158
if e.buildControllerStickPicker and e.buildControllerStickPicker(t,h,a,o)then
a=a-40
end
local i=e.createToggle(t,function(t)
e.radialMode=t
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.radialMode=e.radialMode
end)
e.addRow(t,"Snap to Cursor",h,a,o,i,
"A keybind opens the wheel where your cursor is")
i:SetPoint("TOPRIGHT",t,"TOPLEFT",h+o,a-2)
e.updateRadialCheckbox=function()
i:SetChecked(e.radialMode or false,true)
end
e.updateRadialCheckbox()
local n
local m=e.createToggle(t,function(t)
e.hideTrigger=t
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.hideTrigger=e.hideTrigger
n:SetEnabled(not e.hideTrigger)
if e.applyHideTrigger then e.applyHideTrigger()end
if e.refreshTriggerPreview then e.refreshTriggerPreview()end
end)
e.addRow(t,"Hide Trigger",c,-36,o,m,"/sew show brings it back")
m:SetPoint("TOPRIGHT",t,"TOPLEFT",c+o,-38)
n=e.createSlider(t,164,0,100,5,
function(e)return e.."%"end,
function(t)
e.triggerOpacity=t/100
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.triggerOpacity=e.triggerOpacity
if e.applyTriggerOpacity then e.applyTriggerOpacity()end
if e.refreshTriggerPreview then e.refreshTriggerPreview()end
end)
e.addRow(t,"Opacity",c,-96,o,n,"Hovering it always shows it fully")
n:SetDisplayValue(math.floor((e.triggerOpacity or 1.0)*100+0.5))
local i=30
local w=c+o/2
local f=-224
local a=CreateFrame("Frame",nil,t)
a:SetSize(i*4,i*4)
a:SetPoint("CENTER",t,"TOPLEFT",w,f)
local o=2*e.HUB_EXTENT*i
local h=e.artTexture(a,"ring_glow","BACKGROUND",0,"ADD")
h:SetSize(o*1.08,o*1.08)
h:SetPoint("CENTER")
local u=e.artTexture(a,"hub_shadow","BACKGROUND",1)
u:SetSize(o,o)
u:SetPoint("CENTER",a,"CENTER",0,-3)
local d=e.artTexture(a,"wheel_disc","BORDER",0)
d:SetSize(2*e.WHEEL_EXTENT*i,2*e.WHEEL_EXTENT*i)
d:SetPoint("CENTER")
local s=a:CreateTexture(nil,"ARTWORK",nil,0)
s:SetSize(2*i,2*i)
s:SetPoint("CENTER")
s:SetTexCoord(0.1,0.9,0.1,0.9)
e.addCircleMask(s,a)
local l=e.artTexture(a,"hub_inner","ARTWORK",1)
l:SetSize(o,o)
l:SetPoint("CENTER")
local c=e.artTexture(a,"hub_ring","OVERLAY",0)
c:SetSize(o,o)
c:SetPoint("CENTER")
local r=e.artTexture(a,"hub_ring_spec","OVERLAY",1,"ADD")
r:SetSize(o,o)
r:SetPoint("CENTER")
do
local t=h:CreateAnimationGroup()
local e=t:CreateAnimation("Alpha")
if e.SetFromAlpha then
e:SetFromAlpha(0.25)
e:SetToAlpha(0.8)
e:SetDuration(2.2)
e:SetSmoothing("IN_OUT")
t:SetLooping("BOUNCE")
a:SetScript("OnShow",function()if not t:IsPlaying()then t:Play()end end)
end
end
e.onTheme(function(e)
local t,a,e=e.wheelBorder,e.innerCircle,e.labelHot
h:SetVertexColor(e[1],e[2],e[3],0.8)
u:SetVertexColor(0,0,0,0.75)
d:SetVertexColor(a[1],a[2],a[3],1)
l:SetVertexColor(0,0,0,0.85)
c:SetVertexColor(t[1],t[2],t[3],1)
r:SetVertexColor(1,1,1,0.5)
end)
local o=e.createText(t,"","hot","GameFontNormal")
o:SetPoint("TOP",t,"TOPLEFT",w,f-i-22)
local h={
"Left-click: open or close the wheel",
"Shift + drag: move it",
"Right-click: these settings",
}
local i=o
for o,a in ipairs(h)do
local e=e.createText(t,a,"dim","GameFontNormalSmall")
e:SetPoint("TOP",i,"BOTTOM",0,-5)
i=e
end
e.refreshTriggerPreview=function()
if e.hideTrigger then
a:SetAlpha(0.25)
o:SetText("Hidden")
else
a:SetAlpha(math.max(0.08,e.triggerOpacity or 1.0))
o:SetText(math.floor((e.triggerOpacity or 1.0)*100+0.5).."% opacity")
end
end
do
local t=e.applyIcon
e.applyIcon=function(e)
t(e)
s:SetTexture(e)
end
end
e.updateHideTriggerCheckbox=function()
m:SetChecked(e.hideTrigger or false,true)
n:SetEnabled(not e.hideTrigger)
e.refreshTriggerPreview()
end
e.updateHideTriggerCheckbox()
e.updateOpacitySlider=function()
n:SetDisplayValue(math.floor((e.triggerOpacity or 1.0)*100+0.5))
e.refreshTriggerPreview()
end

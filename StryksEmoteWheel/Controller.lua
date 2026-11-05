--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
local a=e.CFG
local i=math.pi*2
local s=math.pi/2
local r=math.floor
local h=math.atan2
local n=i/a.numSlices
e.controllerStick=2
e.wheel:SetScript("OnGamePadStick",function(o,t,l,u,d)
if e.slotPreviewActive then return end
local t=t:lower()
local o=t:find("left")~=nil or t=="movement"
local t=t:find("right")~=nil or t=="camera"or t=="look"
if(o or t)and(o and 1 or 2)~=e.controllerStick then return end
if d>0.2 then
local t=s-h(u,l)
if t<0 then t=t+i end
local t=r(t/n)+1
if t>a.numSlices then t=a.numSlices end
e.setActiveSlice(t)
end
end)
function e.getMappedStateButtons()
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
function e.buildControllerStickPicker(t,n,i,o)
if not C_GamePad then return false end
local a=e.createSegmented(t,{"Left","Right"},150,e.CELL_H,function(t)
e.controllerStick=t
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.controllerStick=t
e.updateStickDisplay()
end)
e.addRow(t,"Controller Stick",n,i,o,a)
e.updateStickDisplay=function()
a:SetSelected(e.controllerStick==1 and 1 or 2)
end
e.updateStickDisplay()
return true
end
local d=0.1
local n=0
local t=e.createPopout("Stick Test",340,420,0,120)
local i=e.createButton(t,"Start Test",120,24)
i:SetPoint("TOPLEFT",t,"TOPLEFT",16,-54)
local s=e.createButton(t,"Stop Test",120,24)
s:SetPoint("LEFT",i,"RIGHT",8,0)
local o=e.createWell(t)
o:SetPoint("TOPLEFT",t,"TOPLEFT",16,-88)
o:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-16,16)
local a=e.createText(o,"Press Start Test to begin polling.","norm","GameFontHighlightSmall")
a:SetPoint("TOPLEFT",o,"TOPLEFT",10,-10)
a:SetPoint("RIGHT",o,"RIGHT",-10,0)
a:SetJustifyH("LEFT")
a:SetJustifyV("TOP")
local function h()
if not C_GamePad then
a:SetText("C_GamePad not available on this client.")
return
end
local e={}
if C_GamePad.GetAllDeviceIDs then
for t,a in ipairs(C_GamePad.GetAllDeviceIDs())do
local t=C_GamePad.GetDeviceMappedState and C_GamePad.GetDeviceMappedState(a)
table.insert(e,"Device id="..tostring(a)..":")
if not t or not t.sticks then
table.insert(e,"  sticks=nil")
else
for a,t in pairs(t.sticks)do
table.insert(e,string.format("  stick[%s] x=%.3f y=%.3f len=%.3f",tostring(a),t.x or 0,t.y or 0,t.len or 0))
end
end
end
end
if#e==0 then
e[1]="No gamepad devices detected."
end
a:SetText(table.concat(e,"\n"))
end
local function o()
t:SetScript("OnUpdate",nil)
i:Enable()
s:Disable()
end
local function r()
if not C_GamePad then
a:SetText("C_GamePad not available on this client.")
return
end
n=0
i:Disable()
s:Enable()
h()
t:SetScript("OnUpdate",function(t,e)
n=n+e
if n>=d then
n=0
h()
end
end)
end
i:SetScript("OnClick",r)
s:SetScript("OnClick",o)
o()
t:SetScript("OnHide",o)
function e.slashSticktest()
if t:IsShown()then
t:Hide()
else
t:Show()
end
end
function e.slashPadtest()
e.padTestMode=true
e.sewPrint("padtest ON - press buttons; polling + events logged for 10s.","info")
local t=0
local o={}
local a={
"PAD1","PAD2","PAD3","PAD4","PAD5","PAD6",
"PADLSHOULDER","PADRSHOULDER","PADLTRIGGER","PADRTRIGGER",
"PADLSTICK","PADRSTICK","PADDUP","PADDDOWN","PADDLEFT","PADDRIGHT",
}
local i={}
local n=CreateFrame("Frame")
n:SetScript("OnUpdate",function(s,n)
t=t+n
if t>=10 then
e.padTestMode=false
e.sewPrint("padtest OFF.","info")
s:SetScript("OnUpdate",nil)
return
end
if IsGamePadButtonDown then
for a,t in ipairs(a)do
local a=IsGamePadButtonDown(t)
if a and not o[t]then
e.sewPrint("padtest IsGamePadButtonDown PRESSED: "..t,"info")
elseif not a and o[t]then
e.sewPrint("padtest IsGamePadButtonDown RELEASED: "..t,"info")
end
o[t]=a
end
end
if C_GamePad and C_GamePad.GetActiveDeviceID and C_GamePad.GetDeviceMappedState then
local t=C_GamePad.GetActiveDeviceID()
if t and t~=0 then
local t=C_GamePad.GetDeviceMappedState(t)
if t and t.buttons then
for t,a in pairs(t.buttons)do
if a and not i[t]then
e.sewPrint("padtest MappedState PRESSED: ["..tostring(t).."]","info")
elseif not a and i[t]then
e.sewPrint("padtest MappedState RELEASED: ["..tostring(t).."]","info")
end
i[t]=a
end
end
end
end
end)
end

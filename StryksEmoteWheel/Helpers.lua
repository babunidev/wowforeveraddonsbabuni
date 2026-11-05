--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
local o=e.CFG
local p,v,y=math.floor,math.max,math.min
e.debugEnabled=false
e.DEBUG_LOG_MAX=500
e.debugLog={}
e.debugLock=false
function e.toggleDebugMode()
e.debugEnabled=not e.debugEnabled
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.debug=e.debugEnabled
if e.refreshDebugTab then e.refreshDebugTab()end
e.sewPrint("Debug messages "..(e.debugEnabled and"ON"or"OFF"),"info")
end
local function a(a,t)
table.insert(e.debugLog,"["..date("%H:%M:%S").."]"..a.." "..t)
while#e.debugLog>e.DEBUG_LOG_MAX do
table.remove(e.debugLog,1)
end
if e.refreshDebugLogView then e.refreshDebugLogView()end
end
function e.sewPrint(t,o)
t=tostring(t)
if o=="debug"then
a("[D]",t)
if not e.debugEnabled then return end
print("|cFFFFD700[SEW]|r "..t)
elseif o=="warn"then
a("[W]",t)
print("|cFFFF3300[SEW]|r "..t)
else
a("[I]",t)
print("|cFF4FC3F7[SEW]|r "..t)
end
end
e.ART="Interface\\AddOns\\StryksEmoteWheel\\media\\ui\\"
e.WHEEL_EXTENT=1.28
e.HUB_EXTENT=1.6
local l=e.ART
function e.setTitleFont(e,a)
e:SetFontObject(GameFontNormalLarge)
local t=GameFontNormalLarge:GetFont()or"Fonts\\FRIZQT__.TTF"
pcall(e.SetFont,e,t,a or 18,"")
end
function e.shadowText(e,t)
e:SetShadowOffset(1,-1)
e:SetShadowColor(0,0,0,t or 0.9)
end
function e.mix(e,a,t)
return{e[1]+(a[1]-e[1])*t,e[2]+(a[2]-e[2])*t,e[3]+(a[3]-e[3])*t}
end
local i=e.mix
e.DANGER={0.95,0.30,0.22}
e.themed={
painters={},
bgTextures={},
}
function e.onTheme(t)
table.insert(e.themed.painters,t)
t(o.col)
return t
end
function e.paintAll()
local a=o.col
for o,t in ipairs(e.themed.painters)do
local t,a=pcall(t,a)
if not t then e.sewPrint("Theme painter error: "..tostring(a),"debug")end
end
end
local a={}
local n=CreateFrame("Frame")
n:Hide()
local function h(e)local e=1-e;return 1-e*e*e end
n:SetScript("OnUpdate",function(s,o)
local t
for n,e in pairs(a)do
e.t=e.t+o
local i=(e.dur>0)and y(1,e.t/e.dur)or 1
local o=pcall(e.fn,e.from+(e.to-e.from)*h(i))
if i>=1 or not o then
a[n]=nil
if o and e.done then
t=t or{}
t[#t+1]=e.done
end
end
end
if t then for t,e in ipairs(t)do pcall(e)end end
if not next(a)then s:Hide()end
end)
function e.tween(e,o,t,i,s,h)
a[e]={t=0,dur=i,from=o,to=t,fn=s,done=h}
n:Show()
end
function e.stopTween(e)a[e]=nil end
function e.artTexture(o,a,e,i,t)
local e=o:CreateTexture(nil,e or"ARTWORK",nil,i or 0)
e:SetTexture(l..a,"CLAMPTOBLACKADDITIVE","CLAMPTOBLACKADDITIVE")
if t then e:SetBlendMode(t)end
return e
end
function e.setGradient(e,h,a,t,o,n,i,s,r,d)
if CreateColor and pcall(e.SetGradient,e,h,
CreateColor(a,t,o,n),CreateColor(i,s,r,d))then
return
end
if e.SetGradientAlpha then e:SetGradientAlpha(h,a,t,o,n,i,s,r,d)end
end
function e.rotateTexture(a,e)
local t,e=math.cos(e),math.sin(e)
a:SetTexCoord(
0.5-0.5*t-0.5*e,0.5+0.5*e-0.5*t,
0.5-0.5*t+0.5*e,0.5+0.5*e+0.5*t,
0.5+0.5*t-0.5*e,0.5-0.5*e-0.5*t,
0.5+0.5*t+0.5*e,0.5-0.5*e+0.5*t)
end
function e.addCircleMask(t,e)
local e=e:CreateMaskTexture()
e:SetTexture("Interface\\CHARACTERFRAME\\TempPortraitAlphaMask",
"CLAMPTOBLACKADDITIVE","CLAMPTOBLACKADDITIVE")
e:SetAllPoints(t)
t:AddMaskTexture(e)
return e
end
function e.addBorder(a,e,t,n,s)
e,t=e or 0,t or 1
local o={}
local function i()
local e=a:CreateTexture(nil,n or"BORDER",nil,s or 0)
e:SetColorTexture(1,1,1,1)
o[#o+1]=e
return e
end
local h,s,n,i=i(),i(),i(),i()
h:SetPoint("TOPLEFT",a,"TOPLEFT",e,-e)
h:SetPoint("TOPRIGHT",a,"TOPRIGHT",-e,-e)
h:SetHeight(t)
s:SetPoint("BOTTOMLEFT",a,"BOTTOMLEFT",e,e)
s:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",-e,e)
s:SetHeight(t)
n:SetPoint("TOPLEFT",a,"TOPLEFT",e,-e-t)
n:SetPoint("BOTTOMLEFT",a,"BOTTOMLEFT",e,e+t)
n:SetWidth(t)
i:SetPoint("TOPRIGHT",a,"TOPRIGHT",-e,-e-t)
i:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",-e,e+t)
i:SetWidth(t)
return{
edges=o,
SetColor=function(n,e,t,a,i)
for n,o in ipairs(o)do o:SetColorTexture(e,t,a,i)end
end,
SetShown=function(e,t)
for a,e in ipairs(o)do e:SetShown(t)end
end,
}
end
function e.addShadow(o,e,i,a)
e,i,a=e or 16,i or 0.6,a or 3
local r={}
local function t(s,n,a,t)
local e=o:CreateTexture(nil,"BACKGROUND",nil,-8)
e:SetTexture(l.."shadow9")
e:SetTexCoord(s,n,a,t)
e:SetVertexColor(0,0,0,i)
r[#r+1]=e
return e
end
local n=t(0,0.25,0,0.25)
n:SetSize(e,e)
n:SetPoint("BOTTOMRIGHT",o,"TOPLEFT",0,-a)
local h=t(0.75,1,0,0.25)
h:SetSize(e,e)
h:SetPoint("BOTTOMLEFT",o,"TOPRIGHT",0,-a)
local i=t(0,0.25,0.75,1)
i:SetSize(e,e)
i:SetPoint("TOPRIGHT",o,"BOTTOMLEFT",0,-a)
local s=t(0.75,1,0.75,1)
s:SetSize(e,e)
s:SetPoint("TOPLEFT",o,"BOTTOMRIGHT",0,-a)
local e=t(0.25,0.75,0,0.25)
e:SetPoint("BOTTOMLEFT",n,"BOTTOMRIGHT")
e:SetPoint("TOPRIGHT",h,"TOPLEFT")
local e=t(0.25,0.75,0.75,1)
e:SetPoint("TOPLEFT",i,"TOPRIGHT")
e:SetPoint("BOTTOMRIGHT",s,"BOTTOMLEFT")
local e=t(0,0.25,0.25,0.75)
e:SetPoint("TOPRIGHT",n,"BOTTOMRIGHT")
e:SetPoint("BOTTOMLEFT",i,"TOPLEFT")
local e=t(0.75,1,0.25,0.75)
e:SetPoint("TOPLEFT",h,"BOTTOMLEFT")
e:SetPoint("BOTTOMRIGHT",s,"TOPRIGHT")
return r
end
function e.getBgTextureAlpha()
return e.bgTextureAlpha or e.DEFAULT_BG_TEXTURE_ALPHA
end
function e.addBgTexture(o,a,i,t)
t=t or 2
local a=o:CreateTexture(nil,a or"BACKGROUND",nil,i or-6)
a:SetPoint("TOPLEFT",o,"TOPLEFT",t,-t)
a:SetPoint("BOTTOMRIGHT",o,"BOTTOMRIGHT",-t,t)
a:Hide()
table.insert(e.themed.bgTextures,a)
return a
end
function e.bgTextureAvailable(e)
if not e.atlas then return true end
return C_Texture~=nil and C_Texture.GetAtlasInfo~=nil
and C_Texture.GetAtlasInfo(e.atlas)~=nil
end
function e.findBgTexture(a)
for o,t in ipairs(e.BG_TEXTURES)do
if t.name==a and e.bgTextureAvailable(t)then return t end
end
end
function e.setBgTextureArt(t,e)
if e.atlas then
t:SetAtlas(e.atlas,false)
elseif e.file then
t:SetTexture(e.file,"REPEAT","REPEAT")
t:SetTexCoord(0,1,0,1)
end
end
function e.applyBgTexture(t)
local a=e.findBgTexture(t or e.bgTexture)or e.findBgTexture(e.DEFAULT_BG_TEXTURE)
local o=a~=nil and(a.atlas~=nil or a.file~=nil)
for i,t in ipairs(e.themed.bgTextures)do
if o then e.setBgTextureArt(t,a)end
if t.SetHorizTile then t:SetHorizTile(true)end
if t.SetVertTile then t:SetVertTile(true)end
t:SetAlpha(e.getBgTextureAlpha())
t:SetShown(o)
end
end
function e.skinFrame(t,n)
n=n or{}
local a={}
if n.shadow~=false then a.shadow=e.addShadow(t,14,0.45,3)end
local o=t:CreateTexture(nil,"BACKGROUND",nil,-7)
o:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
o:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
a.fill=o
if n.texture then a.bgTex=e.addBgTexture(t,"BACKGROUND",-6,2)end
local i=t:CreateTexture(nil,"BACKGROUND",nil,-5)
i:SetAllPoints(o)
i:SetColorTexture(1,1,1,1)
e.setGradient(i,"VERTICAL",0,0,0,0.42,0,0,0,0)
local i=t:CreateTexture(nil,"BACKGROUND",nil,-4)
i:SetPoint("TOPLEFT",o,"TOPLEFT")
i:SetPoint("TOPRIGHT",o,"TOPRIGHT")
i:SetHeight(y(110,(t:GetHeight()or 110)*0.5))
i:SetColorTexture(1,1,1,1)
i:SetBlendMode("ADD")
local s=e.addBorder(t,0,1,"BORDER",0)
s:SetColor(0,0,0,0.85)
local h=e.addBorder(t,1,1,"BORDER",1)
local r=e.addBorder(t,4,1,"BORDER",1)
a.gold,a.inner=h,r
local s={}
if n.corners==true then
local o=40
local e={
{"TOPLEFT",0,1,0,1},
{"TOPRIGHT",1,0,0,1},
{"BOTTOMLEFT",0,1,1,0},
{"BOTTOMRIGHT",1,0,1,0},
}
for a,e in ipairs(e)do
local a=t:CreateTexture(nil,"OVERLAY",nil,6)
a:SetTexture(l.."corner")
a:SetTexCoord(e[2],e[3],e[4],e[5])
a:SetSize(o,o)
a:SetPoint(e[1],t,e[1],0,0)
s[#s+1]=a
end
end
a.corners=s
local n=n.alpha or 0.97
e.onTheme(function(t)
local a,t=t.wheelBg,t.wheelBorder
o:SetColorTexture(a[1],a[2],a[3],n)
e.setGradient(i,"VERTICAL",t[1],t[2],t[3],0,t[1],t[2],t[3],0)
h:SetColor(t[1],t[2],t[3],0.6)
r:SetColor(t[1],t[2],t[3],0)
for a,e in ipairs(s)do e:SetVertexColor(t[1],t[2],t[3],1)end
end)
return a
end
local n={norm=1.0,label=0.86,dim=0.48}
function e.createText(a,s,t,i,o)
local a=a:CreateFontString(nil,o or"OVERLAY",i or"GameFontNormalSmall")
a:SetText(s or"")
e.shadowText(a)
t=t or"norm"
e.onTheme(function(o)
if t=="hot"then
local e=o.labelHot
a:SetTextColor(e[1],e[2],e[3],1)
elseif t=="accent"or t=="accentDim"then
local e=o.wheelBorder
a:SetTextColor(e[1],e[2],e[3],t=="accentDim"and 0.8 or 1)
else
local e=o.labelNorm
a:SetTextColor(e[1],e[2],e[3],n[t]or 1)
end
end)
return a
end
function e.createFadeLine(t,o,n)
local a=CreateFrame("Frame",nil,t)
a:SetSize(o,1)
local i,o=a:CreateTexture(nil,"ARTWORK"),a:CreateTexture(nil,"ARTWORK")
i:SetPoint("TOPLEFT",a,"TOPLEFT")
i:SetPoint("BOTTOMRIGHT",a,"BOTTOM")
o:SetPoint("TOPLEFT",a,"TOP")
o:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT")
i:SetColorTexture(1,1,1,1)
o:SetColorTexture(1,1,1,1)
e.onTheme(function(t)
local t=t.wheelBorder
e.setGradient(i,"HORIZONTAL",t[1],t[2],t[3],0,t[1],t[2],t[3],n or 0.5)
e.setGradient(o,"HORIZONTAL",t[1],t[2],t[3],n or 0.5,t[1],t[2],t[3],0)
end)
return a
end
function e.createHeader(t,o,a)
local t=CreateFrame("Frame",nil,t)
t:SetSize(a or 200,18)
local a=t:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
a:SetPoint("LEFT",t,"LEFT",0,0)
a:SetText(string.upper(o))
e.shadowText(a)
local o=t:CreateTexture(nil,"ARTWORK")
o:SetHeight(1)
o:SetPoint("LEFT",a,"RIGHT",8,0)
o:SetPoint("RIGHT",t,"RIGHT",0,0)
o:SetColorTexture(1,1,1,1)
e.onTheme(function(t)
local t,i=t.wheelBorder,t.labelHot
a:SetTextColor(i[1],i[2],i[3],1)
e.setGradient(o,"HORIZONTAL",t[1],t[2],t[3],0.55,t[1],t[2],t[3],0)
end)
t.text=a
return t
end
function e.createPlaque(t,a,n)
local t=CreateFrame("Frame",nil,t)
t:SetHeight(20)
t:Hide()
local o=t:CreateTexture(nil,"BACKGROUND")
o:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
o:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
local s=e.addBorder(t,0,1,"BORDER")
local a=t:CreateFontString(nil,"OVERLAY",a or"GameFontNormalSmall")
a:SetPoint("CENTER",t,"CENTER",0,0)
e.shadowText(a,1)
e.onTheme(function(e)
local i,t,e=e.wheelBg,e.wheelBorder,e.labelHot
o:SetColorTexture(i[1],i[2],i[3],0.96)
s:SetColor(t[1],t[2],t[3],0.9)
a:SetTextColor(e[1],e[2],e[3],1)
end)
function t:SetLabel(o)
if not o or o==""then
e.stopTween(self)
self:Hide()
return
end
a:SetText(o)
if not n then self:SetWidth(a:GetStringWidth()+26)end
if not self:IsShown()then
self:SetAlpha(0)
self:Show()
e.tween(self,0,1,0.12,function(e)self:SetAlpha(e)end)
end
end
t.text=a
return t
end
function e.createDivider(t,a)
local n={}
local o=t:CreateTexture(nil,a or"ARTWORK")
local a=t:CreateTexture(nil,a or"ARTWORK")
o:SetColorTexture(1,1,1,1)
a:SetColorTexture(1,1,1,1)
o:SetHeight(1)
a:SetHeight(1)
function n.SetPoints(h,s,n,i)
o:ClearAllPoints()
a:ClearAllPoints()
o:SetPoint("TOPLEFT",t,"TOPLEFT",s,i)
o:SetPoint("TOPRIGHT",t,"TOP",0,i)
a:SetPoint("TOPLEFT",t,"TOP",0,i)
a:SetPoint("TOPRIGHT",t,"TOPRIGHT",-n,i)
end
e.onTheme(function(t)
local t=t.wheelBorder
e.setGradient(o,"HORIZONTAL",t[1],t[2],t[3],0,t[1],t[2],t[3],0.45)
e.setGradient(a,"HORIZONTAL",t[1],t[2],t[3],0.45,t[1],t[2],t[3],0)
end)
return n
end
function e.createButton(t,l,n,a,s)
s=s or{}
local t=CreateFrame("Button",nil,t)
t:SetSize(n or 120,a or 24)
local h=t:CreateTexture(nil,"BACKGROUND",nil,0)
h:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
h:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
h:SetColorTexture(1,1,1,1)
local a=t:CreateTexture(nil,"BACKGROUND",nil,1)
a:SetAllPoints(h)
a:SetColorTexture(1,1,1,1)
e.setGradient(a,"VERTICAL",1,1,1,0,1,1,1,0.07)
local d=t:CreateTexture(nil,"BORDER",nil,0)
d:SetAllPoints(h)
d:SetColorTexture(1,1,1,1)
d:SetBlendMode("ADD")
local c=e.addBorder(t,0,1,"ARTWORK",0)
local a=t:CreateTexture(nil,"ARTWORK",nil,1)
a:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
a:SetPoint("TOPRIGHT",t,"TOPRIGHT",-1,-1)
a:SetHeight(1)
a:SetColorTexture(1,1,1,0.07)
local a
if s.keycap then
a=t:CreateTexture(nil,"ARTWORK",nil,2)
a:SetPoint("BOTTOMLEFT",t,"BOTTOMLEFT",1,1)
a:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
a:SetHeight(2)
a:SetColorTexture(0,0,0,0.45)
end
local r=t:CreateFontString(nil,"OVERLAY",s.template or"GameFontNormalSmall")
r:SetPoint("CENTER",t,"CENTER",0,s.keycap and 1 or 0)
r:SetText(l or"")
e.shadowText(r)
t.label=r
t.fill,t.edge,t.glow=h,c,d
t.hovered,t.active=false,false
local l=0
local function a(n)
n=n or o.col
local o,u,m=n.centerFill,n.spoke,n.wheelBorder
local a=s.danger and t.hovered and e.DANGER or m
local o=i(o,n.wheelBg,0.25)
if t.active then o=i(o,m,0.18)end
if t.pressed then o=i(o,{0,0,0},0.35)end
h:SetColorTexture(o[1],o[2],o[3],1)
local o=0.10+0.20*l
e.setGradient(d,"VERTICAL",a[1],a[2],a[3],o,a[1],a[2],a[3],0)
if t.hovered or t.active then
c:SetColor(a[1],a[2],a[3],0.95)
else
c:SetColor(u[1],u[2],u[3],0.75)
end
local e=(t.hovered or t.active)and(s.danger and t.hovered and e.DANGER or n.labelHot)
or(s.keycap and n.labelHot or n.labelNorm)
local a=t:IsEnabled()
r:SetTextColor(e[1],e[2],e[3],(a and 1 or 0.4)*(t.textAlpha or 1))
end
t.paint=a
e.onTheme(a)
local function o(o,i)
e.tween(t,l,o,i,function(e)l=e;a()end)
end
t:SetScript("OnEnter",function(e)
if not e:IsEnabled()then return end
e.hovered=true
a()
o(1,0.12)
end)
t:SetScript("OnLeave",function(e)
e.hovered=false
e.pressed=false
a()
o(0,0.25)
end)
t:SetScript("OnMouseDown",function(e)
if e:IsEnabled()then e.pressed=true;a()end
end)
t:SetScript("OnMouseUp",function(e)
e.pressed=false
a()
end)
t:SetScript("OnEnable",function()a()end)
t:SetScript("OnDisable",function(e)e.hovered=false;a()end)
function t:SetLabel(e)r:SetText(e)end
function t:SetActive(e)self.active=e and true or false;a()end
return t
end
function e.createThemedButton(i,o,a,t)
local e=e.createButton(i,o,a,t)
return e,e.label
end
function e.createIconButton(t,n,a,i)
local t=CreateFrame("Button",nil,t)
t:SetSize(a or 22,a or 22)
local s=e.artTexture(t,"soft_glow","BACKGROUND",0,"ADD")
s:SetPoint("CENTER")
s:SetSize((a or 22)*1.8,(a or 22)*1.8)
local n=e.artTexture(t,n,"ARTWORK")
n:SetPoint("CENTER")
n:SetSize(i or 14,i or 14)
t.icon=n
local a=0
local function i(i)
i=i or o.col
local o=t.hovered and i.labelHot or i.labelNorm
n:SetVertexColor(o[1],o[2],o[3],t.hovered and 1 or 0.7)
local t=i.labelHot
s:SetVertexColor(t[1],t[2],t[3],0.55*a)
end
e.onTheme(i)
t:SetScript("OnEnter",function()
t.hovered=true
i()
e.tween(t,a,1,0.12,function(e)a=e;i()end)
end)
t:SetScript("OnLeave",function()
t.hovered=false
i()
e.tween(t,a,0,0.25,function(e)a=e;i()end)
end)
return t
end
function e.createCloseButton(t,a)
local e=e.createIconButton(t,"close",24,16)
e:SetScript("OnClick",a or function()t:Hide()end)
return e
end
function e.createDropdown(a,t,n)
local t=e.createButton(a,"",t,n or 24)
local i=t.label
i:ClearAllPoints()
i:SetPoint("LEFT",t,"LEFT",9,0)
i:SetPoint("RIGHT",t,"RIGHT",-24,0)
i:SetJustifyH("LEFT")
i:SetWordWrap(false)
local a=t:CreateTexture(nil,"OVERLAY")
a:SetSize((n or 24)-8,(n or 24)-8)
a:SetPoint("LEFT",t,"LEFT",5,0)
a:Hide()
t.icon=a
local n=e.artTexture(t,"chevron","OVERLAY")
n:SetSize(14,14)
n:SetPoint("RIGHT",t,"RIGHT",-6,0)
t.arrow=n
function t:SetIcon(o,n,e)
self.iconTinted=n
if o then
a:SetTexture(o)
if e then a:SetTexCoord(unpack(e))else a:SetTexCoord(0,1,0,1)end
a:Show()
i:SetPoint("LEFT",a,"RIGHT",6,0)
else
a:Hide()
i:SetPoint("LEFT",t,"LEFT",9,0)
end
self.paintIcon()
end
function t.paintIcon()
local e=o.col.labelNorm
if t.iconTinted then a:SetVertexColor(e[1],e[2],e[3],1)else a:SetVertexColor(1,1,1,1)end
end
function t:SetOpen(t)
self.open=t
if t then n:SetTexCoord(0,1,1,0)else n:SetTexCoord(0,1,0,1)end
self:SetActive(t)
end
e.onTheme(function(e)
local e=e.wheelBorder
n:SetVertexColor(e[1],e[2],e[3],1)
t.paintIcon()
end)
return t
end
function e.createToggle(t,c)
local t=CreateFrame("Button",nil,t)
t:SetSize(38,20)
local m=e.artTexture(t,"pill","BACKGROUND")
m:SetAllPoints()
local u=e.artTexture(t,"pill_edge","BORDER")
u:SetAllPoints()
local r=e.artTexture(t,"soft_glow","ARTWORK",0,"ADD")
r:SetSize(30,30)
local h=e.artTexture(t,"knob","ARTWORK",1)
h:SetSize(22,22)
local n,d=0,0
local function l()
h:SetPoint("CENTER",t,"LEFT",10+18*n,-0.5)
r:SetPoint("CENTER",h,"CENTER")
end
local function s(a)
a=a or o.col
local s,o,c,l=a.wheelBorder,a.centerFill,a.spoke,a.labelNorm
local o=i(i(o,a.wheelBg,0.4),s,n*0.85)
m:SetVertexColor(o[1],o[2],o[3],1)
local o=(t.hovered or n>0.5)and s or c
u:SetVertexColor(o[1],o[2],o[3],t.hovered and 1 or 0.8)
local t=i(l,{1,1,1},n*0.5)
h:SetVertexColor(t[1],t[2],t[3],1)
local t=a.labelHot
r:SetVertexColor(t[1],t[2],t[3],0.5*d)
end
e.onTheme(s)
l()
function t:SetChecked(t,a)
t=t and true or false
self.checked=t
local t=t and 1 or 0
if a or not self:IsVisible()then
e.stopTween(h)
n=t
l()
s()
else
e.tween(h,n,t,0.16,function(e)n=e;l();s()end)
end
end
function t:GetChecked()return self.checked end
t:SetScript("OnClick",function(e)
e:SetChecked(not e.checked)
if PlaySound then pcall(PlaySound,e.checked and 856 or 857)end
if c then c(e.checked)end
end)
t:SetScript("OnEnter",function(t)
t.hovered=true
s()
e.tween(r,d,1,0.12,function(e)d=e;s()end)
end)
t:SetScript("OnLeave",function(t)
t.hovered=false
s()
e.tween(r,d,0,0.25,function(e)d=e;s()end)
end)
t:SetScript("OnEnable",function(e)e:SetAlpha(1)end)
t:SetScript("OnDisable",function(e)e:SetAlpha(0.4)end)
t.checked=false
return t
end
function e.createPillBar(s,n,i,t)
local function a(a,o)
local e=e.artTexture(s,"pill",n,i)
e:SetTexCoord(a,o,0,1)
e:SetHeight(t)
return e
end
local e={l=a(0,0.25),m=a(0.25,0.75),r=a(0.75,1)}
e.l:SetWidth(t/2)
e.r:SetWidth(t/2)
e.m:SetPoint("LEFT",e.l,"RIGHT",0,0)
e.m:SetPoint("RIGHT",e.r,"LEFT",0,0)
function e.SetVertexColor(n,o,i,t,a)
e.l:SetVertexColor(o,i,t,a)
e.m:SetVertexColor(o,i,t,a)
e.r:SetVertexColor(o,i,t,a)
end
return e
end
function e.createSlider(a,t,d,u,h,r,s)
local a=CreateFrame("Frame",nil,a)
a:SetSize(t,22)
local n=a:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
n:SetPoint("RIGHT",a,"RIGHT",0,0)
n:SetWidth(40)
n:SetJustifyH("RIGHT")
e.shadowText(n)
local t=CreateFrame("Slider",nil,a)
t:SetOrientation("HORIZONTAL")
t:SetHeight(22)
t:SetPoint("LEFT",a,"LEFT",0,0)
t:SetPoint("RIGHT",n,"LEFT",-8,0)
t:SetMinMaxValues(d,u)
t:SetValueStep(h)
if t.SetObeyStepOnDrag then t:SetObeyStepOnDrag(true)end
t:EnableMouseWheel(true)
t:SetScript("OnMouseWheel",function(e,t)
if not e:IsEnabled()then return end
e:SetValue(math.max(d,math.min(u,e:GetValue()+t*h)))
end)
local u=e.createPillBar(t,"BACKGROUND",0,6)
u.l:SetPoint("LEFT",t,"LEFT",0,0)
u.r:SetPoint("RIGHT",t,"RIGHT",0,0)
t:SetThumbTexture(l.."knob")
local l=t:GetThumbTexture()
l:SetSize(20,20)
local w=e.createPillBar(t,"BORDER",0,6)
w.l:SetPoint("LEFT",t,"LEFT",0,0)
w.r:SetPoint("RIGHT",l,"CENTER",0,0)
local d=e.artTexture(t,"soft_glow","ARTWORK",0,"ADD")
d:SetSize(34,34)
d:SetPoint("CENTER",l,"CENTER",0,0)
local c,m,f=false,false,0
local function y(t)
t=t or o.col
local s,o,a,h=t.spoke,t.wheelBorder,t.labelHot,t.labelNorm
local t=i(t.wheelBg,s,0.35)
u:SetVertexColor(t[1],t[2],t[3],1)
w:SetVertexColor(o[1],o[2],o[3],1)
local t=i(h,{1,1,1},0.4)
l:SetVertexColor(t[1],t[2],t[3],1)
d:SetVertexColor(a[1],a[2],a[3],0.6*f)
n:SetTextColor(a[1],a[2],a[3],1)
end
e.onTheme(y)
local function o()
local a=(c or m)and 1 or 0
e.tween(d,f,a,a>0 and 0.12 or 0.3,function(e)f=e;y()end)
end
t:SetScript("OnEnter",function()c=true;o()end)
t:SetScript("OnLeave",function()c=false;o()end)
t:SetScript("OnMouseDown",function()m=true;o()end)
t:SetScript("OnMouseUp",function()m=false;o()end)
t:SetScript("OnValueChanged",function(t,e)
local e=p(e/h+0.5)*h
n:SetText(r and r(e)or tostring(e))
if s then s(e)end
end)
a.slider,a.valueText=t,n
function a:SetValue(e)t:SetValue(e)end
function a:GetValue()return t:GetValue()end
function a:SetDisplayValue(e)
local a=s
s=nil
t:SetValue(e)
n:SetText(r and r(e)or tostring(e))
s=a
end
function a:SetEnabled(e)
if e then t:Enable()else t:Disable()end
self:SetAlpha(e and 1 or 0.4)
end
return a
end
function e.createSegmented(t,y,n,h,w)
h=h or 24
local t=CreateFrame("Frame",nil,t)
t:SetSize(n,h)
local a=#y
local s=n/a
local u=t:CreateTexture(nil,"BACKGROUND")
u:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
u:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
local v=e.addBorder(t,0,1,"BORDER")
local n=t:CreateTexture(nil,"BORDER",nil,1)
n:SetSize(s-2,h-2)
n:SetColorTexture(1,1,1,1)
local l=t:CreateTexture(nil,"ARTWORK",nil,1)
l:SetSize(s-2,2)
l:SetColorTexture(1,1,1,1)
l:SetPoint("BOTTOMLEFT",n,"BOTTOMLEFT",0,0)
local c,m={},{}
for a=2,a do
local e=t:CreateTexture(nil,"BORDER",nil,2)
e:SetWidth(1)
e:SetPoint("TOPLEFT",t,"TOPLEFT",p((a-1)*s+0.5),-4)
e:SetPoint("BOTTOMLEFT",t,"BOTTOMLEFT",p((a-1)*s+0.5),4)
e:SetColorTexture(1,1,1,1)
c[#c+1]=e
end
local d=0
local function f()
n:SetPoint("TOPLEFT",t,"TOPLEFT",1+d*s,-1)
end
local function r(e)
e=e or o.col
local h,o,a,s=e.wheelBorder,e.spoke,e.labelHot,e.labelNorm
local e=i(e.wheelBg,e.centerFill,0.5)
u:SetColorTexture(e[1],e[2],e[3],0.95)
v:SetColor(o[1],o[2],o[3],0.75)
n:SetColorTexture(h[1],h[2],h[3],0.20)
l:SetColorTexture(a[1],a[2],a[3],1)
for t,e in ipairs(c)do e:SetColorTexture(o[1],o[2],o[3],0.35)end
for o,e in ipairs(m)do
if o==t.selected then
e.label:SetTextColor(a[1],a[2],a[3],1)
elseif e.hovered then
e.label:SetTextColor(s[1],s[2],s[3],1)
else
e.label:SetTextColor(s[1],s[2],s[3],0.55)
end
end
end
for o,i in ipairs(y)do
local a=CreateFrame("Button",nil,t)
a:SetSize(s,h)
a:SetPoint("TOPLEFT",t,"TOPLEFT",(o-1)*s,0)
a.label=a:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
a.label:SetPoint("CENTER",a,"CENTER",0,0)
a.label:SetText(i)
e.shadowText(a.label)
a:SetScript("OnEnter",function()a.hovered=true;r()end)
a:SetScript("OnLeave",function()a.hovered=false;r()end)
a:SetScript("OnClick",function()
if w then w(o)end
end)
m[o]=a
end
function t:SetSelected(a,o)
local i=d
self.selected=a
if o or not self:IsVisible()then
e.stopTween(n)
d=a-1
f()
else
e.tween(n,i,a-1,0.18,function(e)d=e;f()end)
end
r()
end
t.segs=m
e.onTheme(r)
t:SetSelected(1,true)
return t
end
function e.createEditBox(t,a,n,h)
local t=CreateFrame("EditBox",nil,t)
t:SetSize(a or 120,n or 24)
t:SetAutoFocus(false)
t:SetFontObject(GameFontHighlightSmall)
t:SetTextInsets(8,8,0,0)
t:SetJustifyH("LEFT")
local d=t:CreateTexture(nil,"BACKGROUND")
d:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
d:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
local a=t:CreateTexture(nil,"BACKGROUND",nil,1)
a:SetAllPoints(d)
a:SetColorTexture(1,1,1,1)
e.setGradient(a,"VERTICAL",0,0,0,0,0,0,0,0.25)
local u=e.addBorder(t,0,1,"BORDER")
local s=t:CreateTexture(nil,"BORDER",nil,1)
s:SetPoint("BOTTOMLEFT",t,"BOTTOMLEFT",1,1)
s:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
s:SetHeight(1)
s:SetColorTexture(1,1,1,0)
local n
if h then
n=t:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
n:SetPoint("LEFT",t,"LEFT",8,0)
n:SetText(h)
end
local r,l,h=false,false,0
local function a(e)
e=e or o.col
local a=i(e.wheelBg,{0,0,0},0.35)
d:SetColorTexture(a[1],a[2],a[3],0.95)
local a=(r or l)and e.wheelBorder or e.spoke
u:SetColor(a[1],a[2],a[3],r and 1 or(l and 0.85 or 0.65))
local a,e=e.labelHot,e.labelNorm
s:SetColorTexture(a[1],a[2],a[3],h)
t:SetTextColor(e[1],e[2],e[3],1)
if n then n:SetTextColor(e[1],e[2],e[3],0.35)end
end
local function o()
if n then n:SetShown(not r and(t:GetText()or"")=="")end
end
e.onTheme(a)
t:HookScript("OnEditFocusGained",function()
r=true
a()
o()
e.tween(s,h,1,0.15,function(e)h=e;a()end)
end)
t:HookScript("OnEditFocusLost",function()
r=false
a()
o()
e.tween(s,h,0,0.25,function(e)h=e;a()end)
end)
t:HookScript("OnEnter",function()l=true;a()end)
t:HookScript("OnLeave",function()l=false;a()end)
t:HookScript("OnTextChanged",o)
t:HookScript("OnShow",o)
t.refreshHint=o
return t
end
local a={}
local n=CreateFrame("Frame",nil,UIParent)
n:SetAllPoints(UIParent)
n:SetFrameStrata("FULLSCREEN")
n:EnableMouse(true)
n:Hide()
function e.closeAllDropdowns()
for t,e in ipairs(a)do
if e:IsShown()then e:Hide()end
end
n:Hide()
end
n:SetScript("OnMouseDown",function()e.closeAllDropdowns()end)
function e.createPopup(i,o)
local t=CreateFrame("Frame",nil,UIParent)
t:SetSize(i,o)
t:SetFrameStrata("TOOLTIP")
t:SetClampedToScreen(true)
t:EnableMouse(true)
t:Hide()
t.chrome=e.skinFrame(t,{alpha=1.0,corners=false})
t:HookScript("OnShow",function(t)
t:SetAlpha(0)
e.tween(t,0,1,0.10,function(e)t:SetAlpha(e)end)
end)
t:HookScript("OnHide",function(e)
if e.anchorBtn and e.anchorBtn.SetOpen then e.anchorBtn:SetOpen(false)end
e.anchorBtn=nil
end)
table.insert(a,t)
return t
end
function e.togglePopup(t,a,i)
if t:IsShown()and t.anchorBtn==a then
e.closeAllDropdowns()
return false
end
e.closeAllDropdowns()
t:ClearAllPoints()
local e=a:GetEffectiveScale()/UIParent:GetEffectiveScale()
local e=(a:GetBottom()or 0)*e
local o=e-t:GetHeight()-4>8
local e=(i=="RIGHT")and"RIGHT"or"LEFT"
if o then
t:SetPoint("TOP"..e,a,"BOTTOM"..e,0,-3)
else
t:SetPoint("BOTTOM"..e,a,"TOP"..e,0,3)
end
t.anchorBtn=a
if a.SetOpen then a:SetOpen(true)end
n:Show()
t:Show()
return true
end
function e.createListRow(t,i,a)
local t=CreateFrame("Button",nil,t)
t:SetSize(i,a)
local h=t:CreateTexture(nil,"BACKGROUND")
h:SetAllPoints()
h:SetColorTexture(1,1,1,1)
local s=t:CreateTexture(nil,"BORDER")
s:SetPoint("TOPLEFT",t,"TOPLEFT",0,-3)
s:SetPoint("BOTTOMLEFT",t,"BOTTOMLEFT",0,3)
s:SetWidth(2)
s:SetColorTexture(1,1,1,1)
local a=t:CreateFontString(nil,"OVERLAY","GameFontNormalSmall")
a:SetPoint("LEFT",t,"LEFT",10,0)
a:SetPoint("RIGHT",t,"RIGHT",-24,0)
a:SetJustifyH("LEFT")
a:SetWordWrap(false)
e.shadowText(a)
local i=e.artTexture(t,"check","OVERLAY")
i:SetSize(14,14)
i:SetPoint("RIGHT",t,"RIGHT",-6,0)
i:Hide()
t.label,t.check=a,i
local function n(e)
e=e or o.col
local o,e,n=e.wheelBorder,e.labelHot,e.labelNorm
if t.hovered then
h:SetColorTexture(o[1],o[2],o[3],0.18)
elseif t.selected then
h:SetColorTexture(o[1],o[2],o[3],0.08)
else
h:SetColorTexture(0,0,0,0)
end
s:SetColorTexture(e[1],e[2],e[3],t.hovered and 1 or 0)
local o=(t.hovered or t.selected)and e or n
a:SetTextColor(o[1],o[2],o[3],1)
i:SetVertexColor(e[1],e[2],e[3],1)
if t.icon and t.iconTinted then t.icon:SetVertexColor(o[1],o[2],o[3],1)end
end
t.paint=n
e.onTheme(n)
function t:AddIcon(t,o)
local e=self:CreateTexture(nil,"ARTWORK")
e:SetSize(t,t)
e:SetPoint("LEFT",self,"LEFT",8,0)
a:SetPoint("LEFT",e,"RIGHT",7,0)
self.icon,self.iconTinted=e,o
n()
return e
end
function t:SetSelected(e)
self.selected=e and true or false
i:SetShown(self.selected)
n()
end
t:SetScript("OnEnter",function(e)e.hovered=true;n()end)
t:SetScript("OnLeave",function(e)e.hovered=false;n()end)
return t
end
function e.createScrollbar(n,a,c,h,t,l)
h,t,l=h or 6,t or 6,l or 20
local i=n:CreateTexture(nil,"ARTWORK")
i:SetWidth(3)
i:SetPoint("TOPRIGHT",n,"TOPRIGHT",-6,-h)
i:SetPoint("BOTTOMRIGHT",n,"BOTTOMRIGHT",-6,t)
local t=CreateFrame("Button",nil,n)
t:SetWidth(11)
local s=t:CreateTexture(nil,"OVERLAY")
s:SetPoint("TOP",t,"TOP",0,0)
s:SetPoint("BOTTOM",t,"BOTTOM",0,0)
s:SetWidth(4)
s:SetColorTexture(1,1,1,1)
t:SetFrameLevel(n:GetFrameLevel()+5)
local d=false
local function r(t)
t=t or o.col
local a,t=t.spoke,t.wheelBorder
i:SetColorTexture(a[1],a[2],a[3],0.25)
s:SetColorTexture(t[1],t[2],t[3],d and 1 or 0.75)
end
e.onTheme(r)
local function e()return a:GetHeight()or 0 end
local function s()return v(1,i:GetHeight()or 1)end
local function u()
local o,e=c:GetHeight()or 0,e()
if o<=e+1 or e<=0 then
t:Hide()
i:Hide()
return
end
t:Show()
i:Show()
local e=v(24,s()*e/o)
t:SetHeight(e)
local o=a:GetVerticalScrollRange()
local a=o>0 and(a:GetVerticalScroll()/o)or 0
t:ClearAllPoints()
t:SetPoint("TOPRIGHT",n,"TOPRIGHT",-2,-h-a*(s()-e))
end
local function o(t)
local e=a:GetVerticalScrollRange()
a:SetVerticalScroll(v(0,y(e,t)))
u()
end
a:EnableMouseWheel(true)
a:SetScript("OnMouseWheel",function(e,t)
o(e:GetVerticalScroll()-t*l*3)
end)
local i,n
t:SetScript("OnMouseDown",function(e)
local h,t=GetCursorPosition()
i=t/e:GetEffectiveScale()
n=a:GetVerticalScroll()
e:SetScript("OnUpdate",function(t)
local h,e=GetCursorPosition()
e=e/t:GetEffectiveScale()
local t=s()-t:GetHeight()
if t<=0 then return end
local a=a:GetVerticalScrollRange()
o(n+(i-e)/t*a)
end)
end)
t:SetScript("OnMouseUp",function(e)e:SetScript("OnUpdate",nil)end)
t:SetScript("OnHide",function(e)e:SetScript("OnUpdate",nil)end)
t:SetScript("OnEnter",function()d=true;r()end)
t:SetScript("OnLeave",function()d=false;r()end)
return u,o
end
function e.createPopout(s,i,o,a,n)
local t=CreateFrame("Frame",nil,UIParent)
t:SetSize(i,o)
t:SetPoint("CENTER",UIParent,"CENTER",a or 0,n or 0)
t:SetFrameStrata("FULLSCREEN_DIALOG")
t:SetMovable(true)
t:EnableMouse(true)
t:RegisterForDrag("LeftButton")
t:SetClampedToScreen(true)
t:SetScript("OnDragStart",t.StartMoving)
t:SetScript("OnDragStop",t.StopMovingOrSizing)
t:Hide()
e.skinFrame(t,{alpha=1.0})
local a=t:CreateFontString(nil,"OVERLAY")
e.setTitleFont(a,15)
a:SetPoint("TOPLEFT",t,"TOPLEFT",20,-15)
a:SetText(s)
e.shadowText(a,1)
e.onTheme(function(e)
local e=e.labelHot
a:SetTextColor(e[1],e[2],e[3],1)
end)
local o=e.createDivider(t)
o:SetPoints(14,14,-40)
local o=e.createCloseButton(t)
o:SetPoint("TOPRIGHT",t,"TOPRIGHT",-9,-9)
t:HookScript("OnShow",function(t)
t:SetAlpha(0)
e.tween(t,0,1,0.15,function(e)t:SetAlpha(e)end)
end)
return t,a
end
function e.createWell(t)
local t=CreateFrame("Frame",nil,t)
local a=t:CreateTexture(nil,"BACKGROUND")
a:SetPoint("TOPLEFT",t,"TOPLEFT",1,-1)
a:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-1,1)
local o=t:CreateTexture(nil,"BACKGROUND",nil,1)
o:SetPoint("TOPLEFT",a,"TOPLEFT")
o:SetPoint("TOPRIGHT",a,"TOPRIGHT")
o:SetHeight(18)
o:SetColorTexture(1,1,1,1)
e.setGradient(o,"VERTICAL",0,0,0,0,0,0,0,0.35)
local o=e.addBorder(t,0,1,"BORDER")
e.onTheme(function(t)
local e=i(t.wheelBg,{0,0,0},0.4)
a:SetColorTexture(e[1],e[2],e[3],1)
local e=t.spoke
o:SetColor(e[1],e[2],e[3],0.55)
end)
return t
end

--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
local l=e.CFG
local w=e.THEMES
local v=e.ICONS
local f=math.floor
local H=e.settingsPanel
local t=e.tab1Content
local s=e.CELL_H
local a,p=e.MARGIN,330
local h=a+p/2
local i=a+p+22
local n=e.CONTENT_W-e.MARGIN-i
local u=164
local function g(t)return(e.wheelPage-1)*l.numSlices+t end
local function b(t,e)
C_Timer.After(0,function()if t:IsShown()then e()end end)
end
local o={}
for e=1,l.numWheelPages do o[e]="Wheel "..e end
local O=e.createSegmented(t,o,246,s,function(t)e.setWheelPage(t)end)
O:SetPoint("TOP",t,"TOPLEFT",h,-6)
local z=28
local d=e.createWell(t)
d:SetSize(p,l.numSlices*z+4)
d:SetPoint("TOPLEFT",t,"TOPLEFT",a,-6-s-12)
d:EnableMouseWheel(true)
local a=e.createText(t,"Click a slot to edit it  -  scroll to switch wheels","dim","GameFontNormalSmall")
a:SetPoint("TOP",d,"BOTTOM",0,-8)
local I=e.createButton(t,"Reset This Wheel",200,s)
I:SetPoint("TOP",a,"BOTTOM",0,-10)
local r=1
local o=e.addSectionHeader(t,"Selected Slot",i,-6,n)
local a=e.createWell(t)
a:SetSize(n,66)
a:SetPoint("TOPLEFT",o,"BOTTOMLEFT",0,-8)
local o=20
local k=8+f(o*1.25)
local h=e.artTexture(a,"wheel_disc","ARTWORK",0)
h:SetSize(2*e.WHEEL_EXTENT*o,2*e.WHEEL_EXTENT*o)
h:SetPoint("CENTER",a,"LEFT",k,0)
local y=a:CreateTexture(nil,"ARTWORK",nil,2)
y:SetSize(30,30)
y:SetPoint("CENTER",h,"CENTER")
local c=a:CreateFontString(nil,"ARTWORK",nil)
e.setTitleFont(c,18)
c:SetPoint("CENTER",h,"CENTER",0,1)
e.shadowText(c,1)
local x=e.artTexture(a,"hub_inner","ARTWORK",3)
x:SetSize(2*e.HUB_EXTENT*o,2*e.HUB_EXTENT*o)
x:SetPoint("CENTER",h,"CENTER")
local m=e.artTexture(a,"hub_ring","OVERLAY",0)
m:SetSize(2*e.HUB_EXTENT*o,2*e.HUB_EXTENT*o)
m:SetPoint("CENTER",h,"CENTER")
local q=e.artTexture(a,"hub_ring_spec","OVERLAY",1,"ADD")
q:SetSize(2*e.HUB_EXTENT*o,2*e.HUB_EXTENT*o)
q:SetPoint("CENTER",h,"CENTER")
local j=e.createText(a,"","dim","GameFontNormalSmall")
j:SetPoint("TOPLEFT",a,"TOPLEFT",k+34,-11)
local k=e.createText(a,"","hot","GameFontNormalLarge")
k:SetPoint("TOPLEFT",j,"BOTTOMLEFT",0,-3)
local o=e.createText(a,"","dim","GameFontNormalSmall")
o:SetPoint("TOPLEFT",k,"BOTTOMLEFT",0,-3)
o:SetPoint("RIGHT",a,"RIGHT",-10,0)
o:SetJustifyH("LEFT")
o:SetWordWrap(false)
e.onTheme(function(e)
local t,a,e=e.innerCircle,e.wheelBorder,e.labelHot
h:SetVertexColor(t[1],t[2],t[3],1)
y:SetVertexColor(e[1],e[2],e[3],1)
c:SetTextColor(e[1],e[2],e[3],1)
x:SetVertexColor(0,0,0,0.8)
m:SetVertexColor(a[1],a[2],a[3],1)
q:SetVertexColor(1,1,1,0.5)
end)
local x=e.createDropdown(t,u,s)
e.addRow(t,"Emote",i,-106,n,x)
local m=e.createDropdown(t,u,s)
e.addRow(t,"Emoticon",i,-136,n,m)
local function q()
local i=g(r)
local t=e.EMOTES[i]
local a=t and t.name or"?"
j:SetText(string.upper("Wheel "..e.wheelPage.."  -  Slot "..r))
k:SetText(a)
if t and t.cmd then
o:SetText("/"..string.lower(t.cmd))
elseif t and t.text then
o:SetText("/em "..t.text)
else
o:SetText("")
end
x:SetLabel(a)
local t=e.getSlotEmoticon(i)
local e=e.SLOT_EMOTICONS[i]
if t then
y:SetTexture(t.file)
y:Show()
c:Hide()
m:SetIcon(t.file,true)
m:SetLabel(e and t.id or(t.id.." (default)"))
else
y:Hide()
c:SetText(string.upper(string.sub(a,1,1)))
c:Show()
m:SetIcon(nil)
m:SetLabel(e==false and"None (text)"or"Text (no default)")
end
end
local h={}
local function k()
for i,t in ipairs(h)do
local o=g(i)
local a=e.EMOTES[o]
t.label:SetText(a and a.name or"?")
local e=a and e.getSlotEmoticon(o)
if e then t.icon:SetTexture(e.file)else t.icon:SetTexture(nil)end
t:SetSelected(i==r)
end
end
local function c(e)
r=e
k()
q()
end
local function o(t)
e.slotPreviewActive=t>0
e.setActiveSlice(t)
end
local j
for a=1,l.numSlices do
local t=e.createListRow(d,p-4,z)
t:SetPoint("TOPLEFT",d,"TOPLEFT",2,-2-(a-1)*z)
t:RegisterForClicks("LeftButtonUp","RightButtonUp")
local e=e.createText(t,tostring(a),"dim","GameFontNormalSmall")
e:SetPoint("LEFT",t,"LEFT",10,0)
local e=t:AddIcon(20,true)
e:ClearAllPoints()
e:SetPoint("LEFT",t,"LEFT",34,0)
t:HookScript("OnEnter",function()o(a)end)
t:HookScript("OnLeave",function()o(0)end)
t:SetScript("OnClick",function(t,e)
c(a)
if e=="RightButton"and j then j()end
end)
h[a]=t
end
d:SetScript("OnHide",function()o(0)end)
d:SetScript("OnMouseWheel",function(a,t)
e.setWheelPage(e.wheelPage+(t>0 and 1 or-1))
end)
local A=e.AVAILABLE_EMOTES
local p,a,c=250,340,22
local o=e.createPopup(p,a)
local a=e.createEditBox(o,p-20,s,"Search emotes")
a:SetPoint("TOPLEFT",o,"TOPLEFT",10,-10)
local h=e.artTexture(a,"search","OVERLAY")
h:SetSize(14,14)
h:SetPoint("RIGHT",a,"RIGHT",-6,0)
e.onTheme(function(e)
local e=e.labelNorm
h:SetVertexColor(e[1],e[2],e[3],0.55)
end)
local y=CreateFrame("ScrollFrame",nil,o)
y:SetPoint("TOPLEFT",o,"TOPLEFT",8,-42)
y:SetPoint("BOTTOMRIGHT",o,"BOTTOMRIGHT",-18,8)
local d=CreateFrame("Frame",nil,y)
d:SetSize(p-26,100)
y:SetScrollChild(d)
local N,S=e.createScrollbar(o,y,d,42,8,c)
local h={}
local function E(t)
local a=CreateFrame("Frame",nil,d)
a:SetSize(p-26,c)
local t=e.createText(a,string.upper(t),"accent","GameFontNormalSmall")
t:SetPoint("LEFT",a,"LEFT",8,-2)
local o=a:CreateTexture(nil,"ARTWORK")
o:SetHeight(1)
o:SetPoint("LEFT",t,"RIGHT",6,0)
o:SetPoint("RIGHT",a,"RIGHT",-4,0)
o:SetColorTexture(1,1,1,1)
e.onTheme(function(t)
local t=t.wheelBorder
e.setGradient(o,"HORIZONTAL",t[1],t[2],t[3],0.4,t[1],t[2],t[3],0)
end)
h[#h+1]={header=true,frame=a}
end
local z
local function T(t)
e.applyEmote(r,t)
e.closeAllDropdowns()
end
local function _(t)
local e=e.createListRow(d,p-26,c)
e:SetScript("OnClick",function()T(t())end)
h[#h+1]={row=e,frame=e,get=t}
return e
end
E("Blizzard Emotes")
for a,t in ipairs(A)do
local a=_(function()return t end)
a.label:SetText(t.name)
local a=a:AddIcon(16,true)
local t=t.emoticon or(t.cmd and e.EMOTICON_ID_BY_CMD[t.cmd])
local e=t and e.EMOTICON_BY_ID[t]
if e then a:SetTexture(e.file)else a:SetTexture(nil)end
end
E("Custom Emotes")
local p={}
for a=1,#e.CUSTOM_EMOTES do
local t=_(function()return e.CUSTOM_EMOTES[a]end)
t.label:SetText(e.CUSTOM_EMOTES[a].name)
t:AddIcon(16,true)
p[a]=t
end
e.refreshCustomPickerRows=function()
for t,a in ipairs(p)do
if e.CUSTOM_EMOTES[t]then a.label:SetText(e.CUSTOM_EMOTES[t].name)end
end
end
local function p()
local i=string.lower((a:GetText()or""):match("^%s*(.-)%s*$"))
local e,o,s=0,1,#h
local n,r
while o<=s do
local t=h[o]
if t.header then
local a,o=o+1,false
while a<=s and not h[a].header do
local e=h[a].get()
if i==""or string.find(string.lower(e.name),i,1,true)then o=true;break end
a=a+1
end
t.frame:SetShown(o)
if o then
t.frame:SetPoint("TOPLEFT",d,"TOPLEFT",0,-e)
e=e+c
end
else
local a=t.get()
local o=i==""or string.find(string.lower(a.name),i,1,true)
t.frame:SetShown(o and true or false)
if o then
t.frame:SetPoint("TOPLEFT",d,"TOPLEFT",0,-e)
t.row:SetSelected(a==z)
if a==z then r=e end
n=n or a
e=e+c
end
end
o=o+1
end
d:SetHeight(math.max(e,1))
y:SetVerticalScroll(0)
N()
return n,r
end
a:SetScript("OnTextChanged",function(e)
p()
e.refreshHint()
end)
a:SetScript("OnEnterPressed",function()
local e=p()
if e then T(e)end
end)
a:SetScript("OnEscapePressed",function()e.closeAllDropdowns()end)
o:HookScript("OnHide",function()a:ClearFocus()end)
local function h()
local e=e.EMOTES[g(r)]
if not e then return nil end
if e.cmd then
local a
for o,t in ipairs(A)do
if t.cmd==e.cmd then
if t.name==e.name then return t end
a=a or t
end
end
if a then return a end
end
return e
end
x:SetScript("OnClick",function(t)
e.refreshCustomPickerRows()
z=h()
a:SetText("")
if e.togglePopup(o,t,"RIGHT")then
local t,e=p()
if e then b(o,function()S(e-c*3)end)end
a:SetFocus()
end
end)
local h,o,A=7,38,28
local d=h*o+8+22
local a=344
local a=e.createPopup(d,a)
local E=e.createButton(a,"Default",f((d-26)/2),22)
E:SetPoint("TOPLEFT",a,"TOPLEFT",10,-10)
local _=e.createButton(a,"None (text)",f((d-26)/2),22)
_:SetPoint("TOPRIGHT",a,"TOPRIGHT",-10,-10)
local c=e.createPlaque(a,nil,true)
c:SetPoint("BOTTOMLEFT",a,"BOTTOMLEFT",10,5)
c:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",-10,5)
local p
local y=CreateFrame("ScrollFrame",nil,a)
y:SetPoint("TOPLEFT",a,"TOPLEFT",8,-40)
y:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",-22,28)
local d=CreateFrame("Frame",nil,y)
d:SetSize(h*o,math.ceil(#e.EMOTICONS/h)*o)
y:SetScrollChild(d)
local N,S=e.createScrollbar(a,y,d,40,28,o/2)
local function x(t)
e.applyEmoticon(r,t)
e.closeAllDropdowns()
end
E:SetScript("OnClick",function()x(nil)end)
_:SetScript("OnClick",function()x(false)end)
local z={}
for t,e in ipairs(e.EMOTICONS)do z[t]=e end
table.sort(z,function(e,t)return e.id<t.id end)
local T={}
local function y(e,a)
a=a or l.col
local t=a.wheelBorder
local o=(e.isCurrent and 0.30 or 0)+(e.hovered and 0.22 or 0)
e.plate:SetColorTexture(t[1],t[2],t[3],o)
e.edge:SetColor(t[1],t[2],t[3],e.isCurrent and 0.9 or 0)
local t=(e.hovered or e.isCurrent)and a.labelHot or a.labelNorm
e.tex:SetVertexColor(t[1],t[2],t[3],1)
local t=e.hovered and A+4 or A
e.tex:SetSize(t,t)
end
for a,i in ipairs(z)do
local t=CreateFrame("Button",nil,d)
t:SetSize(o,o)
t:SetPoint("TOPLEFT",d,"TOPLEFT",
((a-1)%h)*o,-f((a-1)/h)*o)
t.plate=t:CreateTexture(nil,"BACKGROUND")
t.plate:SetPoint("TOPLEFT",t,"TOPLEFT",2,-2)
t.plate:SetPoint("BOTTOMRIGHT",t,"BOTTOMRIGHT",-2,2)
t.edge=e.addBorder(t,2,1,"BORDER")
t.tex=t:CreateTexture(nil,"ARTWORK")
t.tex:SetPoint("CENTER")
t.tex:SetTexture(i.file)
t.id=i.id
e.onTheme(function(e)y(t,e)end)
t:SetScript("OnEnter",function(e)
e.hovered=true
y(e)
p=e.id
c:SetLabel(e.id)
end)
t:SetScript("OnLeave",function(e)
e.hovered=false
y(e)
p=nil
C_Timer.After(0.05,function()
if not p then c:SetLabel(nil)end
end)
end)
t:SetScript("OnClick",function(e)x(e.id)end)
T[a]=t
end
j=function()
local t=g(r)
local i=e.getSlotEmoticon(t)
local i=i and i.id
local t=e.SLOT_EMOTICONS[t]
E:SetActive(t==nil)
_:SetActive(t==false)
local t
for a,e in ipairs(T)do
e.isCurrent=(e.id==i)
y(e)
if e.isCurrent then t=f((a-1)/h)end
end
p=nil
c:SetLabel(nil)
if e.togglePopup(a,m,"RIGHT")then
b(a,function()
S(t and(t-1)*o or 0)
N()
end)
end
end
m:SetScript("OnClick",function()j()end)
StaticPopupDialogs["SEW_RESET_SLOTS_CONFIRM"]={
text="Reset this wheel's 12 emote slots and emoticons to default?",
button1="Reset",
button2="Cancel",
OnAccept=function()
e.closeAllDropdowns()
local a=(e.wheelPage-1)*l.numSlices
for t=1,l.numSlices do
local a=a+t
e.applyEmoticon(t,nil)
local a=e.DEFAULT_EMOTES[a]or e.CUSTOM_EMOTES[a-#e.DEFAULT_EMOTES]
if a then
e.applyEmote(t,a)
end
end
end,
timeout=0,
whileDead=true,
hideOnEscape=true,
preferredIndex=3,
}
I:SetScript("OnClick",function()
StaticPopup_Show("SEW_RESET_SLOTS_CONFIRM")
end)
e.refreshWheelSlotsTab=function()
O:SetSelected(e.wheelPage)
k()
q()
end
e.applyEmote=function(a,t)
e.applyEmoteCore(a,t)
k()
q()
end
e.applyEmoticon=function(a,t)
e.applyEmoticonCore(a,t)
k()
q()
end
e.addSectionHeader(t,"Appearance",i,-172,n)
local g=e.createDropdown(t,u,s)
e.addRow(t,"Color Theme",i,-196,n,g)
local y=e.createDropdown(t,u,s)
e.addRow(t,"Texture",i,-226,n,y)
local k
local d=e.createDropdown(t,u,s)
e.addRow(t,"Icon",i,-286,n,d)
e.iconDropLabel=d.label
g:SetLabel(w[1].name)
local c,o,a=236,26,8
local h=10
local h=e.createPopup(c,h*o+a*2)
local r=CreateFrame("ScrollFrame",nil,h)
r:SetPoint("TOPLEFT",h,"TOPLEFT",a,-a)
r:SetPoint("BOTTOMRIGHT",h,"BOTTOMRIGHT",-18,a)
local m=CreateFrame("Frame",nil,r)
m:SetSize(c-a-18,#w*o)
r:SetScrollChild(m)
local E,_=e.createScrollbar(h,r,m,a,a,o)
local r=nil
local p=nil
local function z(t)
if not r then
r=(StryksEmoteWheelDB and StryksEmoteWheelDB.theme)or e.DEFAULT_THEME_NAME
end
e.applyTheme(t)
StryksEmoteWheelDB.theme=r
end
local function q()
if not r then return end
local o=r
r=nil
local a
for i,t in ipairs(w)do
if t.name==o then e.applyTheme(t);return end
if t.name==e.DEFAULT_THEME_NAME then a=t end
end
if a then e.applyTheme(a)end
end
h:HookScript("OnHide",function()
p=nil
q()
end)
local function x(o,n)
local i={}
for a=3,1,-1 do
local t=e.artTexture(o,"wheel_disc","ARTWORK",(4-a)*2)
t:SetSize(20,20)
t:SetPoint("RIGHT",o,"RIGHT",-26-(a-1)*10,0)
local e=e.artTexture(o,"wheel_disc","ARTWORK",(4-a)*2-1)
e:SetSize(23,23)
e:SetPoint("CENTER",t,"CENTER")
e:SetVertexColor(0,0,0,0.85)
local e=n[a]
t:SetVertexColor(e[1],e[2],e[3],1)
i[a]=t
end
return i
end
local j={}
for i,a in ipairs(w)do
local t=e.createListRow(m,m:GetWidth(),o)
t:SetPoint("TOPLEFT",m,"TOPLEFT",0,-(i-1)*o)
t.label:SetText(a.name)
t.label:SetPoint("RIGHT",t,"RIGHT",-60,0)
local o=a.col
x(t,{o.wheelBorder,o.labelHot,o.wheelBg})
t:HookScript("OnEnter",function()
if e.colorPreviewActive then return end
p=a
z(a)
end)
t:HookScript("OnLeave",function()
p=nil
C_Timer.After(0.05,function()
if not p and h:IsShown()then q()end
end)
end)
t:SetScript("OnClick",function()
r=nil
e.applyTheme(a)
e.closeAllDropdowns()
end)
j[i]=t
end
g:SetScript("OnClick",function(i)
if e.colorPreviewActive then return end
local t=(StryksEmoteWheelDB and StryksEmoteWheelDB.theme)or e.DEFAULT_THEME_NAME
local a=1
for e,o in ipairs(j)do
o:SetSelected(w[e].name==t)
if w[e].name==t then a=e end
end
if e.togglePopup(h,i,"RIGHT")then
b(h,function()
_((a-3)*o)
E()
end)
end
end)
e.applyTheme=function(t)
e.applyThemeCore(t)
g:SetLabel(t.name)
end
local m={}
for a,t in ipairs(e.BG_TEXTURES)do
if e.bgTextureAvailable(t)then table.insert(m,t)end
end
local h=e.createPopup(c,#m*o+a*2)
local r=nil
local w={}
e.setBgTexture=function(t)
local t=e.findBgTexture(t)or e.findBgTexture(e.DEFAULT_BG_TEXTURE)
e.bgTexture=t.name
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.bgTexture=t.name
y:SetLabel(t.name)
e.applyBgTexture()
end
h:HookScript("OnHide",function()
r=nil
e.applyBgTexture()
end)
for n,i in ipairs(m)do
local t=e.createListRow(h,c-a*2,o)
t:SetPoint("TOPLEFT",h,"TOPLEFT",a,-a-(n-1)*o)
local a=t:CreateTexture(nil,"ARTWORK")
a:SetSize(36,16)
a:SetPoint("LEFT",t,"LEFT",10,0)
local o=t:CreateTexture(nil,"BORDER")
o:SetPoint("TOPLEFT",a,"TOPLEFT",-1,1)
o:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",1,-1)
o:SetColorTexture(0,0,0,0.9)
if i.atlas or i.file then
e.setBgTextureArt(a,i)
else
a:SetColorTexture(0,0,0,0)
end
t.label:SetPoint("LEFT",a,"RIGHT",9,0)
t.label:SetText(i.name)
t:HookScript("OnEnter",function()
r=i.name
e.applyBgTexture(i.name)
end)
t:HookScript("OnLeave",function()
r=nil
C_Timer.After(0.05,function()
if not r and h:IsShown()then e.applyBgTexture()end
end)
end)
t:SetScript("OnClick",function()
e.setBgTexture(i.name)
e.closeAllDropdowns()
end)
w[n]={row=t,name=i.name}
end
y:SetScript("OnClick",function(a)
if e.colorPreviewActive then return end
local o=e.bgTexture or e.DEFAULT_BG_TEXTURE
for a,t in ipairs(w)do t.row:SetSelected(t.name==o)end
e.togglePopup(h,a,"RIGHT")
end)
k=e.createSlider(t,u,0,100,5,
function(e)return e.."%"end,
function(t)
e.bgTextureAlpha=t/100
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.bgTextureAlpha=e.bgTextureAlpha
e.applyBgTexture()
end)
e.addRow(t,"Texture Strength",i,-256,n,k)
k:SetDisplayValue(f(e.getBgTextureAlpha()*100+0.5))
e.updateBgTextureControls=function()
local t=e.findBgTexture(e.bgTexture)or e.findBgTexture(e.DEFAULT_BG_TEXTURE)
y:SetLabel(t.name)
k:SetDisplayValue(f(e.getBgTextureAlpha()*100+0.5))
end
y:SetLabel(e.DEFAULT_BG_TEXTURE)
local h=9
local h=e.createPopup(c,h*o+a*2)
local m=CreateFrame("ScrollFrame",nil,h)
m:SetPoint("TOPLEFT",h,"TOPLEFT",a,-a)
m:SetPoint("BOTTOMRIGHT",h,"BOTTOMRIGHT",-18,a)
local r=CreateFrame("Frame",nil,m)
r:SetSize(c-a-18,#v*o)
m:SetScrollChild(r)
local m,f=e.createScrollbar(h,m,r,a,a,o)
local c={}
for i,a in ipairs(v)do
local t=e.createListRow(r,r:GetWidth(),o)
t:SetPoint("TOPLEFT",r,"TOPLEFT",0,-(i-1)*o)
local o=t:AddIcon(20,false)
o:SetTexture(a.file)
o:SetTexCoord(0.07,0.93,0.07,0.93)
t.label:SetText(a.name)
t:SetScript("OnClick",function()
e.applyIcon(a.file)
e.closeAllDropdowns()
end)
c[i]={row=t,file=a.file}
end
d:SetScript("OnClick",function(i)
if e.colorPreviewActive then return end
local t=StryksEmoteWheelDB and StryksEmoteWheelDB.icon
local a=1
for o,e in ipairs(c)do
e.row:SetSelected(e.file==t)
if e.file==t then a=o end
end
if e.togglePopup(h,i,"RIGHT")then
b(h,function()
f((a-3)*o)
m()
end)
end
end)
e.applyIcon=function(t)
e.applyIconCore(t)
d:SetIcon(t,false,{0.07,0.93,0.07,0.93})
for a,e in ipairs(v)do
if e.file==t then
d:SetLabel(e.name)
break
end
end
end
d:SetIcon(v[1].file,false,{0.07,0.93,0.07,0.93})
d:SetLabel(v[1].name)
e.addSectionHeader(t,"Wheel",i,-324,n)
local a=e.createSlider(t,u,60,140,5,nil,function(t)
e.applyWheelSize(t)
end)
e.addRow(t,"Wheel Size",i,-348,n,a)
a:SetDisplayValue(l.wheelRadius)
e.wheelSizeSlider=a.slider
local o=e.createToggle(t,function(t)e.setTextOnly(t)end)
e.addRow(t,"Text-Only Wheel",i,-378,n,o)
o:SetPoint("TOPRIGHT",t,"TOPLEFT",i+n,-380)
e.updateTextOnlyCheckbox=function()
o:SetChecked(e.textOnly or false,true)
end
e.updateTextOnlyCheckbox()
local o=e.createButton(t,"Reset",u,s)
e.addRow(t,"Position & Size",i,-408,n,o)
StaticPopupDialogs["SEW_RESET_POSITION_CONFIRM"]={
text="Reset the trigger's position, wheel size, and opacity to default?",
button1="Reset",
button2="Cancel",
OnAccept=function()e.resetWheelPositionAndSize()end,
timeout=0,
whileDead=true,
hideOnEscape=true,
preferredIndex=3,
}
o:SetScript("OnClick",function()
StaticPopup_Show("SEW_RESET_POSITION_CONFIRM")
end)
e.resetWheelPositionAndSize=function()
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.x=0
StryksEmoteWheelDB.y=0
StryksEmoteWheelDB.wheelRadius=e.DEFAULT_WHEELSIZE
StryksEmoteWheelDB.triggerOpacity=nil
e.trigger:ClearAllPoints()
e.trigger:SetPoint("CENTER",UIParent,"CENTER",0,0)
e.applyWheelSize(e.DEFAULT_WHEELSIZE)
a:SetDisplayValue(e.DEFAULT_WHEELSIZE)
e.triggerOpacity=1.0
if e.applyTriggerOpacity then e.applyTriggerOpacity()end
if e.updateOpacitySlider then e.updateOpacitySlider()end
end
H:HookScript("OnHide",function()e.closeAllDropdowns()end)
e.refreshWheelSlotsTab()

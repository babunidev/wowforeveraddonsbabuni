--[[ Stryk's Emote Wheel (c) 2026 stryker2k2. All rights reserved. ]]
local t,e=...
local y={0.06,0.04,0.08,1.00}
local b={0.03,0.02,0.05,0.97}
local v={0.09,0.07,0.12,1.00}
local i=e.tab4Content
local n=e.CELL_H
local h=e.MARGIN
local g=e.CONTENT_W-2*h
e.addSectionHeader(i,"Quick Actions",h,-6)
local t=10
local a=math.floor((g-2*t)/3)
local o=e.createButton(i,"Reset All",a,n+2,{danger=true})
o:SetPoint("TOPLEFT",i,"TOPLEFT",h,-32)
StaticPopupDialogs["SEW_RESET_ALL_CONFIRM"]={
text="Reset ALL Stryks Emote Wheel settings to default? This can't be undone.",
button1="Reset",
button2="Cancel",
OnAccept=function()
if e.resetAllSettings then e.resetAllSettings()end
end,
timeout=0,
whileDead=true,
hideOnEscape=true,
preferredIndex=3,
}
o:SetScript("OnClick",function()
StaticPopup_Show("SEW_RESET_ALL_CONFIRM")
end)
local k=e.createButton(i,"Change Log",a,n+2)
k:SetPoint("TOPLEFT",o,"TOPRIGHT",t,0)
local p=e.createButton(i,
e.debugEnabled and"Disable Debug Mode"or"Enable Debug Mode",a,n+2)
p:SetPoint("TOPLEFT",k,"TOPRIGHT",t,0)
p:SetScript("OnClick",e.toggleDebugMode)
local u=CreateFrame("Frame",nil,i)
u:SetPoint("TOPLEFT",i,"TOPLEFT",0,-80)
u:SetPoint("BOTTOMRIGHT",i,"BOTTOMRIGHT",0,0)
do
local o=e.createFadeLine(u,300,0.5)
o:SetPoint("CENTER",u,"CENTER",0,34)
local t=u:CreateFontString(nil,"OVERLAY")
e.setTitleFont(t,16)
t:SetPoint("BOTTOM",o,"TOP",0,6)
t:SetText("Debug Mode is off")
e.shadowText(t,1)
local a=e.createText(u,
"Turn it on to test every emote, preview the class and expansion colors,\n"
.."watch your controller's sticks and read the addon's log.","dim","GameFontNormalSmall")
a:SetPoint("TOP",o,"BOTTOM",0,-8)
a:SetJustifyH("CENTER")
a:SetSpacing(3)
e.onTheme(function(e)
local e=e.labelHot
t:SetTextColor(e[1],e[2],e[3],0.75)
end)
end
local a=CreateFrame("Frame",nil,i)
a:SetAllPoints(i)
e.addSectionHeader(a,"Debug Tools",h,-76)
local c=10
local d=math.floor((g-c)/2)
local f=false
local r=false
local m=CreateFrame("Frame")
local l=false
m:SetScript("OnEvent",function(a,a,a,t)
if not l and e.isSelfChatSender(t)then
l=true
end
end)
local s=e.createButton(a,"Test All Emotes",d,n)
s:SetPoint("TOPLEFT",a,"TOPLEFT",h,-102)
local w=s.label
s:SetScript("OnClick",function()
if f then
r=true
return
end
f=true
r=false
local a,t={},{}
for o,e in ipairs(e.AVAILABLE_EMOTES)do
if not a[e.cmd]then
a[e.cmd]=true
t[#t+1]=e
end
end
table.insert(t,1,{
name="Sanity Check",
cmd="SEW_SANITY_CHECK_INVALID_TOKEN",
sanity=true,
})
local u=#t
local a=0
local d=0
local o=0
local n={}
local h={}
local s={}
local y={READ=true,SIT=true,STAND=true,TRAIN=true,LAYDOWN=true,KNEEL=true,SLEEP=true,LEAN=true,DANCE=true,COWER=true}
local c=1.0
m:RegisterEvent("CHAT_MSG_TEXT_EMOTE")
e.sewPrint("Test started.","info")
local function i()
if r or a>=u then
f=false
w:SetText("Test All Emotes")
m:UnregisterEvent("CHAT_MSG_TEXT_EMOTE")
if r then
e.sewPrint("Test stopped.","info")
return
end
e.sewPrint(string.format("Test done: %d passed, %d failed, %d silent, %d skipped.",d,#n,#h,o),"info")
for a,t in ipairs(n)do e.sewPrint("  FAIL: "..t.name.." ("..t.cmd..")"..(t.sanity and" [expected]"or""),"warn")end
for a,t in ipairs(h)do e.sewPrint("  SILENT: "..t.name.." ("..t.cmd..")"..(t.sanity and" [expected]"or""),"warn")end
for a,t in ipairs(s)do e.sewPrint("  SKIPPED: "..t.name.." ("..t.cmd..")","warn")end
return
end
a=a+1
local t=t[a]
l=false
w:SetText(a.." / "..u)
if y[t.cmd]then
o=o+1
table.insert(s,t)
C_Timer.After(0,i)
return
end
e.lastAttemptedEmote=t.name
local r,a=pcall(DoEmote,t.cmd)
if not r then
e.sewPrint("DoEmote errored on "..t.name.." ("..t.cmd.."): "..tostring(a),"warn")
table.insert(n,t)
if t.sanity then e.sewPrint("Sanity check result: FAIL - unexpected for this token, but still not a PASS.","info")end
C_Timer.After(0,i)
return
end
C_Timer.After(c,function()
if l then
d=d+1
e.sewPrint("PASS (confirmed via CHAT_MSG_TEXT_EMOTE): "..t.name,"debug")
if t.sanity then
e.sewPrint("Sanity check result: PASS - this should not happen; a real emote's event was likely misattributed here.","warn")
end
elseif a then
o=o+1
table.insert(s,t)
e.sewPrint("SKIP (restricted): "..t.name,"debug")
if t.sanity then e.sewPrint("Sanity check result: SKIP (restricted) - unexpected for a made-up token, but still not a PASS.","info")end
else
table.insert(h,t)
e.sewPrint("SILENT (no confirming event): "..t.name,"debug")
if t.sanity then e.sewPrint("Sanity check result: SILENT, as expected.","info")end
end
i()
end)
end
i()
end)
local r=e.createButton(a,"Preview Class Colors",d,n)
r:SetPoint("TOPLEFT",s,"TOPRIGHT",c,0)
local m=r.label
do
local n={
"DEATHKNIGHT","DEMONHUNTER","DRUID","EVOKER","HUNTER",
"MAGE","MONK","PALADIN","PRIEST","ROGUE",
"SHAMAN","WARLOCK","WARRIOR",
}
local u={
DEATHKNIGHT="Death Knight",DEMONHUNTER="Demon Hunter",
DRUID="Druid",EVOKER="Evoker",HUNTER="Hunter",
MAGE="Mage",MONK="Monk",PALADIN="Paladin",
PRIEST="Priest",ROGUE="Rogue",SHAMAN="Shaman",
WARLOCK="Warlock",WARRIOR="Warrior",
}
local c={
DEATHKNIGHT="Interface\\Icons\\ClassIcon_DeathKnight",
DEMONHUNTER="Interface\\Icons\\ClassIcon_DemonHunter",
DRUID="Interface\\Icons\\ClassIcon_Druid",
EVOKER="Interface\\Icons\\ClassIcon_Evoker",
HUNTER="Interface\\Icons\\ClassIcon_Hunter",
MAGE="Interface\\Icons\\ClassIcon_Mage",
MONK="Interface\\Icons\\ClassIcon_Monk",
PALADIN="Interface\\Icons\\ClassIcon_Paladin",
PRIEST="Interface\\Icons\\ClassIcon_Priest",
ROGUE="Interface\\Icons\\ClassIcon_Rogue",
SHAMAN="Interface\\Icons\\ClassIcon_Shaman",
WARLOCK="Interface\\Icons\\ClassIcon_Warlock",
WARRIOR="Interface\\Icons\\ClassIcon_Warrior",
}
local o=0
local a=nil
local t=0
local d=nil
local h=nil
local function l()
o=(o%#n)+1
local s=n[o]
local t=e.CLASS_COLORS[s]
local a,t,i=t[1],t[2],t[3]
e.applyTheme({
name="Class Color",
col={
centerFill=y,
centerInner={a,t,i,0.35},
wheelBorder={a,t,i,1.00},
wheelBg=b,
innerCircle=v,
spoke={a,t,i,0.80},
labelNorm=e.classLabelNorm(a,t,i),
labelHot={a,t,i,1.00},
},
})
e.applyIcon(c[s])
if e.iconDropLabel then e.iconDropLabel:SetText(u[s])end
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.theme=d
StryksEmoteWheelDB.icon=h
m:SetText(u[s].." ("..o.."/"..#n..")")
end
local function i()
e.colorPreviewActive=false
local t=e.THEMES[1]
for o,a in ipairs(e.THEMES)do
if a.name==d then t=a;break end
end
e.applyTheme(t)
if h then e.applyIcon(h)end
m:SetText("Preview Class Colors")
o=0
end
r:SetScript("OnClick",function()
if a then
a:Cancel()
a=nil
t=t+1
i()
e.sewPrint("Class preview stopped.","debug")
else
d=StryksEmoteWheelDB and StryksEmoteWheelDB.theme
h=StryksEmoteWheelDB and StryksEmoteWheelDB.icon
e.colorPreviewActive=true
t=t+1
local o=t
if e.closeAllDropdowns then e.closeAllDropdowns()end
l()
a=C_Timer.NewTicker(1,l,#n-1)
C_Timer.After(#n,function()
if a and t==o then
a=nil
i()
e.sewPrint("Class preview finished one round.","debug")
end
end)
e.sewPrint("Class preview started.","debug")
end
end)
end
local l=e.createButton(a,"Preview Expansion Colors",d,n)
l:SetPoint("TOPLEFT",r,"BOTTOMLEFT",0,-c)
local r=l.label
do
local t={}
for a,e in ipairs(e.THEMES)do
if e.name~="Class Color"then
table.insert(t,e)
end
end
local i=0
local o=nil
local a=0
local n=nil
local function s()
i=(i%#t)+1
local a=t[i]
e.applyTheme(a)
StryksEmoteWheelDB=StryksEmoteWheelDB or{}
StryksEmoteWheelDB.theme=n
r:SetText(a.name.." ("..i.."/"..#t..")")
end
local function h()
e.colorPreviewActive=false
local a=e.THEMES[1]
for o,t in ipairs(e.THEMES)do
if t.name==n then a=t;break end
end
e.applyTheme(a)
r:SetText("Preview Expansion Colors")
i=0
end
l:SetScript("OnClick",function()
if o then
o:Cancel()
o=nil
a=a+1
h()
e.sewPrint("Expansion preview stopped.","debug")
else
n=StryksEmoteWheelDB and StryksEmoteWheelDB.theme
e.colorPreviewActive=true
a=a+1
local i=a
if e.closeAllDropdowns then e.closeAllDropdowns()end
s()
o=C_Timer.NewTicker(1,s,#t-1)
C_Timer.After(#t,function()
if o and a==i then
o=nil
h()
e.sewPrint("Expansion preview finished one round.","debug")
end
end)
e.sewPrint("Expansion preview started.","debug")
end
end)
end
local t=e.createButton(a,"Stick Test",d,n)
t:SetPoint("TOPLEFT",s,"BOTTOMLEFT",0,-c)
t:SetScript("OnClick",function()
if e.slashSticktest then e.slashSticktest()end
end)
local o,t,d,m=600,540,10,14
local r=o-16*2-d*2-16
local s=e.createPopout("Changelog",o,t)
local c=e.createWell(s)
c:SetPoint("TOPLEFT",s,"TOPLEFT",16,-50)
c:SetPoint("BOTTOMRIGHT",s,"BOTTOMRIGHT",-16,16)
local b=t-50-16-d*2
local l=CreateFrame("ScrollFrame",nil,c)
l:SetPoint("TOPLEFT",c,"TOPLEFT",d,-d)
l:SetPoint("BOTTOMRIGHT",c,"BOTTOMRIGHT",-16,d)
l:EnableMouseWheel(true)
local t=CreateFrame("Frame",nil,l)
t:SetWidth(r)
t:SetHeight(b)
l:SetScrollChild(t)
local o=CreateFrame("EditBox",nil,t)
o:SetMultiLine(true)
o:SetAutoFocus(false)
o:SetFontObject(ChatFontNormal)
o:SetWidth(r)
o:SetPoint("TOPLEFT",t,"TOPLEFT",0,0)
o:SetScript("OnEscapePressed",o.ClearFocus)
e.onTheme(function(e)
local e=e.labelNorm
o:SetTextColor(e[1],e[2],e[3],1)
end)
o:Hide()
local j=e.createScrollbar(
c,l,t,d,d,m)
local d=s:CreateFontString(nil,"OVERLAY")
d:SetFontObject(ChatFontNormal)
d:SetWidth(r)
d:SetJustifyH("LEFT")
d:SetWordWrap(true)
d:Hide()
local function v()
return e.CHANGELOG_TEXT or"Changelog not available in this build."
end
o:SetScript("OnTextChanged",function(e,t)
if t then e:SetText(v())end
end)
local c,m,w,y={},{},0,0
local function q(e)
return string.format("|cff%02x%02x%02x",e[1]*255+0.5,e[2]*255+0.5,e[3]*255+0.5)
end
local function f(i,a,o)
w=w+1
local e=c[w]
if not e then
e=t:CreateFontString(nil,"OVERLAY")
e:SetJustifyH("LEFT")
e:SetJustifyV("TOP")
e:SetWordWrap(true)
c[w]=e
end
e:ClearAllPoints()
e:SetFontObject(i)
e:SetTextColor(a[1],a[2],a[3],a[4]or 1)
e:SetWidth(o)
e:Show()
return e
end
local function z()
y=y+1
local e=m[y]
if not e then
e=t:CreateTexture(nil,"ARTWORK")
e:SetHeight(1)
m[y]=e
end
e:ClearAllPoints()
e:Show()
return e
end
local function x()
for e=1,#c do c[e]:Hide()end
for e=1,#m do m[e]:Hide()end
w,y=0,0
local e=e.CFG.col
local s,m,n=e.labelHot,e.labelNorm,e.wheelBorder
local a,o=q(s),q(n)
local h=_G["GameFontHighlight"]or ChatFontNormal
local function i(e)
e=e:gsub("|","||")
e=e:gsub("%*%*(.-)%*%*",a.."%1|r")
e=e:gsub("`(.-)`",o.."%1|r")
return e
end
local e=0
local function o(a,o,n,i)
a:SetText(o)
e=e+i
a:SetPoint("TOPLEFT",t,"TOPLEFT",n,-e)
e=e+a:GetStringHeight()
return a
end
for a in(v().."\n"):gmatch("(.-)\n")do
local c=a:match("^####%s+(.*)")
local u=a:match("^###%s+(.*)")
local d=a:match("^#%s+(.*)")
local l=a:match("^%s*[-*]%s+(.*)")
if d then
o(f(_G["GameFontNormalHuge"]or _G["GameFontNormalLarge"],s,r),i(d),0,0)
e=e+4
elseif u then
o(f(_G["GameFontNormalLarge"],s,r),i(u),0,14)
local a=z()
a:SetPoint("TOPLEFT",t,"TOPLEFT",0,-(e+3))
a:SetPoint("TOPRIGHT",t,"TOPRIGHT",0,-(e+3))
a:SetColorTexture(n[1],n[2],n[3],0.8)
e=e+6
elseif c then
o(f(GameFontNormal,n,r),i(c),0,10)
elseif l then
local a=f(h,s,12)
a:SetText("\226\128\162")
local n=f(h,m,r-16)
local e=e+4
a:SetPoint("TOPLEFT",t,"TOPLEFT",4,-e)
o(n,i(l),16,4)
elseif a:match("%S")then
o(f(h,m,r),i(a),0,6)
end
end
t:SetHeight(math.max(e+8,b))
end
local r=false
local function f()
l:SetVerticalScroll(0)
if r then
for e=1,#c do c[e]:Hide()end
for e=1,#m do m[e]:Hide()end
local e=v()
o:SetText(e)
d:SetText(e)
local e=math.max(d:GetStringHeight()+8,b)
o:SetHeight(e)
t:SetHeight(e)
o:Show()
else
o:Hide()
x()
end
j()
end
local t=e.createButton(s,"Show Raw",120,22)
t:SetPoint("TOPRIGHT",s,"TOPRIGHT",-42,-12)
t:SetScript("OnClick",function()
r=not r
t:SetLabel(r and"Show Formatted"or"Show Raw")
f()
end)
s:HookScript("OnShow",f)
k:SetScript("OnClick",function()
s:SetShown(not s:IsShown())
end)
e.addSectionHeader(a,"Debug Log",h,-176)
local l=14
local o=8
local r=e.createButton(a,"Select All",120,n)
r:SetPoint("TOPLEFT",a,"TOPLEFT",h,-200)
local d=e.createButton(a,"Clear Log",120,n)
d:SetPoint("TOPLEFT",r,"TOPRIGHT",10,0)
local s=e.createWell(a)
s:SetPoint("TOPLEFT",r,"BOTTOMLEFT",0,-10)
s:SetPoint("BOTTOMRIGHT",a,"BOTTOMRIGHT",-h,6)
local h=math.floor(e.CONTENT_H-200-n-10-6-o*2)
local n=CreateFrame("ScrollFrame",nil,s)
n:SetPoint("TOPLEFT",s,"TOPLEFT",o,-o)
n:SetPoint("BOTTOMRIGHT",s,"BOTTOMRIGHT",-18,o)
local c=g-o-24
local t=CreateFrame("EditBox",nil,n)
t:SetMultiLine(true)
t:SetAutoFocus(false)
t:SetFontObject(ChatFontNormal)
t:SetWidth(c)
t:SetPoint("TOPLEFT",n,"TOPLEFT",0,0)
t:SetHeight(h)
t:SetScript("OnEscapePressed",t.ClearFocus)
e.onTheme(function(e)
local e=e.labelNorm
t:SetTextColor(e[1],e[2],e[3],1)
end)
n:SetScrollChild(t)
local o=e.createScrollbar(
s,n,t,o,o,l)
e.refreshDebugLogView=function()
if not a:IsVisible()then return end
t:SetText(table.concat(e.debugLog,"\n"))
t:SetHeight(math.max(#e.debugLog*l+8,h))
o()
end
r:SetScript("OnClick",function()
t:SetFocus()
t:HighlightText()
end)
d:SetScript("OnClick",function()
wipe(e.debugLog)
e.refreshDebugLogView()
end)
e.refreshDebugTab=function()
local t=e.debugEnabled
a:SetShown(t)
u:SetShown(not t)
p:SetLabel(t and"Disable Debug Mode"or"Enable Debug Mode")
p:SetActive(t)
if t then e.refreshDebugLogView()end
end
i:HookScript("OnShow",e.refreshDebugTab)
e.refreshDebugTab()

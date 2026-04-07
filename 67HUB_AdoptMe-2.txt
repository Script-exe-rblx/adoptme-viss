--========================================================
-- 67 HUB XoSh — Adopt Me Hub
-- Orange Theme | 30s Loading Screen
--========================================================

local Players          = game:GetService("Players")
local TweenService     = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService       = game:GetService("RunService")
local player           = Players.LocalPlayer

local openLauncher

local SCRIPTS = {}

table.insert(SCRIPTS, {
    name  = "Pet Spawner",
    icon  = "🐾",
    desc  = "SPAWN • PETS • ADOPT ME",
    isNew = true,
    kind  = "http",
    code  = "loadstring(game:HttpGet(\"https://pastebin.com/raw/mwagS5pL\"))()",
})

local DURATION = 30

local LoadGui = Instance.new("ScreenGui")
LoadGui.Name="67HUB_AM_Loading"; LoadGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
LoadGui.ResetOnSpawn=false; LoadGui.IgnoreGuiInset=true
LoadGui.Parent=player:WaitForChild("PlayerGui")

local LoadOverlay=Instance.new("Frame",LoadGui)
LoadOverlay.Size=UDim2.new(1,0,1,0); LoadOverlay.BackgroundColor3=Color3.fromRGB(0,0,0)
LoadOverlay.BackgroundTransparency=0.65; LoadOverlay.BorderSizePixel=0; LoadOverlay.ZIndex=1

for i=1,10 do
    local l=Instance.new("Frame",LoadOverlay); l.Size=UDim2.new(1,0,0,1)
    l.Position=UDim2.new(0,0,i/11,0); l.BackgroundColor3=Color3.fromRGB(140,80,0)
    l.BackgroundTransparency=0.92; l.BorderSizePixel=0
end
for i=1,16 do
    local l=Instance.new("Frame",LoadOverlay); l.Size=UDim2.new(0,1,1,0)
    l.Position=UDim2.new(i/17,0,0,0); l.BackgroundColor3=Color3.fromRGB(140,80,0)
    l.BackgroundTransparency=0.92; l.BorderSizePixel=0
end

local Card=Instance.new("Frame",LoadGui)
Card.Size=UDim2.new(0.72,0,0.72,0); Card.Position=UDim2.new(0.14,0,0.14,0)
Card.BackgroundColor3=Color3.fromRGB(22,12,6); Card.BackgroundTransparency=0
Card.BorderSizePixel=0; Card.ZIndex=2
Instance.new("UICorner",Card).CornerRadius=UDim.new(0,12)

local CardStroke=Instance.new("UIStroke",Card)
CardStroke.Thickness=1.5; CardStroke.Color=Color3.fromRGB(255,140,0)
task.spawn(function()
    while Card.Parent do
        TweenService:Create(CardStroke,TweenInfo.new(1.2,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(255,200,60)}):Play(); task.wait(1.2)
        TweenService:Create(CardStroke,TweenInfo.new(1.2,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(180,80,0)}):Play(); task.wait(1.2)
    end
end)

local function mkCorner(parent,ax,ay)
    local f=Instance.new("Frame",parent); f.Size=UDim2.new(0,14,0,14); f.AnchorPoint=Vector2.new(ax,ay)
    f.Position=UDim2.new(ax,ax==0 and 8 or -8,ay,ay==0 and 8 or -8)
    f.BackgroundTransparency=1; f.BorderSizePixel=0; f.ZIndex=5
    local h=Instance.new("Frame",f); h.Size=UDim2.new(1,0,0,2)
    h.Position=UDim2.new(0,0,ay==0 and 0 or 1,ay==0 and 0 or -2)
    h.BackgroundColor3=Color3.fromRGB(255,180,0); h.BorderSizePixel=0; h.ZIndex=5
    local v=Instance.new("Frame",f); v.Size=UDim2.new(0,2,1,0)
    v.Position=UDim2.new(ax==0 and 0 or 1,ax==0 and 0 or -2,0,0)
    v.BackgroundColor3=Color3.fromRGB(255,180,0); v.BorderSizePixel=0; v.ZIndex=5
end
mkCorner(Card,0,0); mkCorner(Card,1,0); mkCorner(Card,0,1); mkCorner(Card,1,1)

local LC=Instance.new("Frame",Card)
LC.Size=UDim2.new(1,-48,1,-44); LC.Position=UDim2.new(0,24,0,22)
LC.BackgroundTransparency=1; LC.BorderSizePixel=0; LC.ZIndex=3

local TopTag=Instance.new("TextLabel",LC)
TopTag.Size=UDim2.new(1,0,0,12); TopTag.Position=UDim2.new(0,0,0,0)
TopTag.BackgroundTransparency=1; TopTag.Text="SYS_INIT  //  ADOPT ME HUB"
TopTag.Font=Enum.Font.Code; TopTag.TextSize=9
TopTag.TextColor3=Color3.fromRGB(180,100,0); TopTag.TextXAlignment=Enum.TextXAlignment.Left; TopTag.ZIndex=3

local Logo67=Instance.new("TextLabel",LC)
Logo67.Size=UDim2.new(0,140,0,80); Logo67.Position=UDim2.new(0,0,0,16)
Logo67.BackgroundTransparency=1; Logo67.Text="67"
Logo67.Font=Enum.Font.GothamBold; Logo67.TextSize=76
Logo67.TextColor3=Color3.fromRGB(255,255,255); Logo67.TextXAlignment=Enum.TextXAlignment.Left; Logo67.ZIndex=3

local LogoHub=Instance.new("TextLabel",LC)
LogoHub.Size=UDim2.new(0,120,0,36); LogoHub.Position=UDim2.new(0,108,0,48)
LogoHub.BackgroundTransparency=1; LogoHub.Text="HUB"
LogoHub.Font=Enum.Font.GothamBold; LogoHub.TextSize=28
LogoHub.TextColor3=Color3.fromRGB(255,140,0); LogoHub.TextXAlignment=Enum.TextXAlignment.Left; LogoHub.ZIndex=3

local XoSh=Instance.new("TextLabel",LC)
XoSh.Size=UDim2.new(0,60,0,80); XoSh.Position=UDim2.new(1,-56,0,16)
XoSh.BackgroundTransparency=1; XoSh.Text="A\nd\no\np\nt"
XoSh.Font=Enum.Font.Code; XoSh.TextSize=9
XoSh.TextColor3=Color3.fromRGB(120,60,0); XoSh.TextXAlignment=Enum.TextXAlignment.Right
XoSh.LineHeight=1.2; XoSh.ZIndex=3

local LDiv=Instance.new("Frame",LC)
LDiv.Size=UDim2.new(1,0,0,1); LDiv.Position=UDim2.new(0,0,0,102)
LDiv.BackgroundColor3=Color3.fromRGB(255,140,0); LDiv.BackgroundTransparency=0.6; LDiv.BorderSizePixel=0; LDiv.ZIndex=3

local statuses={{txt="INJECTING ENV",state="done"},{txt="BYPASS ANTICHEAT",state="done"},{txt="LOAD MODULES",state="active"},{txt="FINALIZE CONTEXT",state="wait"}}
local sLabels,sDots={},{}
for i,s in ipairs(statuses) do
    local row=Instance.new("Frame",LC); row.Size=UDim2.new(1,0,0,16)
    row.Position=UDim2.new(0,0,0,112+(i-1)*20); row.BackgroundTransparency=1; row.BorderSizePixel=0; row.ZIndex=3
    local dot=Instance.new("Frame",row); dot.Size=UDim2.new(0,5,0,5)
    dot.Position=UDim2.new(0,0,0.5,-2.5); dot.BorderSizePixel=0; dot.ZIndex=4
    Instance.new("UICorner",dot).CornerRadius=UDim.new(1,0)
    local lbl=Instance.new("TextLabel",row); lbl.Size=UDim2.new(1,-14,1,0)
    lbl.Position=UDim2.new(0,14,0,0); lbl.BackgroundTransparency=1
    lbl.Font=Enum.Font.Code; lbl.TextSize=10; lbl.TextXAlignment=Enum.TextXAlignment.Left; lbl.ZIndex=4
    local suf=Instance.new("TextLabel",row); suf.Size=UDim2.new(0,50,1,0)
    suf.Position=UDim2.new(1,-50,0,0); suf.BackgroundTransparency=1
    suf.Font=Enum.Font.Code; suf.TextSize=10; suf.TextXAlignment=Enum.TextXAlignment.Right; suf.ZIndex=4
    if s.state=="done" then
        dot.BackgroundColor3=Color3.fromRGB(255,160,0); lbl.TextColor3=Color3.fromRGB(200,120,0); lbl.Text=s.txt
        suf.TextColor3=Color3.fromRGB(255,160,0); suf.Text="OK"
    elseif s.state=="active" then
        dot.BackgroundColor3=Color3.fromRGB(255,200,60); lbl.TextColor3=Color3.fromRGB(255,200,60); lbl.Text=s.txt
        suf.TextColor3=Color3.fromRGB(255,200,60); suf.Text="WAIT"
    else
        dot.BackgroundColor3=Color3.fromRGB(80,50,20); lbl.TextColor3=Color3.fromRGB(80,50,20); lbl.Text=s.txt
        suf.TextColor3=Color3.fromRGB(80,50,20); suf.Text="---"
    end
    sLabels[i]={lbl=lbl,suf=suf}; sDots[i]=dot
end

local blinkIdx=3
task.spawn(function()
    while Card.Parent do
        if sDots[blinkIdx] then
            TweenService:Create(sDots[blinkIdx],TweenInfo.new(0.5,Enum.EasingStyle.Sine),{BackgroundTransparency=0.85}):Play(); task.wait(0.5)
            TweenService:Create(sDots[blinkIdx],TweenInfo.new(0.5,Enum.EasingStyle.Sine),{BackgroundTransparency=0}):Play(); task.wait(0.5)
        else task.wait(0.5) end
    end
end)

local ProgY=112+4*20+10
local ProgTrack=Instance.new("Frame",LC); ProgTrack.Size=UDim2.new(1,0,0,2)
ProgTrack.Position=UDim2.new(0,0,0,ProgY); ProgTrack.BackgroundColor3=Color3.fromRGB(60,30,10)
ProgTrack.BorderSizePixel=0; ProgTrack.ZIndex=3
local ProgFill=Instance.new("Frame",ProgTrack); ProgFill.Size=UDim2.new(0,0,1,0)
ProgFill.BackgroundColor3=Color3.fromRGB(255,140,0); ProgFill.BorderSizePixel=0; ProgFill.ZIndex=4
local Shimmer=Instance.new("Frame",ProgFill); Shimmer.Size=UDim2.new(0,20,1,0)
Shimmer.AnchorPoint=Vector2.new(1,0); Shimmer.Position=UDim2.new(1,0,0,0)
Shimmer.BackgroundColor3=Color3.fromRGB(255,230,150); Shimmer.BackgroundTransparency=0.4; Shimmer.BorderSizePixel=0; Shimmer.ZIndex=5

local PctRow=Instance.new("Frame",LC); PctRow.Size=UDim2.new(1,0,0,14)
PctRow.Position=UDim2.new(0,0,0,ProgY+6); PctRow.BackgroundTransparency=1; PctRow.BorderSizePixel=0; PctRow.ZIndex=3
local PctLbl=Instance.new("TextLabel",PctRow); PctLbl.Size=UDim2.new(0.5,0,1,0)
PctLbl.BackgroundTransparency=1; PctLbl.Text="0%"; PctLbl.Font=Enum.Font.GothamBold
PctLbl.TextSize=10; PctLbl.TextColor3=Color3.fromRGB(255,140,0); PctLbl.TextXAlignment=Enum.TextXAlignment.Left; PctLbl.ZIndex=3
local TimeLbl=Instance.new("TextLabel",PctRow); TimeLbl.Size=UDim2.new(0.5,0,1,0)
TimeLbl.Position=UDim2.new(0.5,0,0,0); TimeLbl.BackgroundTransparency=1; TimeLbl.Text="30s"
TimeLbl.Font=Enum.Font.Code; TimeLbl.TextSize=9; TimeLbl.TextColor3=Color3.fromRGB(80,50,20)
TimeLbl.TextXAlignment=Enum.TextXAlignment.Right; TimeLbl.ZIndex=3

local BotLbl=Instance.new("TextLabel",LC); BotLbl.Size=UDim2.new(1,0,0,12)
BotLbl.Position=UDim2.new(0,0,1,-12); BotLbl.BackgroundTransparency=1
BotLbl.Text="DO NOT CLOSE  //  ADOPT ME HUB LOADING"
BotLbl.Font=Enum.Font.Code; BotLbl.TextSize=9
BotLbl.TextColor3=Color3.fromRGB(120,60,0); BotLbl.TextXAlignment=Enum.TextXAlignment.Center; BotLbl.ZIndex=3
task.spawn(function()
    while Card.Parent do
        TweenService:Create(BotLbl,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{TextTransparency=0.6}):Play(); task.wait(0.9)
        TweenService:Create(BotLbl,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{TextTransparency=0}):Play(); task.wait(0.9)
    end
end)

Card.BackgroundTransparency=1; Card.Position=UDim2.new(0.14,0,0.18,0)
LoadOverlay.BackgroundTransparency=1
TweenService:Create(LoadOverlay,TweenInfo.new(0.3),{BackgroundTransparency=0.65}):Play()
TweenService:Create(Card,TweenInfo.new(0.45,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{
    BackgroundTransparency=0,Position=UDim2.new(0.14,0,0.14,0)
}):Play()

task.delay(4,function()
    sDots[3].BackgroundColor3=Color3.fromRGB(255,160,0); sLabels[3].lbl.TextColor3=Color3.fromRGB(200,120,0)
    sLabels[3].suf.TextColor3=Color3.fromRGB(255,160,0); sLabels[3].suf.Text="OK"; blinkIdx=4
    sDots[4].BackgroundColor3=Color3.fromRGB(255,200,60); sLabels[4].lbl.TextColor3=Color3.fromRGB(255,200,60)
    sLabels[4].suf.TextColor3=Color3.fromRGB(255,200,60); sLabels[4].suf.Text="WAIT"
end)
task.delay(27,function()
    sDots[4].BackgroundColor3=Color3.fromRGB(255,160,0); sLabels[4].lbl.TextColor3=Color3.fromRGB(200,120,0)
    sLabels[4].suf.TextColor3=Color3.fromRGB(255,160,0); sLabels[4].suf.Text="OK"; blinkIdx=0
    PctLbl.TextColor3=Color3.fromRGB(255,160,0); ProgFill.BackgroundColor3=Color3.fromRGB(255,160,0)
end)

local loadStart=tick(); local loadConn
loadConn=RunService.Heartbeat:Connect(function()
    local elapsed=tick()-loadStart; local progress=math.min(1,elapsed/DURATION)
    ProgFill.Size=UDim2.new(progress,0,1,0)
    PctLbl.Text=math.floor(progress*100).."%"; TimeLbl.Text=math.max(0,math.ceil(DURATION-elapsed)).."s"
    if progress>=1 then
        loadConn:Disconnect(); PctLbl.Text="100%"; TimeLbl.Text="0s"
        task.wait(0.4)
        TweenService:Create(Card,TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency=1,Position=UDim2.new(0.14,0,0.08,0)}):Play()
        TweenService:Create(LoadOverlay,TweenInfo.new(0.4),{BackgroundTransparency=1}):Play()
        task.wait(0.6); LoadGui:Destroy(); openLauncher()
    end
end)

--========================================================
-- LAUNCHER GUI — Orange Theme
--========================================================

local ScreenGui=Instance.new("ScreenGui")
ScreenGui.Name="AM_Launcher"; ScreenGui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn=false; ScreenGui.IgnoreGuiInset=true
ScreenGui.Parent=player:WaitForChild("PlayerGui")

local Overlay=Instance.new("Frame",ScreenGui)
Overlay.Size=UDim2.new(1,0,1,0); Overlay.BackgroundColor3=Color3.fromRGB(0,0,0)
Overlay.BackgroundTransparency=0.5; Overlay.BorderSizePixel=0; Overlay.ZIndex=1

local Panel=Instance.new("Frame",ScreenGui)
Panel.Name="Panel"; Panel.Size=UDim2.new(0.88,0,0.62,0); Panel.Position=UDim2.new(0.06,0,0.19,0)
Panel.BackgroundColor3=Color3.fromRGB(20,10,4); Panel.BackgroundTransparency=0.06
Panel.BorderSizePixel=0; Panel.Active=true; Panel.Draggable=true; Panel.ZIndex=2
Instance.new("UICorner",Panel).CornerRadius=UDim.new(0,14)

local panelStroke=Instance.new("UIStroke",Panel)
panelStroke.Thickness=1.8; panelStroke.Color=Color3.fromRGB(255,140,0)
task.spawn(function()
    while Panel.Parent do
        TweenService:Create(panelStroke,TweenInfo.new(0.7,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(255,200,60)}):Play(); task.wait(0.7)
        TweenService:Create(panelStroke,TweenInfo.new(0.7,Enum.EasingStyle.Sine),{Color=Color3.fromRGB(180,80,0)}):Play(); task.wait(0.7)
    end
end)

local Sidebar=Instance.new("Frame",Panel)
Sidebar.Size=UDim2.new(0.32,0,1,0); Sidebar.BackgroundColor3=Color3.fromRGB(200,100,0)
Sidebar.BackgroundTransparency=0.88; Sidebar.BorderSizePixel=0
Instance.new("UICorner",Sidebar).CornerRadius=UDim.new(0,14)

local sideDiv=Instance.new("Frame",Sidebar); sideDiv.Size=UDim2.new(0,1,1,0); sideDiv.Position=UDim2.new(1,-1,0,0)
sideDiv.BackgroundColor3=Color3.fromRGB(255,140,0); sideDiv.BackgroundTransparency=0.7; sideDiv.BorderSizePixel=0

local SideHeader=Instance.new("Frame",Sidebar); SideHeader.Size=UDim2.new(1,0,0,56)
SideHeader.BackgroundColor3=Color3.fromRGB(200,100,0); SideHeader.BackgroundTransparency=0.82; SideHeader.BorderSizePixel=0
Instance.new("UICorner",SideHeader).CornerRadius=UDim.new(0,14)

local LogoBg=Instance.new("Frame",SideHeader); LogoBg.Size=UDim2.new(0,30,0,30); LogoBg.Position=UDim2.new(0,10,0.5,-15)
LogoBg.BackgroundColor3=Color3.fromRGB(255,140,0); LogoBg.BorderSizePixel=0
Instance.new("UICorner",LogoBg).CornerRadius=UDim.new(0,8)
local LogoLbl=Instance.new("TextLabel",LogoBg); LogoLbl.Size=UDim2.new(1,0,1,0); LogoLbl.BackgroundTransparency=1
LogoLbl.Text="67"; LogoLbl.Font=Enum.Font.GothamBold; LogoLbl.TextSize=13; LogoLbl.TextColor3=Color3.fromRGB(255,255,255)
task.spawn(function()
    while LogoBg.Parent do
        TweenService:Create(LogoBg,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(180,80,0)}):Play(); task.wait(0.9)
        TweenService:Create(LogoBg,TweenInfo.new(0.9,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(255,180,0)}):Play(); task.wait(0.9)
    end
end)

local HubTitle=Instance.new("TextLabel",SideHeader); HubTitle.Size=UDim2.new(1,-50,0,18); HubTitle.Position=UDim2.new(0,48,0,9)
HubTitle.BackgroundTransparency=1; HubTitle.Text="67 HUB XoSh"; HubTitle.Font=Enum.Font.GothamBold; HubTitle.TextSize=13
HubTitle.TextColor3=Color3.fromRGB(255,220,180); HubTitle.TextXAlignment=Enum.TextXAlignment.Left

local HubSub=Instance.new("TextLabel",SideHeader); HubSub.Size=UDim2.new(1,-50,0,14); HubSub.Position=UDim2.new(0,48,0,29)
HubSub.BackgroundTransparency=1; HubSub.Text="ADOPT ME"; HubSub.Font=Enum.Font.GothamBold; HubSub.TextSize=9
HubSub.TextColor3=Color3.fromRGB(255,140,0); HubSub.TextTransparency=0.2; HubSub.TextXAlignment=Enum.TextXAlignment.Left

local NavScroll=Instance.new("ScrollingFrame",Sidebar)
NavScroll.Size=UDim2.new(1,0,1,-62); NavScroll.Position=UDim2.new(0,0,0,60)
NavScroll.BackgroundTransparency=1; NavScroll.BorderSizePixel=0
NavScroll.ScrollBarThickness=2; NavScroll.ScrollBarImageColor3=Color3.fromRGB(255,140,0)
NavScroll.CanvasSize=UDim2.new(0,0,0,0); NavScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y
local NavList=Instance.new("UIListLayout",NavScroll); NavList.Padding=UDim.new(0,4)
local NavPad=Instance.new("UIPadding",NavScroll)
NavPad.PaddingTop=UDim.new(0,6); NavPad.PaddingBottom=UDim.new(0,6)
NavPad.PaddingLeft=UDim.new(0,7); NavPad.PaddingRight=UDim.new(0,7)

local Content=Instance.new("Frame",Panel); Content.Size=UDim2.new(0.68,-2,1,0); Content.Position=UDim2.new(0.32,2,0,0)
Content.BackgroundTransparency=1; Content.BorderSizePixel=0

local CloseBtn=Instance.new("TextButton",Content); CloseBtn.Size=UDim2.new(0,28,0,28); CloseBtn.Position=UDim2.new(1,-36,0,10)
CloseBtn.BackgroundColor3=Color3.fromRGB(40,20,10); CloseBtn.BackgroundTransparency=0.3; CloseBtn.BorderSizePixel=0
CloseBtn.Text="✕"; CloseBtn.Font=Enum.Font.GothamBold; CloseBtn.TextSize=13
CloseBtn.TextColor3=Color3.fromRGB(255,160,80); CloseBtn.ZIndex=5
Instance.new("UICorner",CloseBtn).CornerRadius=UDim.new(1,0)

local CP=Instance.new("Frame",Content); CP.Size=UDim2.new(1,-24,1,-24); CP.Position=UDim2.new(0,12,0,12)
CP.BackgroundTransparency=1; CP.BorderSizePixel=0

local IconBox=Instance.new("Frame",CP); IconBox.Size=UDim2.new(0,52,0,52); IconBox.Position=UDim2.new(0,0,0,8)
IconBox.BackgroundColor3=Color3.fromRGB(180,80,0); IconBox.BackgroundTransparency=0.6; IconBox.BorderSizePixel=0
Instance.new("UICorner",IconBox).CornerRadius=UDim.new(0,13)
local IconStroke=Instance.new("UIStroke",IconBox); IconStroke.Thickness=1; IconStroke.Color=Color3.fromRGB(255,140,0); IconStroke.Transparency=0.4
local IconLbl=Instance.new("TextLabel",IconBox); IconLbl.Size=UDim2.new(1,0,1,0); IconLbl.BackgroundTransparency=1
IconLbl.TextSize=26; IconLbl.Font=Enum.Font.GothamBold

local CName=Instance.new("TextLabel",CP); CName.Size=UDim2.new(1,-70,0,28); CName.Position=UDim2.new(0,64,0,10)
CName.BackgroundTransparency=1; CName.Font=Enum.Font.GothamBold; CName.TextSize=18
CName.TextColor3=Color3.fromRGB(255,220,180); CName.TextXAlignment=Enum.TextXAlignment.Left; CName.TextTruncate=Enum.TextTruncate.AtEnd

local CDesc=Instance.new("TextLabel",CP); CDesc.Size=UDim2.new(1,-70,0,18); CDesc.Position=UDim2.new(0,64,0,38)
CDesc.BackgroundTransparency=1; CDesc.Font=Enum.Font.GothamBold; CDesc.TextSize=10
CDesc.TextColor3=Color3.fromRGB(255,140,0); CDesc.TextTransparency=0.2; CDesc.TextXAlignment=Enum.TextXAlignment.Left

local Div=Instance.new("Frame",CP); Div.Size=UDim2.new(1,0,0,1); Div.Position=UDim2.new(0,0,0,72)
Div.BackgroundColor3=Color3.fromRGB(255,140,0); Div.BackgroundTransparency=0.7; Div.BorderSizePixel=0

local SRow=Instance.new("Frame",CP); SRow.Size=UDim2.new(1,0,0,20); SRow.Position=UDim2.new(0,0,0,80)
SRow.BackgroundTransparency=1; SRow.BorderSizePixel=0
local SDot=Instance.new("Frame",SRow); SDot.Size=UDim2.new(0,7,0,7); SDot.Position=UDim2.new(0,0,0.5,-3.5)
SDot.BackgroundColor3=Color3.fromRGB(255,160,0); SDot.BorderSizePixel=0
Instance.new("UICorner",SDot).CornerRadius=UDim.new(1,0)
task.spawn(function()
    while SDot.Parent do
        TweenService:Create(SDot,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundTransparency=0.5}):Play(); task.wait(0.8)
        TweenService:Create(SDot,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundTransparency=0}):Play(); task.wait(0.8)
    end
end)
local STxt=Instance.new("TextLabel",SRow); STxt.Size=UDim2.new(0.5,0,1,0); STxt.Position=UDim2.new(0,13,0,0)
STxt.BackgroundTransparency=1; STxt.Text="READY TO LOAD"; STxt.Font=Enum.Font.GothamBold; STxt.TextSize=9
STxt.TextColor3=Color3.fromRGB(255,160,0); STxt.TextXAlignment=Enum.TextXAlignment.Left
local CTxt=Instance.new("TextLabel",SRow); CTxt.Size=UDim2.new(0.5,0,1,0); CTxt.Position=UDim2.new(0.5,0,0,0)
CTxt.BackgroundTransparency=1; CTxt.Text=#SCRIPTS.." SCRIPTS LOADED"; CTxt.Font=Enum.Font.GothamBold; CTxt.TextSize=9
CTxt.TextColor3=Color3.fromRGB(180,100,0); CTxt.TextTransparency=0.3; CTxt.TextXAlignment=Enum.TextXAlignment.Right

local ExecBtn=Instance.new("TextButton",CP); ExecBtn.Size=UDim2.new(0.55,0,0,36); ExecBtn.Position=UDim2.new(0,0,1,-44)
ExecBtn.BackgroundColor3=Color3.fromRGB(200,100,0); ExecBtn.BackgroundTransparency=0.25; ExecBtn.BorderSizePixel=0
ExecBtn.Text="▶   EXECUTE SCRIPT"; ExecBtn.Font=Enum.Font.GothamBold; ExecBtn.TextSize=13
ExecBtn.TextColor3=Color3.fromRGB(255,220,180); ExecBtn.AutoButtonColor=false
Instance.new("UICorner",ExecBtn).CornerRadius=UDim.new(0,10)
local ExecStroke=Instance.new("UIStroke",ExecBtn); ExecStroke.Thickness=1.2; ExecStroke.Color=Color3.fromRGB(255,180,0); ExecStroke.Transparency=0.3
ExecBtn.MouseEnter:Connect(function() TweenService:Create(ExecBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(255,140,0),BackgroundTransparency=0.1}):Play() end)
ExecBtn.MouseLeave:Connect(function() TweenService:Create(ExecBtn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(200,100,0),BackgroundTransparency=0.25}):Play() end)

local ReopenBtn=Instance.new("TextButton",ScreenGui); ReopenBtn.Name="ReopenBtn"
ReopenBtn.Size=UDim2.new(0,44,0,44); ReopenBtn.Position=UDim2.new(1,-56,0,14)
ReopenBtn.BackgroundColor3=Color3.fromRGB(200,100,0); ReopenBtn.BackgroundTransparency=0.1; ReopenBtn.BorderSizePixel=0
ReopenBtn.Text="67"; ReopenBtn.Font=Enum.Font.GothamBold; ReopenBtn.TextSize=14
ReopenBtn.TextColor3=Color3.fromRGB(255,255,255); ReopenBtn.ZIndex=20; ReopenBtn.Visible=false
Instance.new("UICorner",ReopenBtn).CornerRadius=UDim.new(1,0)
local orbStroke=Instance.new("UIStroke",ReopenBtn); orbStroke.Thickness=2; orbStroke.Color=Color3.fromRGB(255,200,60)
task.spawn(function()
    while ReopenBtn.Parent do
        TweenService:Create(ReopenBtn,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(180,80,0)}):Play(); task.wait(0.8)
        TweenService:Create(ReopenBtn,TweenInfo.new(0.8,Enum.EasingStyle.Sine),{BackgroundColor3=Color3.fromRGB(255,160,0)}):Play(); task.wait(0.8)
    end
end)

do
    local dragging,dragStart,startPos=false,nil,nil
    ReopenBtn.InputBegan:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then
            dragging=true; dragStart=inp.Position; startPos=ReopenBtn.Position
        end
    end)
    ReopenBtn.InputEnded:Connect(function(inp)
        if inp.UserInputType==Enum.UserInputType.MouseButton1 or inp.UserInputType==Enum.UserInputType.Touch then dragging=false end
    end)
    UserInputService.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType==Enum.UserInputType.MouseMovement or inp.UserInputType==Enum.UserInputType.Touch) then
            local d=inp.Position-dragStart
            ReopenBtn.Position=UDim2.new(startPos.X.Scale,startPos.X.Offset+d.X,startPos.Y.Scale,startPos.Y.Offset+d.Y)
        end
    end)
end

local panelOpen=true; local selectedIndex=1; local selectedScript=SCRIPTS[1]

local function closePanel()
    panelOpen=false
    TweenService:Create(Panel,TweenInfo.new(0.28,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{Size=UDim2.new(0.88,0,0,0),Position=UDim2.new(0.06,0,0.5,0),BackgroundTransparency=1}):Play()
    TweenService:Create(Overlay,TweenInfo.new(0.22),{BackgroundTransparency=1}):Play()
    task.delay(0.3,function()
        Panel.Visible=false; Overlay.Visible=false; ReopenBtn.Visible=true
        ReopenBtn.Size=UDim2.new(0,0,0,0); ReopenBtn.Position=UDim2.new(1,-28,0,38)
        TweenService:Create(ReopenBtn,TweenInfo.new(0.3,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0,44,0,44),Position=UDim2.new(1,-56,0,14)}):Play()
    end)
end

local navBtns={}
local function updateContent(idx)
    local s=SCRIPTS[idx]; IconLbl.Text=s.icon; CName.Text=s.name; CDesc.Text=s.desc
    selectedScript=s; selectedIndex=idx
    for i,btn in ipairs(navBtns) do
        if i==idx then TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(180,80,0),BackgroundTransparency=0.22}):Play(); btn:FindFirstChild("NavStroke").Transparency=0
        else TweenService:Create(btn,TweenInfo.new(0.15),{BackgroundColor3=Color3.fromRGB(100,50,0),BackgroundTransparency=0.88}):Play(); btn:FindFirstChild("NavStroke").Transparency=0.7 end
    end
end

for i,s in ipairs(SCRIPTS) do
    local NavBtn=Instance.new("TextButton",NavScroll); NavBtn.Name="Nav_"..i
    NavBtn.Size=UDim2.new(1,0,0,38); NavBtn.BackgroundColor3=Color3.fromRGB(100,50,0)
    NavBtn.BackgroundTransparency=0.88; NavBtn.BorderSizePixel=0; NavBtn.Text=""; NavBtn.AutoButtonColor=false
    Instance.new("UICorner",NavBtn).CornerRadius=UDim.new(0,9)
    local ns=Instance.new("UIStroke",NavBtn); ns.Name="NavStroke"; ns.Thickness=1; ns.Color=Color3.fromRGB(255,140,0); ns.Transparency=0.7
    if s.isNew then
        local nb=Instance.new("TextLabel",NavBtn); nb.Size=UDim2.new(0,28,0,14); nb.Position=UDim2.new(1,-32,0,4)
        nb.BackgroundColor3=Color3.fromRGB(255,140,0); nb.BackgroundTransparency=0.2; nb.BorderSizePixel=0
        nb.Text="NEW"; nb.Font=Enum.Font.GothamBold; nb.TextSize=7; nb.TextColor3=Color3.fromRGB(255,255,255); nb.ZIndex=3
        Instance.new("UICorner",nb).CornerRadius=UDim.new(0,4)
    end
    local NIcon=Instance.new("TextLabel",NavBtn); NIcon.Size=UDim2.new(0,28,1,0); NIcon.Position=UDim2.new(0,5,0,0)
    NIcon.BackgroundTransparency=1; NIcon.Text=s.icon; NIcon.TextSize=16; NIcon.Font=Enum.Font.GothamBold
    local NName=Instance.new("TextLabel",NavBtn); NName.Size=UDim2.new(1,-46,1,0); NName.Position=UDim2.new(0,36,0,0)
    NName.BackgroundTransparency=1; NName.Text=s.name; NName.Font=Enum.Font.GothamBold; NName.TextSize=12
    NName.TextColor3=Color3.fromRGB(255,200,150); NName.TextXAlignment=Enum.TextXAlignment.Left; NName.TextTruncate=Enum.TextTruncate.AtEnd
    NavBtn.MouseEnter:Connect(function() if i~=selectedIndex then TweenService:Create(NavBtn,TweenInfo.new(0.13),{BackgroundTransparency=0.7}):Play() end end)
    NavBtn.MouseLeave:Connect(function() if i~=selectedIndex then TweenService:Create(NavBtn,TweenInfo.new(0.13),{BackgroundTransparency=0.88}):Play() end end)
    NavBtn.MouseButton1Click:Connect(function() updateContent(i) end)
    table.insert(navBtns,NavBtn)
end

ExecBtn.MouseButton1Click:Connect(function()
    TweenService:Create(ExecBtn,TweenInfo.new(0.1),{BackgroundColor3=Color3.fromRGB(255,160,0),BackgroundTransparency=0.1}):Play()
    ExecBtn.Text="⏳   LOADING..."; task.wait(0.2); closePanel(); task.wait(0.1)
    local fn,err=loadstring(selectedScript.code)
    if fn then task.spawn(fn) else warn("[67HUB AM] "..tostring(err)) end
    task.delay(0.5,function()
        ExecBtn.Text="▶   EXECUTE SCRIPT"
        TweenService:Create(ExecBtn,TweenInfo.new(0.2),{BackgroundColor3=Color3.fromRGB(200,100,0),BackgroundTransparency=0.25}):Play()
    end)
end)

CloseBtn.MouseButton1Click:Connect(closePanel)
ReopenBtn.MouseButton1Click:Connect(function()
    panelOpen=true; Panel.Visible=true; Overlay.Visible=true
    Panel.Size=UDim2.new(0.88,0,0,0); Panel.Position=UDim2.new(0.06,0,0.5,0)
    Panel.BackgroundTransparency=1; Overlay.BackgroundTransparency=1
    TweenService:Create(Panel,TweenInfo.new(0.32,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0.88,0,0.62,0),Position=UDim2.new(0.06,0,0.19,0),BackgroundTransparency=0.06}):Play()
    TweenService:Create(Overlay,TweenInfo.new(0.22),{BackgroundTransparency=0.5}):Play()
    TweenService:Create(ReopenBtn,TweenInfo.new(0.15),{Size=UDim2.new(0,0,0,0)}):Play()
    task.delay(0.16,function() ReopenBtn.Visible=false end)
end)

Panel.Visible=false; Overlay.Visible=false

function openLauncher()
    Panel.Visible=true; Overlay.Visible=true
    Panel.Size=UDim2.new(0.88,0,0,0); Panel.Position=UDim2.new(0.06,0,0.5,0)
    Panel.BackgroundTransparency=1; Overlay.BackgroundTransparency=1
    TweenService:Create(Overlay,TweenInfo.new(0.3),{BackgroundTransparency=0.5}):Play()
    TweenService:Create(Panel,TweenInfo.new(0.38,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Size=UDim2.new(0.88,0,0.62,0),Position=UDim2.new(0.06,0,0.19,0),BackgroundTransparency=0.06}):Play()
    task.delay(0.05,function() updateContent(1) end)
end

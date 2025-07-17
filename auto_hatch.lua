-- Grow a Garden Auto Hatch with GUI by Adiatma 🧪 Mythical Egg Ready
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Player = Players.LocalPlayer

-- Daftar egg (kamu bisa tambah lagi kalau mau)
local eggList = {"Mythical Egg", "DinosaurusEgg", "GoldenEgg", "SugarAppleEgg"}
local selectedEgg = eggList[1] -- Default: Mythical Egg
local isHatching = false

-- GUI Setup
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "AutoHatchGUI"

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0, 230, 0, 140)
Frame.Position = UDim2.new(0, 20, 0, 100)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.BackgroundTransparency = 0.2
Frame.Active = true
Frame.Draggable = true

local Title = Instance.new("TextLabel", Frame)
Title.Text = "🥚 Auto Hatch GUI"
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18

local Dropdown = Instance.new("TextButton", Frame)
Dropdown.Text = "📦 Pilih Egg"
Dropdown.Size = UDim2.new(1, -20, 0, 30)
Dropdown.Position = UDim2.new(0, 10, 0, 40)
Dropdown.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Dropdown.TextColor3 = Color3.new(1, 1, 1)
Dropdown.Font = Enum.Font.Gotham
Dropdown.TextSize = 14

local selectedLabel = Instance.new("TextLabel", Frame)
selectedLabel.Text = "Selected: " .. selectedEgg
selectedLabel.Size = UDim2.new(1, -20, 0, 20)
selectedLabel.Position = UDim2.new(0, 10, 0, 75)
selectedLabel.BackgroundTransparency = 1
selectedLabel.TextColor3 = Color3.new(1, 1, 1)
selectedLabel.Font = Enum.Font.Gotham
selectedLabel.TextSize = 12

local Toggle = Instance.new("TextButton", Frame)
Toggle.Text = "▶️ Start"
Toggle.Size = UDim2.new(1, -20, 0, 30)
Toggle.Position = UDim2.new(0, 10, 0, 100)
Toggle.BackgroundColor3 = Color3.fromRGB(70, 130, 180)
Toggle.TextColor3 = Color3.new(1, 1, 1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 14

-- Dropdown logic
Dropdown.MouseButton1Click:Connect(function()
    local nextIndex = table.find(eggList, selectedEgg) + 1
    if nextIndex > #eggList then nextIndex = 1 end
    selectedEgg = eggList[nextIndex]
    selectedLabel.Text = "Selected: " .. selectedEgg
end)

-- Hatching logic
Toggle.MouseButton1Click:Connect(function()
    isHatching = not isHatching
    Toggle.Text = isHatching and "⏹ Stop" or "▶️ Start"

    while isHatching do
        local openEggRemote = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("OpenEgg")
        if openEggRemote then
            openEggRemote:InvokeServer(selectedEgg, false)
            print("🎉 Membuka:", selectedEgg)
        else
            warn("Remote OpenEgg tidak ditemukan.")
            break
        end
        wait(2)
    end
end)

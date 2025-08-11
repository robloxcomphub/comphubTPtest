-- Fullscreen Warning + Copy Discord Button + Clipboard Script (PC & Mobile)

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer

-- Disable Reset button
pcall(function()
    StarterGui:SetCore("ResetButtonCallback", false)
end)

-- Copy real script to clipboard
setclipboard('loadstring(game:HttpGet("https://raw.githubusercontent.com/robloxcomphub/comphub/refs/heads/main/comphub.lua"))()')

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false
screenGui.Parent = game.CoreGui

-- Background Frame
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.Position = UDim2.new(0, 0, 0, 0)
background.BackgroundColor3 = Color3.new(1, 1, 1)
background.BackgroundTransparency = 1 -- start transparent for fade in
background.Parent = screenGui

-- Main Text
local mainText = Instance.new("TextLabel")
mainText.Size = UDim2.new(1, -20, 0.7, 0)
mainText.Position = UDim2.new(0, 10, 0.15, 0)
mainText.BackgroundTransparency = 1
mainText.Text = "Join Comphub, this script is stolen.\nThe real speed and ESP is on comphub!\nScript copied to your clipboard!"
mainText.Font = Enum.Font.SourceSansBold
mainText.TextScaled = true
mainText.TextColor3 = Color3.new(0, 0, 0)
mainText.TextWrapped = true
mainText.Parent = background

-- Discord Link
local discordText = Instance.new("TextLabel")
discordText.Size = UDim2.new(1, -20, 0.1, 0)
discordText.Position = UDim2.new(0, 10, 0.78, 0)
discordText.BackgroundTransparency = 1
discordText.Text = "discord.gg/nzRUpxGsu2"
discordText.Font = Enum.Font.SourceSansBold
discordText.TextScaled = true
discordText.TextColor3 = Color3.new(0, 0, 0)
discordText.TextWrapped = true
discordText.Parent = background

-- Copy Discord Button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0.4, 0, 0.08, 0)
copyButton.Position = UDim2.new(0.3, 0, 0.88, 0)
copyButton.BackgroundColor3 = Color3.new(0, 0, 0)
copyButton.TextColor3 = Color3.new(1, 1, 1)
copyButton.Font = Enum.Font.SourceSansBold
copyButton.TextScaled = true
copyButton.Text = "Copy Discord Link"
copyButton.Parent = background

-- Copy function
copyButton.MouseButton1Click:Connect(function()
    setclipboard("discord.gg/nzRUpxGsu2")
end)

-- Fade in effect
TweenService:Create(background, TweenInfo.new(1), {BackgroundTransparency = 0}):Play()

-- LOCK screen — Remove player controls
local function blockInput(input)
    return true
end
game:GetService("UserInputService").InputBegan:Connect(blockInput)
game:GetService("UserInputService").InputChanged:Connect(blockInput)
game:GetService("UserInputService").InputEnded:Connect(blockInput)

-- Remove default Roblox UI
pcall(function()
    StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)
end)

-- Serverhop Button
local hopBtn = Instance.new("TextButton", frame)
hopBtn.Size = UDim2.new(0, 140, 0, 28)
hopBtn.Position = UDim2.new(0.55, 0, 1, -40)
hopBtn.Text = "🌐 Serverhop"
hopBtn.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
hopBtn.TextColor3 = Color3.new(1, 1, 1)
hopBtn.Font = Enum.Font.GothamBold
hopBtn.TextSize = 14
Instance.new("UICorner", hopBtn).CornerRadius = UDim.new(0, 6)

hopBtn.MouseButton1Click:Connect(function()
    local TeleportService = game:GetService("TeleportService")
	local Players = game:GetService("Players")
	local LocalPlayer = Players.LocalPlayer

	-- Script to re-execute
	local scriptToReExecute = [[
		loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/ff603ae844e5bc0f"))()
	]]

	-- Queue it on teleport (works only if your executor supports this)
	if queue_on_teleport then
		queue_on_teleport(scriptToReExecute)
	end

	-- Teleport to same place
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

-- Scanner
function scanPets()
    local searchList = {}
    for pet, isOn in pairs(selected) do
        if isOn then table.insert(searchList, pet) end
    end

    if #searchList == 0 then
        resultText.Text = "No pets selected."
        return
    end

    local function getOwner(plot)
        local gui = plot:FindFirstChild("PlotSign") and plot.PlotSign:FindFirstChild("SurfaceGui")
        local label = gui and gui:FindFirstChild("Frame") and gui.Frame:FindFirstChild("TextLabel")
        return label and label.Text:match("^(.-)'s Base") or "Unknown"
    end

    local myPlot
    for _, plot in ipairs(workspace:WaitForChild("Plots"):GetChildren()) do
        local base = plot:FindFirstChild("YourBase", true)
        if base and base.Enabled then
            myPlot = plot.Name
            break
        end
    end

    local results = ""
    local found = false

    for _, plot in ipairs(workspace.Plots:GetChildren()) do
        if plot.Name ~= myPlot then
            local owner = getOwner(plot)
            for _, obj in ipairs(plot:GetDescendants()) do
                if obj.Name == "DisplayName" and table.find(searchList, obj.Text) then
                    results ..= "✔ " .. obj.Text .. " | Owner: " .. owner .. "\n"
                    StarterGui:SetCore("SendNotification", {
                        Title = "🐾 Pet Found!",
                        Text = obj.Text .. " owned by " .. owner,
                        Duration = 3
                    })
                    found = true
                end
            end
        end
    end

    resultText.Text = found and results or "No selected pets found."
end

scanBtn.MouseButton1Click:Connect(scanPets)
	]]

	-- Queue it on teleport (works only if your executor supports this)
	if queue_on_teleport then
		queue_on_teleport(scriptToReExecute)
	end

	-- Teleport to same place
	TeleportService:Teleport(game.PlaceId, LocalPlayer)
end)

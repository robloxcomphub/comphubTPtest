SubmitButton.MouseButton1Click:Connect(function()
    local userInput = string.lower(InputBox.Text or "")

    -- Initialize Pelinda key check
    local status = Pelinda.Init({
        Service = __PELINDA_SERVICE__,
        SilentMode = __PELINDA_SILENTMODE__,
        Key = userInput,
        SecurityLevel = __PELINDA_SECURITY_LEVEL__
    })

    print("[+] PandaV3 Status: " .. status)

    if status == "validated!!" then
        print("PandaV3 Loaded Successfully!")

        -- Optional: Show loading animation
        SubmitButton.Visible = false
        GetCodeButton.Visible = false
        LoadingCircle.Visible = true

        local angle = 0
        local connection = RunService.Heartbeat:Connect(function(delta)
            angle = (angle + delta * 10) % (2 * math.pi)
            Circle1.Position = UDim2.new(0.5 + math.cos(angle) * 0.4, 0, 0.5 + math.sin(angle) * 0.4, 0)
            Circle2.Position = UDim2.new(0.5 + math.cos(angle + math.pi) * 0.4, 0, 0.5 + math.sin(angle + math.pi) * 0.4, 0)
        end)

        task.wait(1.2)
        connection:Disconnect()

        TweenService:Create(Frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        TweenService:Create(Blur, TweenInfo.new(0.4), {Size = 0}):Play()
        task.wait(0.4)

        ScreenGui:Destroy()
        Blur:Destroy()

        local success, errorMsg = pcall(function()
            local func = loadstring(scriptToLoad)
            if not func then error("Failed to compile scriptToLoad") end
            func()
        end)

        if not success then
            warn("[comp hub ERROR]: Failed to execute scriptToLoad: " .. tostring(errorMsg))
        else
            print("[comp hub]: Successfully executed scriptToLoad")
        end
    else
        -- Invalid key feedback
        NotificationFrame.Visible = true
        NotificationLabel.Text = "Invalid key: " .. status

        TweenService:Create(NotificationLabel, TweenInfo.new(0.3), {
            TextTransparency = 0
        }):Play()

        -- Shake animation
        for i = 1, 3 do
            TweenService:Create(InputBox, TweenInfo.new(0.1), {Position = UDim2.new(0.1, -5, 0.15, 0)}):Play()
            task.wait(0.1)
            TweenService:Create(InputBox, TweenInfo.new(0.1), {Position = UDim2.new(0.1, 5, 0.15, 0)}):Play()
            task.wait(0.1)
        end
        TweenService:Create(InputBox, TweenInfo.new(0.1), {Position = UDim2.new(0.1, 0, 0.15, 0)}):Play()
        InputBox.Text = ""

        task.wait(2)
        TweenService:Create(NotificationLabel, TweenInfo.new(0.3), {
            TextTransparency = 1
        }):Play()
        task.wait(0.3)
        NotificationFrame.Visible = false
    end
end)

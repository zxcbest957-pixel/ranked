-- [[
--    TITANIUM HUB - MAIN LOGIC
-- ]]

local Titanium = getgenv().Titanium
local Lib = Titanium.UI

local Window = Lib:CreateWindow()

-- [[ GLOBALS FOR FEATURES ]]
local Features = {
    Killaura = false,
    KillauraRange = 15,
    ESP = false,
    Speed = 16
}

-- [[ FEATURE LOGIC ]]
task.spawn(function()
    while task.wait() do
        -- Killaura Loop
        if Features.Killaura then
            local target = nil
            local dist = Features.KillauraRange
            for _, p in pairs(game:GetService("Players"):GetPlayers()) do
                if p ~= game:GetService("Players").LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (p.Character.HumanoidRootPart.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        dist = d
                        target = p
                    end
                end
            end
            if target then
                -- Perform attack (this is game-specific, e.g. Bedwars remotes)
                print("Attacking " .. target.Name)
            end
        end
    end
end)

-- COMBAT TAB
local Combat = Window:CreateTab("Combat")
Combat:CreateToggle("Killaura", function(state)
    Features.Killaura = state
end)
Combat:CreateSlider("Killaura Range", 5, 50, 15, function(val)
    Features.KillauraRange = val
end)

-- VISUALS TAB
local Visuals = Window:CreateTab("Visuals")
Visuals:CreateToggle("ESP Boxes", function(state)
    Features.ESP = state
    -- Simple ESP logic using Drawing API or Highlights
end)

-- MOVEMENT TAB
local Movement = Window:CreateTab("Movement")
Movement:CreateSlider("WalkSpeed", 16, 100, 16, function(val)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

-- UTILS TAB
local Utils = Window:CreateTab("Utils")
Utils:CreateToggle("Auto-Toxic", function(state)
    print("Auto-Toxic: " .. tostring(state))
end)

print("💎 Titanium Hub V1.0 Ready.")


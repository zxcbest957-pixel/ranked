-- [[
--    TITANIUM HUB - MAIN LOGIC
-- ]]

local Titanium = getgenv().Titanium
local Lib = Titanium.UI

local Window = Lib:CreateWindow()

-- [[ DYNAMIC FEATURE HANDLER ]]
local function toggleFeature(path, state, isLegacy)
    if state then
        Titanium:LoadModule(path, isLegacy)
        print("[TITANIUM] Activated: " .. path)
    else
        -- Logic to disable feature (if supported by module)
        print("[TITANIUM] Deactivated: " .. path)
    end
end

-- COMBAT TAB
local Combat = Window:CreateTab("Combat")
Combat:CreateToggle("Aim Assist", function(state)
    toggleFeature("features/aimbot.lua", state, true)
end)
Combat:CreateToggle("Killaura", function(state)
    toggleFeature("features/killaura.lua", state, true)
end)

-- BEDWARS TAB
local Bedwars = Window:CreateTab("Bedwars")
Bedwars:CreateToggle("Bed Nuke", function(state)
    toggleFeature("features/bed_nuke.lua", state, true)
end)
Bedwars:CreateToggle("Auto Davey", function(state)
    toggleFeature("features/auto_davey.lua", state, true)
end)
Bedwars:CreateToggle("Kit Ban", function(state)
    toggleFeature("features/kit_ban.lua", state, true)
end)

-- MOVEMENT TAB
local Movement = Window:CreateTab("Movement")
Movement:CreateSlider("WalkSpeed", 16, 100, 16, function(val)
    if game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = val
    end
end)

-- UTILS TAB
local Utils = Window:CreateTab("Utils")
Utils:CreateToggle("Pro Player Analyzer", function(state)
    -- This could be our local module or remote
    print("Analyzer Toggled: " .. tostring(state))
end)

print("💎 Titanium Hub: Synchronization Complete.")



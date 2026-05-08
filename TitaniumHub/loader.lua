-- [[
--    TITANIUM HUB - PREMIER CHEAT SYSTEM
--    Official Loader v1.0
-- ]]

repeat task.wait() until game:IsLoaded()

local function log(txt)
    print("[TITANIUM] " .. tostring(txt))
end

log("Initializing System...")

-- Global Setup
getgenv().Titanium = {
    Config = {},
    Modules = {},
    Connections = {},
    UI = nil,
    Version = "1.0.0"
}

-- Loader UI (Optional but nice)
local function createLoaderUI()
    -- We can add a small progress bar here later
    log("Checking Environment...")
end

createLoaderUI()

-- Module Loading Logic
local function load(path)
    local success, content = pcall(function()
        -- For development: use readfile
        -- For production: use game:HttpGet
        return readfile("TitaniumHub/" .. path)
    end)
    
    if success and content then
        local func, err = loadstring(content)
        if func then
            return func()
        else
            warn("[TITANIUM] Error in " .. path .. ": " .. tostring(err))
        end
    else
        warn("[TITANIUM] Failed to find module: " .. path)
    end
end

-- Start Boot Sequence
task.spawn(function()
    log("Loading Core...")
    load("ui/theme.lua")
    load("ui/library.lua")
    
    log("Loading Main Logic...")
    load("main.lua")
    
    log("Successfully Injected!")
end)

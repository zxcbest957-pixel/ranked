-- [[
--    TITANIUM HUB - PREMIER CHEAT SYSTEM
--    Official Loader v1.2 [DYNAMIC LOADING]
-- ]]

repeat task.wait() until game:IsLoaded()

local function log(txt)
    print("[TITANIUM] " .. tostring(txt))
end

log("Initializing System...")

-- Global Setup
local Titanium = {
    Config = {},
    Modules = {},
    Connections = {},
    UI = nil,
    Version = "1.2.0"
}
getgenv().Titanium = Titanium
_G.Titanium = Titanium

local REPO_TITANIUM = "https://raw.githubusercontent.com/zxcbest957-pixel/ranked/main/TitaniumHub/"
local REPO_TUMBA = "https://raw.githubusercontent.com/daniaggbro-cloud/betatesttumba/main/TumbaHub-main%20(3)/TumbaHub-main/tumbaHub/"

-- [[ ADVANCED MODULE LOADER ]]
function Titanium:LoadModule(path, useLegacy)
    if Titanium.Modules[path] then return Titanium.Modules[path] end
    
    local content = nil
    local success = false
    
    -- 1. Try local file first (for developers)
    local localPath = "TitaniumHub/" .. path
    if isfile and readfile and isfile(localPath) then
        success, content = pcall(function() return readfile(localPath) end)
    end
    
    -- 2. Fetch from GitHub
    if not success or not content then
        local baseURL = useLegacy and REPO_TUMBA or REPO_TITANIUM
        local url = baseURL .. path
        success, content = pcall(function() return game:HttpGet(url) end)
    end
    
    if success and content and #content > 10 then
        local func, err = loadstring(content)
        if func then
            local s, result = pcall(func)
            if s then
                Titanium.Modules[path] = result or true
                return Titanium.Modules[path]
            else
                warn("[TITANIUM] Execution Error in " .. path .. ": " .. tostring(result))
            end
        else
            warn("[TITANIUM] Syntax Error in " .. path .. ": " .. tostring(err))
        end
    else
        warn("[TITANIUM] Failed to fetch module: " .. path)
    end
end

-- Start Boot Sequence
task.spawn(function()
    log("Loading Core Environment...")
    
    Titanium:LoadModule("ui/theme.lua")
    Titanium.UI = Titanium:LoadModule("ui/library.lua")
    
    log("Synchronizing Main Logic...")
    Titanium:LoadModule("main.lua")
    
    log("Titanium Hub v1.2 Ready!")
end)

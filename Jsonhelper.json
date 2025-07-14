-- json_helper.lua
-- Simple JSON persistence helper for Roblox exploits
-- Requires HttpService, and exploit environment with isfile, readfile, writefile

local HttpService = game:GetService("HttpService")

local JsonHelper = {}

-- Checks if file exists (wrapper for exploit functions)
function JsonHelper.FileExists(filePath)
    if isfile then
        return isfile(filePath)
    end
    return false
end

-- Reads JSON data from file, returns table or nil + error
function JsonHelper.ReadJson(filePath)
    if not JsonHelper.FileExists(filePath) then
        return nil, "File does not exist: " .. filePath
    end
    local content
    local success, err = pcall(function()
        content = readfile(filePath)
    end)
    if not success then
        return nil, "Failed to read file: " .. err
    end

    local data
    success, err = pcall(function()
        data = HttpService:JSONDecode(content)
    end)
    if not success then
        return nil, "Failed to decode JSON: " .. err
    end
    return data
end

-- Writes table data as JSON to file, returns true or nil + error
function JsonHelper.WriteJson(filePath, dataTable)
    local content
    local success, err = pcall(function()
        content = HttpService:JSONEncode(dataTable)
    end)
    if not success then
        return nil, "Failed to encode JSON: " .. err
    end

    success, err = pcall(function()
        writefile(filePath, content)
    end)
    if not success then
        return nil, "Failed to write file: " .. err
    end
    return true
end

return JsonHelper

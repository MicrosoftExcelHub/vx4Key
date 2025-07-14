-- json_keydata.lua
local HttpService = game:GetService("HttpService")

local JsonKeyData = {}

-- Load saved key data from file, returns table or nil if no valid data
function JsonKeyData.Load(filePath)
    if not isfile or not readfile then
        warn("[JsonKeyData] File API not available.")
        return nil
    end

    if not isfile(filePath) then
        return nil
    end

    local success, content = pcall(readfile, filePath)
    if not success then
        warn("[JsonKeyData] Failed to read file: " .. tostring(content))
        return nil
    end

    local successDecode, data = pcall(function()
        return HttpService:JSONDecode(content)
    end)
    if not successDecode or type(data) ~= "table" then
        warn("[JsonKeyData] Invalid JSON data or format")
        return nil
    end

    return data
end

-- Save key verification data to file, returns true/false
function JsonKeyData.Save(filePath, dataTable)
    if not writefile then
        warn("[JsonKeyData] File API not available.")
        return false
    end

    local successEncode, encoded = pcall(function()
        return HttpService:JSONEncode(dataTable)
    end)
    if not successEncode then
        warn("[JsonKeyData] Failed to encode JSON: " .. tostring(encoded))
        return false
    end

    local successWrite, err = pcall(writefile, filePath, encoded)
    if not successWrite then
        warn("[JsonKeyData] Failed to write file: " .. tostring(err))
        return false
    end

    return true
end

return JsonKeyData

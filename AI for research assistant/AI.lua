local internet = require("internet")
local serialization = require("serialization")

local AI = {}
AI.__index = AI

function AI.new()
    local self = setmetatable({}, AI)
    self.endpoint = "http://192.168.178.41:11434/api/generate"  -- Replace with your PC's IP
    return self
end

function AI:query(prompt)
    local data = {
        model = "gemma",
        prompt = prompt,
        stream = false
    }
    local json_data = serialization.serialize(data)
    
    local handle, reason = internet.request(self.endpoint, json_data, { ["Content-Type"] = "application/json" })
    if not handle then
        return nil, "HTTP Request Failed: " .. tostring(reason)
    end

    local response = ""
    for chunk in handle do
        response = response .. chunk
    end

    local result = serialization.unserialize(response)
    if result and result.response then
        return result.response
    else
        return nil, "Invalid response format"
    end
end

return AI

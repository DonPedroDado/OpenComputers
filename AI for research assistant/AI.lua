local internet = require("internet")
local serialization = require("serialization")

local Gemini = {}
Gemini.__index = Gemini

function Gemini.new(api_key)
    local self = setmetatable({}, Gemini)
    self.api_key = api_key
    self.endpoint = "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateText"
    return self
end

function Gemini:query(prompt)
    local data = {
        prompt = { text = prompt }
    }
    local json_data = serialization.serialize(data) -- Convert table to JSON string
    local url = self.endpoint .. "?key=" .. self.api_key

    local handle, reason = internet.request(url, json_data, { ["Content-Type"] = "application/json" })

    if not handle then
        return nil, "HTTP Request Failed: " .. tostring(reason)
    end

    local response = ""
    for chunk in handle do
        response = response .. chunk
    end

    local result = serialization.unserialize(response)
    
    if result and result.candidates and result.candidates[1] and result.candidates[1].output then
        return result.candidates[1].output
    else
        return nil, "Invalid response format"
    end
end

return Gemini

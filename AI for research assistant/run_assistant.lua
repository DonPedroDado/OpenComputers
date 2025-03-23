local Gemini = require("AI")
local io = require("io")

local api_key = io.read() -- Replace with your actual API key
local gemini = Gemini.new(api_key)

print("Ask Gemini something: ")
local query = io.read()

local response, err = gemini:query(query)
if response then
    print("Gemini's Answer: " .. response)
else
    print("Error: " .. err)
end

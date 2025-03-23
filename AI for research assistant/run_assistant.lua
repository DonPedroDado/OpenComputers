local AI = require("AI")

local ai = AI.new()

print("Ask Gemma something: ")
local query = io.read()

local response, err = ai:query(query)
if response then
    print("Gemma's Answer: " .. response)
else
    print("Error: " .. err)
end

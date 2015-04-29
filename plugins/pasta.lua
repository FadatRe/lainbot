
local function run(msg, matches)
	 local pastas = {
			"navy.txt",
			"wired.txt",
			"jakuzure.txt"
	 }
	
	 local filename = pastas[math.random(#pastas)]
	 local data = ""
	 
	 for line in io.lines("./static/" .. filename) do
			data = data .. line .. "\n"
	 end
	 
	 return data
end

return {
  description = "copypasta",
  usage = "!pasta: mom's spaghetti",
  patterns = {
    "^!pasta$"
  }, 
  run = run
}

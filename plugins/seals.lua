
local function run(msg, matches)
	 return "alek is a gaffot"
end

return {
  description = "What the fuck did you just fucking say about me...?",
  usage = "!navyseals: does the needful",
  patterns = {
    "^!navyseals$"
  }, 
  run = run 
}

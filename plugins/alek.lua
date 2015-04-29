local function run(msg, matches)
  return "alek is the savior of lainbot, pls dont forget"
end

return {
  description = "Simplest plugin ever!",
  usage = "!alek",
  patterns = {
    "^!alek"
  }, 
  run = run 
}

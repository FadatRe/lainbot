local function run(msg, matches)
  return "alek is the savior of lainbot, pls dont forget <3"
end

return {
  description = "Simplest plugin ever!",
  usage = "!alek",
  patterns = {
    "^!alek"
  }, 
  run = run 
}

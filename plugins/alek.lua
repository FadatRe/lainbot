local function run(msg, matches)
  return "fag"
end

return {
  description = "Simplest plugin ever!",
  usage = "!alek",
  patterns = {
    "^!alek"
  }, 
  run = run 
}

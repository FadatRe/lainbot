local function run(msg, matches)
  return "alek provided the phone number for the bot, but alas his gaffotitis was incurable"
end

return {
  description = "Simplest plugin ever!",
  usage = "!alek",
  patterns = {
    "^!alek"
  }, 
  run = run 
}

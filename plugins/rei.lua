
local function is_rei(msg)
   if msg.from.id == 68256164 then
     return true
   else
     return false
   end
end

local function is_kiro(msg)
   if msg.from.id == 48485338 then
      return true
   else
      return false
   end
end

local function is_jakuzure(msg)
   if msg.from.id == 37609068 then
      return true
   else
      return false
   end
end

local function is_alek(msg)
   if msg.from.id == 42363960 then
      return true
   else
      return false
   end
end

local function decide()
   local num = math.random(50)
   if num == 1 then
      return true
   else
      return false
   end
end

local function run(msg, matches)
   local reiquotes = {"Listen to Rei!", "Rei is correct.", "^", ">not listening to Rei"}
   local alekquotes = {"install gentoo", "i was just pretending", "alek faggoto"}
   local jakuzurequotes = {"our last.fm compatibility went down...", "muh gentoo"}
   local kiroquotes = {"!img som may"}

   if is_rei(msg) then
      quotes = reiquotes
   elseif is_alek(msg) then
      quotes = alekquotes
   elseif is_jakuzure(msg) then
      quotes = jakuzurequotes
   elseif is_kiro(msg) then
      quotes = kiroquotes
   else
      quotes = {}
   end

   if decide() then
      return quotes[math.random(#quotes)]
   end
end

return {
  description = "always listen to rei",
  usage = "rei speaks, and you must listen",
  patterns = {
    "^(.*)$"
  }, 
  run = run 
}

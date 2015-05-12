local function lines(str)
   local t = {}
   local function helper(line) table.insert(t, line) return "" end
   helper((str:gsub("(.-)\r?\n", helper)))
  return t
end

local function run(msg, matches)
  local oneline = string.gsub(matches[1], "\n", " ")
  
  local fp = io.popen("lolisp -- -q > /tmp/lolisp-data", "w")
  fp:write(oneline)
  fp:close()
  local fp = io.open("/tmp/lolisp-data")
  local data = fp:read("*a")
  fp:close()
  
  return data
end

return {
  description = "Lisp: evaluate lolisp code",
  usage = "<code>",
  patterns = {
     "^[`']?([(].*[)])$"
  }, 
  run = run 
}

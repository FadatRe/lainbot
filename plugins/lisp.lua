
local function run(msg, matches)
  local fp = io.popen("lolisp -q > /tmp/lolisp-data", "w")
  fp:write(matches[1])
  fp:close()
  local fp = io.open("/tmp/lolisp-data")
  local data = fp:read("*a")
  fp:close()
  return data
end

return {
  description = "Lisp: evaluate lolisp code",
  usage = "!lisp <code>",
  patterns = {
    "^!lisp (.*)$"
  }, 
  run = run 
}

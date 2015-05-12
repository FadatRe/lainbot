do

function run(msg, matches)
  return 'Lainbot '.. VERSION .. [[ 
  Checkout http://git.io/vJ2dU
  GNU GPL v2 license.]]
end

return {
  description = "Shows bot version", 
  usage = "!version: Shows bot version",
  patterns = {
    "^!version$"
  }, 
  run = run 
}

end

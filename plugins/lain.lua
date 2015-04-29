do
	 function get_random_image(dir)
			files = scandir(dir)
			file = files[math.random(#files)]
			return file
	 end
	 
	 function run(msg, matches)
			local laintypes = {
				 -- add more below!
				 ["unsorted"] = "/etc/lain/images/unsorted"
			}

			local receiver = get_receiver(msg)
			local imgtype = matches[1]

			if laintypes[imgtype] then
				 local img = laintypes[imgtype]..get_random_image(laintypes[imgtype])
				 print("Sending... "..img)
				 send_photo(receiver, img, function() end, function() end)
			else
				 return "No such type '"..imgtype.."'"
			end
	 end
	 
	 return {
			description = "Retrieves a cute Lain image from a collection.",
			usage = "!lain [type]: Retrieves a Lain image of type _type_.",
			patterns = {
				 "^!lain (.*)$",
				 "^!img (.*)$"
			},
			run = run
	 }
end

do
	 -- chekk, the sbjh iamge?
	 function check_swbahj(url)
			local res,code  = http.request(url)
			if code ~= 200 then
				 return false
			else
				 return true
			end
	 end
	 
	 function run(msg, matches)
			local receiver = get_receiver(msg)
			local id = matches[1]
			local url = "http://www.mspaintadventures.com/sweetbroandhellajeff/archive/"..id..".jpg"
			print("connecting to "..url)
			if not check_swbahj(url) then
				 print("checking sbahj failed")
				 send_msg(receiver, "404, then comic was not fond, try agian? shitlard", function() end, false)
			else
				 print("checking sbahj succeeded, sending")
				 file_path = download_to_file(url)
				 send_photo(receiver, file_path, function() end, function() end)
			end
			
			return false
	 end

	 return {
			description = "ahahahaha what is this looeh??",
			usage = {"!sbahj......., [comoc]: posts a comic, frm the sbhj?"},
			patterns = {
				 "^!sbahj (%d+)",
			},
			run = run
	 }

end

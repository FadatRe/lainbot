-- Contributed by Francesco <https://github.com/Francesco149>
do
	local KILOBYTE = 1000
	local MEGABYTE = KILOBYTE * 1000

	function handle_http_response(code, status)
		if code ~= 200 then
			if status then
				print(status)
			else
				print("http.request failed! (invalid url?)")
			end
			return false
		end
		return true
	end

	function get_jpg_header_size(data)
		local res = 417
		for i, byte in ipairs(data) do
			if byte == 255 and data[i + 1] == 218 then
				res = i + 2
				break
			end
		end
		return res
	end

	function simple_file_size(bytes)
		local simplesize = bytes
		local unit = "B"
		if bytes >= MEGABYTE then 
			simplesize = simplesize / MEGABYTE
			unit = "MB"
		elseif bytes >= KILOBYTE then
			simplesize = simplesize / KILOBYTE
			unit = "KB"
		end
		return simplesize, unit
	end

	local GLITCH_MAX_FILE = MEGABYTE
	
	function run(msg, matches)
		http = require("socket.http")
		local stamp = os.time()

		-- try checking file size from a HEAD request
		http.TIMEOUT = 5
		local _, code, headers, status = http.request {
			url = matches[1], 
			method = "HEAD"
		}
		if not handle_http_response(code, status) then
			return "HTTP request failed or file not found"
		end
		
		if not string.find(headers["content-type"], "jpeg") then
			-- TODO: convert to jpg?
			return "Not a JPEG file!"
		end
		
		local filesize = tonumber(headers["content-length"])
		local response = nil
		
		-- if the HEAD request doesn't contain content-length, 
		-- send a full GET request. the timeout will abort the request 
		-- after 5 seconds if the file is too large or takes too long
		-- to download
		if not filesize then
			print("No content-length, performing a full request...")
			response = http.request(matches[1])
			filesize = #response
		end

		-- show user-friendly filesize
		simplesize, unit = simple_file_size(filesize)
		print("File Size: " .. simplesize .. unit .. " (" .. filesize .. " bytes)")
		
		-- check filesize limit
		if filesize > GLITCH_MAX_FILE then
			return "Sorry, maximum filesize is " .. GLITCH_MAX_FILE / MEGABYTE .. "MB!"
		end
		
		-- if we previously got the file size through a HEAD request, 
		-- retrieve the actual data with a full request
		if not response then
			response, code, _, status = http.request(matches[1])
			if not handle_http_response(code, status) then
				return "HTTP request failed or file not found"
			end
		end
		
		-- convert to byte array for manipulation
		local arr = {}
		response:gsub(".", function(c) table.insert(arr, string.byte(c)) end)
		response = nil
		
		-- skip jpeg header
		local header_size = get_jpg_header_size(arr)
		print("JPEG header size: " .. header_size .. " bytes")
		
		-- randomize bytes randomly
		for i=header_size + 1, #arr - 4 do
			if math.random() <= 0.0001 then
				print("Corrupting byte " .. i)
				arr[i] = math.floor(math.random() * 255)
			end
		end
		
		-- convert back to a string so we can write it to file
		local glitched = ""
		for i=1, #arr do
			glitched = glitched .. string.char(arr[i])
		end
		arr = nil
		
		-- write glitched jpg
		local out = assert(io.open("/tmp/"..stamp..".jpg", "wb"))
		out:write(glitched)
		assert(out:close())
		
		-- send glitched jpg
		local receiver = get_receiver(msg)
		send_photo(receiver, "/tmp/"..stamp..".jpg", function() end, function() end)
	end
	
	return {
		description = "Randomly glitches a JPEG image", 
		usage = "!glitch [url]: glitches the JPEG image retrieved from _url_", 
		patterns = {
			"^!glitch (.*)$"
		}, 
		run = run
	}
end

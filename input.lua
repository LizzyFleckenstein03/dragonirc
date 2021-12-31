cutie.input:addEventListener("input", function(evt)
	dragonirc.input(evt.data.input)
end)

function dragonirc.input(input, raw)
	if not raw and not dragonirc:dispatchEvent(Event("input", {input = input})) then
		return
	end

	if input:sub(1, 1) == "/" then
		dragonirc.command(input:sub(2, #input):split(" "), false)
	else
		dragonirc.message(input, false)
	end
end

function dragonirc.command(args, raw)
	local cmd = table.remove(args, 1):lower()

	if not raw and not dragonirc:dispatchEvent(Event("command", {cmd = cmd, args = args})) then
		return
	end

	if dragonirc:dispatchEvent(Event("command." .. cmd, args)) then
		dragonirc.add_line(cutie.bold
			.. cutie.color(dragonirc.config.colors.error)
			.. "Invalid command: /" .. cmd)
	end
end

function dragonirc.message(msg, raw)
	if not raw and not dragonirc:dispatchEvent(Event("message", {msg = msg})) then
		return
	end

	dragonirc.add_line(cutie.bold .. "<user> " .. cutie.no_effects .. msg)
end

function dragonirc.register_command(cmd, func)
	dragonirc:addEventListener("command." .. cmd, function(evt)
		evt:preventDefault()
		func(table.unpack(evt.data))
	end)
end

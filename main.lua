local display = {}

function dragonirc.add_line(line)
	table.insert(display, cutie.no_effects .. line)
end

function dragonirc.main()
	cutie.set_alternate_buffer(true)
	cutie.set_canon_input(false)
	cutie.set_input_buffer(true)

	await(dragonirc.splashscreen())

	setInterval(function()
		cutie.clear_effects()
		cutie.handle_resize()
		cutie.empty_screen()

		local size = cutie.get_terminal_size()

		cutie.render_at(display, 2, 1)
		cutie.clear_effects()

		cutie.render_at(cutie.box({size[1] - 6, 1}), 2, size[2] - 4)

		cutie.move_cursor(5, size[2] - 2)
		cutie.render(cutie.input.buffer)

		cutie.flush_buffer()
	end, 1000 / 60)
end

function dragonirc.exit(ret)
	cutie.clear_effects()
	cutie.set_alternate_buffer(false)
	cutie.set_cursor_shown(true)
	cutie.set_canon_input(true)
	cutie.flush_buffer()
	os.exit(ret)
end

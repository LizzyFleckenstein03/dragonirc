local dragon = string.split([[
          /                            )
          (                             |\
         /|                              \\
        //                                \\
       ///                                 \|
      /( \                                  )\
      \\  \_                               //)
       \\  :\__                           ///
        \\     )                         // \
         \\:  /                         // |/
          \\ / \                       //  \
           /)   \   ___..-'           (|  \_|
          //     /   _.'              \ \  \
         /|       \ \________          \ | /
        (| _ _  __/          '-.       ) /.'
         \\ .  '-.__            \_    / / \
          \\_'.     > --._ '.     \  / / /
           \ \      \     \  \     .' /.'
            \ \  '._ /     \ )    / .' |
             \ \_     \_   |    .'_/ __/
              \  \      \_ |   / /  _/ \_
               \  \       / _.' /  /     \
               \   |     /.'   / .'       '-,_
                \   \  .'   _.'_/             \
   /\    /\      ) ___(    /_.'           \    |
  | _\__// \    (.'      _/               |    |
  \/_  __  /--'`    ,                   __/    /
  (_ ) /b)  \  '.   :            \___.-'_/ \__/
  /:/:  ,     ) :        (      /_.'__/-'|_ _ /
 /:/: __/\ >  __,_.----.__\    /        (/(/(/
(_(,_/V .'/--'    _/  __/ |   /
 VvvV  //`    _.-' _.'     \   \
   n_n//     (((/->/        |   /
   '--'         ~='          \  |
                              | |_,,,
                              \  \  /
                               '.__)
]], "\n")

local title = string.split([[
 ____                              ___ ____   ____
|  _ \ _ __ __ _  __ _  ___  _ __ |_ _|  _ \ / ___|
| | | | '__/ _` |/ _` |/ _ \| '_ \ | || |_) | |
| |_| | | | (_| | (_| | (_) | | | || ||  _ <| |___
|____/|_|  \__,_|\__, |\___/|_| |_|___|_| \_\\____|
                 |___/
]], "\n")

local size_dragon = cutie.get_dimensions(dragon)
local size_title  = cutie.get_dimensions(title)

dragonirc.splashscreen = async(function()
	cutie.set_cursor_shown(false)
	local promise = Promise()
	local splashscreen_time = 0

	local interval

	interval = setInterval(function()
		splashscreen_time = splashscreen_time + 1 / 60

		if splashscreen_time > 1 then
			promise:resolve()
			clearInterval(interval)
			return
		end

		cutie.handle_resize()
		cutie.set_background({0, 0, 0})
		cutie.empty_screen()

		cutie.set_bold()

		local size = cutie.get_terminal_size()

		cutie.set_color(360 * math.max(1 - splashscreen_time * 2 / 3, 0))
		cutie.render_at(dragon,
			(size[1] - size_dragon[1]) / 2,
			(size[2] - size_dragon[2]) / 2
		)

		cutie.set_color({1, 1, 1})
		cutie.render_at(title,
			(size[1] - size_title[1]) / 2,
			size[2] - size_title[2] - 1
		)

		cutie.flush_buffer()
	end, 1000 / 60)

	await(promise)

	cutie.set_cursor_shown(true)
end)

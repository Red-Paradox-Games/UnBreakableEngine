module interfaces

import sdl

pub interface Window {
	run(fn (sdl.Event))
}

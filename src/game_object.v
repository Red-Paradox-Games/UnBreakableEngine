module unbreakable

import sdl

pub struct GameObject {
	position sdl.FPoint
	objects  []GameObject
	hidden   bool
	parent   ?&GameObject
}

module api

import interfaces
import sdl

struct Window implements interfaces.Window {

}

fn (self Window) run(closure fn (sdl.Event) ) {
	println("Hello World!")
	self.test()
}	
fn (self Window) test() {
	println("Private!")
}	


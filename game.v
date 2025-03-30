module unbreakable

import sdl
import sdl.image

// Size represents a width and height dimension
//
// - `width` width in pixels
// - `height` height in pixels
pub struct Size {
pub:
    width int
    height int
}

// GameArgs contains parameters for creating a new game instance
//
// - `title` window title (required)
// - `window_size` initial size of the game window
@[params]
pub struct GameArgs {
    SDLInitArgs
pub:
    title string @[required]
    window_size Size = Size{1600, 1000}
}

// SDLInitArgs contains initialization parameters for SDL
//
// - `sdl_flags` SDL initialization flags
// - `image_flags` SDL image initialization flags
// - `renderer_flags` SDL renderer flags
// - `window_flags` SDL window flags
// - `exit_key` key that will trigger game exit when pressed
pub struct SDLInitArgs {
pub:
    sdl_flags u32 = sdl.init_video|sdl.init_audio
    image_flags int = int(image.InitFlags.png)|int(image.InitFlags.jpg)
    renderer_flags u32 = u32(sdl.RendererFlags.accelerated) | u32(sdl.RendererFlags.presentvsync)
    window_flags u32 = u32(sdl.WindowFlags.resizable)
    exit_key ?sdl.KeyCode = sdl.KeyCode.escape
}

// Game is the main game engine structure
//
// - `window` SDL window handle
// - `renderer` SDL renderer handle
// - `exit_key` optional key that triggers game exit
// - `window_size` current size of the game window
// - `run` flag that controls the main game loop
// - `cleanup` flag to ensure resources are properly released
@[heap;noinit]
pub struct Game {
    exit_key ?sdl.KeyCode @[required]
pub:
    window &sdl.Window @[required]
    renderer &sdl.Renderer @[required]
mut:
    window_size Size
    run bool = true
    cleanup bool = true
}

// Game.new creates a new Game instance that manages all of the main loops and device logic
//
// - `args` initialization parameters for the game
pub fn Game.new(args GameArgs) &Game {
    sdl.init(args.sdl_flags)
    image.init(args.image_flags)

    window := sdl.create_window(args.title.str, 0, 0, args.window_size.width, args.window_size.height, args.window_flags)

    return &Game{ 
        window: window, 
        renderer: sdl.create_renderer(window, -1, args.renderer_flags),
        window_size: args.window_size,
        exit_key: args.exit_key
    }
}

// window_size returns the current window dimensions
pub fn (mut self Game) window_size() Size {
    self.query_window_size()
    return self.window_size
}

// LoopArgs contains callback functions for the game loop
//
// - `sdl_event` optional function to handle SDL events
@[params]
pub struct LoopArgs {
pub:
    sdl_event ?fn (&sdl.Event)
    // physics ?fn (DeltaTime)
}

// run starts the main game loop
//
// - `loops` configuration containing callback functions for the game loop
pub fn (mut self Game) run(loops LoopArgs) {
    for self.run {
        event := sdl.Event{}
        for sdl.poll_event(&event) > 0 {
            match event.@type {
                .quit { self.exit() }
                .keyup, .keydown {
                    if key := self.exit_key {
                        if event.key.keysym.sym == int(key) {
                            self.exit()
                        }
                    }
                }
                else {
                    if sdl_event := loops.sdl_event {
                        sdl_event(&event)
                    }
                }
            }
        }
        // sdl.set_render_draw_color(renderer, 255, 55, 55, 255)
        // sdl.render_clear(renderer)
        // sdl.render_present(renderer)
    }
    self.cleanup()
}	

// exit signals the game engine to stop running
pub fn (mut self Game) exit() {
    self.run = false
}

// query_window_size updates the stored window size from the actual SDL window
fn (mut self Game) query_window_size() {
    sdl.get_window_size(self.window, self.window_size.width, self.window_size.height)
}

// cleanup releases all SDL resources
pub fn (mut self Game) cleanup() {
    if self.cleanup {
        self.cleanup = false
        sdl.destroy_renderer(self.renderer)
        sdl.destroy_window(self.window)
        sdl.quit()
    }
}

module main

import unbreakable as ub
import sdl
import sdl.image

// Test Size struct
fn test_size() {
    size := ub.Size{800, 600}
    assert size.width == 800
    assert size.height == 600
}

// Test GameArgs struct with default window_size
fn test_game_args_default() {
    args := ub.GameArgs{
        title: "Test Game"
    }
    assert args.title == "Test Game"
    assert args.window_size.width > 0
    assert args.window_size.height > 0 
}

// Test GameArgs struct with custom window_size
fn test_game_args_custom() {
    args := ub.GameArgs{
        title: "Test Game",
        window_size: ub.Size{800, 600}
    }
    assert args.title == "Test Game"
    assert args.window_size.width == 800
    assert args.window_size.height == 600
}

// Test SDLInitArgs struct with defaults
fn test_sdl_init_args_default() {
    args := ub.SDLInitArgs{}
    assert args.sdl_flags == sdl.init_video | sdl.init_audio
    assert args.image_flags == int(image.InitFlags.png) | int(image.InitFlags.jpg)
    assert args.renderer_flags == u32(sdl.RendererFlags.accelerated) | u32(sdl.RendererFlags.presentvsync)
    assert args.window_flags == u32(sdl.WindowFlags.resizable)
    if key := args.exit_key {
    } else {
        assert false, "exit_key should be set to default"
    }
}

// Test SDLInitArgs struct with custom values
fn test_sdl_init_args_custom() {
    args := ub.SDLInitArgs{
        sdl_flags: sdl.init_everything,
        image_flags: int(image.InitFlags.png),
        renderer_flags: u32(sdl.RendererFlags.software),
        window_flags: u32(sdl.WindowFlags.fullscreen),
        exit_key: sdl.KeyCode.q
    }
    if key := args.exit_key {
        assert key == sdl.KeyCode.q
    } else {
        assert false, "exit_key should be set"
    }
}

// Test Game.new with default args
fn test_game_new_default() {
    mut game := ub.Game.new(title: "Test Game")
    // Verify initialization indirectly via public method
    size := game.window_size()
    assert size.width > 0   // Window should have a positive width
    assert size.height > 0  // Window should have a positive height
    game.cleanup()
}

// Test Game.new with custom window_size
fn test_game_new_custom_size() {
    mut game := ub.Game.new(title: "Test Game", window_size: ub.Size{800, 600})
    size := game.window_size()
    assert size.width == 800
    assert size.height == 600
    game.cleanup()
}

// Test window_size()
fn test_window_size() {
    mut game := ub.Game.new(title: "Test Game", window_size: ub.Size{800, 600})
    sdl.set_window_size(game.window, 1000, 1000)
    size := game.window_size()
    assert size.width == 1000
    assert size.height == 1000
    game.cleanup()
}

// Test run() and exit()
fn test_run_and_exit() {
    mut game := ub.Game.new(title: "Test Game")
    // Test passes if the thread exits cleanly
    // Spawn a thread to call exit() after a delay
    t := spawn fn [mut game] () {
        sdl.delay(200)  // Wait 1 second
        game.exit()
    }()
    
    // Run the game loop in the main thread
    game.run()
    // Test continues after run() exits
    // Wait for thread to finish
    t.wait()
}

// Test cleanup() idempotency
fn test_cleanup() {
    mut game := ub.Game.new(title: "Test Game")
    game.cleanup()
    game.cleanup()  // Call again to test idempotency
}
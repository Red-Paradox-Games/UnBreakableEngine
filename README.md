# UnbreakableEngine

## Overview
UnbreakableEngine is a simple and incremental 2D Game Engine as a module, that never introduces changes or removals to the public api, because they break your code. This ensures that you can always upgrade the engine to add more features without having to also update your game code.

## Vision
UnbreakableEngine is designed to feature convention over configuration as a default so that you get right into writing your game code without having to worry too much about how the game will be rendered or processed. The engine internals favor efficiency over simplicity and the pub API favors simplicity over modularity. That way you get the highest FPS with minimal CPU and GPU usage, while only having to use minimal API calls, You are still able to make niche tweaks if your are an advanced programmer simply by adding custom arguments within pub API calls which are normally defaulted to something useful and hidden.


## Installation
To get started with Unbreakable, follow these steps:

1. **Install V Lang**: Download and install V Lang from [here](https://github.com/vlang/v/releases/latest/download/v_windows.zip).
2. **Create a New V Project**: Set up a new V project using the V Lang command line.
3. **Clone the Repository**: Clone the UnbreakableEngine repository into your `~/.vmodules` folder:
   ```bash
   git clone https://github.com/Red-Paradox-Games/UnbreakableEngine ~/.vmodules/unbreakable
   ```
4. **Install sdl Module**: run `v install sdl` to install the SDL2 module.
5. **Import the Module**: Add the following line at the top of your `main.v` file to use the Unbreakable module:
   ```v
   import unbreakable
   ```

## Usage
Refer to the installation instructions above for how to use the Unbreakable module in your V projects.

## Contributing
To contribute to the Unbreakable project:
1. Fork the project.
2. Create a new issue to start working on a bug or feature.
3. Make a pull request with your fork against the `dev` branch.

## License
This project is licensed under the MIT License.

## Contact
For any questions or support, please make a comment on an existing GitHub Issue or Pull request, or make new ones if neccessary.

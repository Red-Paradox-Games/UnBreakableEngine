# UnBreakableEngine

## Overview
UnBreakableEngine is a simple and incremental 2D Game Engine as a module, that never introduces changes or removals, because they break your code. This ensures that users can always upgrade their engine to add morem features without causing any disruptions to their existing projects.

## Vision
UnBreakableEngine trusts game creators to know how to write their own code, and use SDL. It expects them to use SDL in conjuction with Unbreakable as a set of useful and simple tools, and is not intended to be streamlined magic.

## Public Code Layout
All of the structs that are intended to be used in a Game project are defined as incremental interfaces (Nothing is ever removed or modified, only added) in the interfaces submodule

All of the public static functions intended to be used in a Game project for all structs are defined in the header file for any given submodule for instance:
  - `api.display` contains `Window` so `Window.new()` and any other `Window` static function would be defined in the file `api/dispaly.v`

This makes it quick and simple to find everything that you are intended to be able to use for a game. This also makes it possible to keep your game code unbreakable on updates.


## Installation
To get started with Unbreakable, follow these steps:

1. **Install V Lang**: Download and install V Lang from [here](https://github.com/vlang/v/releases/latest/download/v_windows.zip).
2. **Create a New V Project**: Set up a new V project using the V Lang command line.
3. **Clone the Repository**: Clone the UnBreakableEngine repository into your `~/.vmodules` folder:
   ```bash
   git clone https://github.com/Red-Paradox-Games/UnBreakableEngine ~/.vmodules/ube
   ```
4. **Install sdl Module**: run `v install sdl` to install the SDL2 module.
5. **Import the Module**: Add the following line at the top of your `main.v` file to use the Unbreakable module:
   ```v
   import ube.api
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

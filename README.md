# 2D Platformer

This is a 2d platformer protoype project, in which we will attempt to
treat it as if it were a real project. Meaning, we will 

## Setup

This project is written in Lua using the [Love2D Framework](https://love2d.org),
therefore will need a copy of Love2D installed to run the game.

Depending on your OS you can access love from the command line:

#### MacOS

```bash
$ /Applications/love.app/Contents/MacOS/love --version
# LOVE 11.3 (Mysterious Mysteries)
```

#### Windows

```bash
$ "C:\Program Files (x86)\LOVE\love" --version
# LOVE 11.3 (Mysterious Mysteries)
```

### Running the Game

- Navigate to the root of the project (containing `main.lua`).
- Use the following command to execute the program.

#### MacOS

```bash
$ cd ~/Path/to/Code
$ /Applications/love.app/Contents/MacOS/love ./
```

```bash
$ cd \Path\to\Code
$ "C:\Program Files (x86)\LOVE\love" .\
```


## Usage with Tiled

- Open the `main.lua` file.
- Update `map` to the location of your map.
- Update `row` & `col` to the desired spawn point of the player.

```lua
    Gamestate.switch(Gamestates['scene'], {
        map = 'res/maps/AA.lua',  -- <- update map location here
        row = 46,                 -- <- this is where your player will spawn
        col = 20
    })
```

### License

[MIT license](LICENSE).

The code is of course, freely available to download and do what you wish
with it (**except the assets** we do ask you purchase any assets you use; see [Credits](#Credits) below).

## Credits

Credits are rightfully due to the following artists for their gorgeous
contributions to the gaming and art world. All assets can be found and
purchased from [itch.io](https://itch.io):

- [Sanctum Pixel](https://sanctumpixel.itch.io/)
- ...
# Deterministic Breakout-clone
The deterministic breakout-clone is very unremarkable except from the part that it features a replay feature. The original motivation in the project was to create a example game that could play itself and take screenshots at specified times. The dream was to have newer and better graphics and have new (but the same old scenes) screenshots taken on-demand without touching the game itself.
The replays can be played faster than realtime and that enables instant feedback.

# Implementation details
The game depends on [LÖVE](https://love2d.org/).

The game has been implemented using [Entity-Component-System](https://en.wikipedia.org/wiki/Entity%E2%80%93component%E2%80%93system) and [Observer-patterns](https://en.wikipedia.org/wiki/Observer_pattern).

The game loop operates on fixed time steps and all input events are stored as the game runs.
This enables that the game can be recorded and later replayed exactly how it originally ran.
More accurate description on the game loop can be read from the article [Fix your Timestep!](http://gafferongames.com/game-physics/fix-your-timestep/).

More thorough documentation is available in Finnish. [Finnish documentation](https://www.dropbox.com/s/61xs206wls33o3s/Exercise_project_Breakout_Olli_Mannevaara.pdf?dl=0).

The following libraries and modules were used in the game:
- [Knife](https://github.com/airstruck/knife)
- [HUMP](https://github.com/vrld/hump)
- [tick](https://github.com/bjornbytes/tick)
- [bump](https://github.com/kikito/bump.lua)
- [bitser](https://github.com/gvx/bitser)

The libraries have various permissive licenses.

# How to play
Pass the folder to [LÖVE](https://love2d.org/) to start playing.

On windows:
```
love.exe <location of the repository folder>
```

If the game is ran without any additional command-line arguments the game simply records to a platform specific location on a disk.
The game outputs the save directory as you start it.

If the game is started by passing "replay" as an argument it will replay previously played game.

Second number argument can be passed to increase the replay speed from 1 to greater number.
All arguments pass the second are considered as a frame numbers to take screenshots. These are saved to disk in the same directory as the input data.

```
love.exe <location of the repository folder> replay 2 144 288
```

Game replays the last game at double speed and takes screenshots at first and second seconds.
The game is set to run at 144 updates a second. When played on a 60 Hz monitor the image clarity suffers a bit due to uneven frame pacing.

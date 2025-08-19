# ttKirby's Counter-Strike 1.6 Server in a Dockerfile

## Introduction

Hey ho,  
You can call me Kirby, and I enjoy working with Dockerfiles because they can simplify a lot of tasks.  
However, they can also be quite a challenge if you don’t have much experience creating them.

I want to learn more about Docker and how to build with it, and that’s one of the main reasons behind this project.

So here it is: my Counter-Strike 1.6 server in Docker, inspired by [archont94](https://github.com/archont94/counter-strike1.6).

## Instructions

You can pull the image anytime from [my Docker Hub](https://hub.docker.com/repository/docker/ttkirby/cs16-server)

There are several environment variables you can set when starting the container to get going without having to fiddle around too much with configuration files.

Technically, all environment variables can be left empty.  
For deeper information on certain details like the Legacy and Anniversary editions, please consult your favorite search engine – thanks for understanding!

- `LEGACY`
  - Allows you to choose between two HLDS versions.
  - If left empty, the 25th Anniversary Edition (Build 10210) will be installed.
  - If set to `"true"`, a version prior to the 25th Anniversary Edition (Build 8684) will be installed.

- `REHLDS`
  - To install [ReHLDS](https://github.com/rehlds/ReHLDS), the Legacy version is required → [Issue](https://github.com/rehlds/ReHLDS/issues/999)

- `METAMOD`
  - If set to `"true"`, MetaMod will be installed, which is required for certain mods.

- `AMXMODX`
  - If set to `"true"`, AMX Mod X will be installed.
  - It depends on MetaMod.

- `FAST_DL`
  - If set to `"true"`, an nGinx service will be provided for fast downloads of certain resources.
  - This is especially useful for dedicated servers with lots of mods, custom sounds, maps, sprites, models, etc., as resources would otherwise download very slowly.

- `HOSTNAME`
  - Sets the server name.
  - If left empty, a fallback name will be used.

- `PASSWORD`
  - If you want to protect your server with a password, you can set it here.

- `RCON`
  - Anyone who wants to properly administer their server must set an RCON password.

- `STEAM_ID`
  - Required by AMX Mod X to perform certain administrative actions.

- `BOT`
  - You can currently install two bot types:
    - Yet Another PODBot (`YaPB`)
    - PODBot MM (`PODBot`)
  - Please pay attention to case sensitivity.

- `KEY` & `PW`
  - These two values are needed to configure bots in-game.
  - Example: `KEY=examplekey` and `PW=examplepassword`
  - Enter in console: `"setinfo examplekey examplepassword"`

- `SV_LAN`
  - `0` or `1`

- `MAP`
  - Enter the starting map.

- `PLAYERS`
  - Maximum number of players on the server (32 is the limit)

- `SERVER_TICK`
  - Server tickrate

## Dependencies Overview

Here’s a visual representation of all dependencies.  
This means AMX Mod X can only be installed with MetaMod, and Steam ID only works with AMX Mod X.  
Why? See above.

```
Legacy
└── ReHLDS

MetaMod
├── AMXMODX
│   └── STEAM_ID
├── PODBot
│   ├── KEY
│   └── PW
└── YaPB
    ├── KEY
    └── PW
```

## Ports and Volumes

**Port 80**  
- Required if Fast Download is set to `"true"`, since the nGinx service listens on port 80 by default.

**Port 27015/udp**  
- Default port for CS 1.6 servers.

**Volumes**  
- The path under Volumes stores the entire HLDS folder on the host system, including all files relevant to the server.
- So if you want to apply custom settings, you can do so at any time.

## Bugs

- If you find bugs, don’t keep them to yourself – share them!
- I care about good service and a clean-running script/program/whatever, so it’s important to me that this Dockerfile is as bug-free as possible.

## License

MIT – free to use, modify, and share.

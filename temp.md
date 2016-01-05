# About
***
This guide will instruct you on how to play games from the Steam (for Windows) client, using SteamOS. This process entails several components:
* Debian sources
* PlayOnLinux or Crossover Linux
* A virtual desktop
* Passing arguments to the virtual desktop to start the game under Steam (for Windows).

**Note:**  
Please see [AUTHORS.md](https://github.com/ProfessorKaos64/SteamOS-Tools/blob/brewmaster/AUTHORS.md) for a list of contributions regarding this code. This could _not_ have been done without them.

# Key files and Links
***
* [Skeleton / template script file](https://github.com/ProfessorKaos64/SteamOS-Tools/blob/brewmaster/cfgs/wine/wine-launcher.skel)
* [Desktop file template](https://github.com/ProfessorKaos64/SteamOS-Tools/blob/brewmaster/cfgs/wine/Default.desktop)
* [Desktop shortcut](https://github.com/ProfessorKaos64/SteamOS-Tools/blob/brewmaster/cfgs/wine/Steam-POL.sh)
* [Crossover Linux compatibility list](https://www.codeweavers.com/compatibility)
* [PlayOnLinux compatibility list](https://www.playonlinux.com/en/supported_apps-1-0.html)
* [Wine compatibility list](https://appdb.winehq.org/)

# Set user passwords
***
Set the desktop user password:
```
passwd desktop
```

Set the steam user password:
```
sudo passwd steam
```

# Install the required software
***
This assumes you have added [Debian sources](https://github.com/ProfessorKaos64/SteamOS-Tools/wiki/Adding-Debian-Sources-and-Repositories). You can omit playonlinux if you are a CrossOver Linux user.

```
sudo apt-get install playonlinux x11-utils gksu
```

# Using CrossOverLinux

Coming soon!

# Using PlayOnLinux

## Shortcuts
Now we will install a quick shortcut to making managing POL under the steam user easier

**For PlayOnLinux users:**

```
sudo cp SteamOS-Tools/cfgs/wine/Steam-POL.sh /usr/bin/Steam-POL
sudo cp SteamOS-Tools/cfgs/wine/Steam-POL.desktop $HOME/Desktop
```

## Install Steam under the "steam" user
***
![Steam-POL](http://libregeek.org/steamos-tools/wiki/images/Steam-POL.png)

Start up Steam-POL on your desktop. You will notice that buttons are kind of "not right," with the scaling off. This is how SteamOS desktop mode is setup for television use. In POL, the first button on the left is usually "OK," with the second being "Cancel."  If you wish to fix this (even temporarily), please see the [Fixing SteamOS Desktop Font Scaling](https://github.com/ProfessorKaos64/SteamOS-Tools/wiki/Fixing-SteamOS-Desktop-Font-Scaling) wiki page. On that page, you will see examples of each window. If you chose to do this, you will likely need to reboot to have the scaling take full effect.

## Installing Steam for Windows

![POL-main](http://libregeek.org/steamos-tools/wiki/images/POL-main-scaling-fixed.png)

1. Click the + icon to Install
2. Search for "steam"
3. Double click the Steam entry to install
4. Click Next (or the first button if your scaling is off) for each screen given
5. During installing, this will install "1.7.53-steam-crossover_hack". We will change this later.
6. At the end of the installation, choose _not_ to run Steam

## Correcting the Wine version for the Steam application (optional)

Many games run much better under Wine 1.8 (as of 20160102). The  below instructions show you how to change the running version of Wine for Steam, under POL. Wine 1.9 is available as well to use. Your mileage may vary.

![new Wine add](http://libregeek.org/steamos-tools/wiki/images/new-wine-1.8.png)

1. Highlight Steam from POL
2. Click the gear icon to congfigure
3. Under the "Wine version" section on the General tab, click the + icon
4. Chose the Wine 1.8 release on the left side pane, clicking the > arrow to install it.
5. When installation is complete, close the window
6. Back in the general tab, use the pull down tab for "Wine version" and choose 1.8
7. You will get a warning, choose Yes

When you next start Steam under POL, it will upgrade the Wine bottle for use with this new version.

## Installing your games

***
Install any games you wish to use under Steam for PlayOnLinux. I highly recommend at least launching the game once while still in Steam under POL. Make _sure_ you also close Steam properly with Steam > Exit.

# Adding your Steam-Wine games to SteamOS / BPM
***

## Configuring the launcher

Replace "my_game" with the name of your game. I advise you not to use spaces. If you do, make sure to escape them with "\" when editing (2nd line  below).

```
sudo cp SteamOS-Tools/cfgs/wine/pol-game-launcher.skel /usr/bin/my_game
sudo nano /usr/bin/my_game
```

```
# Define some Wine variables for use in the script.
export WINEPREFIX="/home/steam/.PlayOnLinux/wineprefix/Steam"
export WINEDEBUG="-all"
WINEVERSION="$HOME/.PlayOnLinux/wine/linux-x86/VERSION_TMP"

# Define Steam location and game location here.
# NOTE: GAME_DIR is not used with current method. Possibly remove?
STEAM_DIR="$WINEPREFIX/drive_c/Program Files/Steam"
GAME_APPID="GAME_ID"
GAME_DIR="GAME_DIR"
GAME_EXE="GAME_EXE"
```

### WINEPREFIX
There is no need to modify this line if you are using PlayOnLinux. 

### WINEVERSION
All available versions are nested under `/home/steam/.PlayOnLinux/wine`. 

```
desktop@steamos:~$ ls /home/steam/.PlayOnLinux/wine/linux-x86/
1.7.53-steam_crossoverhack  1.8
```

### GAME_APPID
Vist [steamdb.info](https://steamdb.info) and search for your game. Take note of the AppID found.

### GAME_DIR
This is not used right now, but typically falls under `/home/steam/.PlayOnLinux/wineprefix/Steam/drive_c/Program\ Files/Steam/steamapps/common/`

```
desktop@steamos:~$ ls /home/steam/.PlayOnLinux/wineprefix/Steam/drive_c/Program\ Files/Steam/steamapps/common/
Serious Sam HD The Second Encounter  The Apogee Throwback Pack
Super Indie Karts
```

### GAME_EXE
This will be what we want to specify the virtual desktop starts. Once you located your game on [steamdb.info](https://steamdb.info), click the AppID to visit the game page. From there, click on the configuration link, located on the left side. Note the game executable full name.

## An Example game launcher
Below is one example of a completed launcher:
```
# Define some Wine variables for use in the script.
export WINEPREFIX="/home/steam/.PlayOnLinux/wineprefix/Steam"
export WINEDEBUG="-all"
WINEVERSION="$HOME/.PlayOnLinux/wine/linux-x86/1.8"

# Define Steam location and game location here.
# NOTE: GAME_DIR is not used with current method. Possibly remove?
STEAM_DIR="$WINEPREFIX/drive_c/Program Files/Steam"
GAME_APPID="204340"
GAME_DIR="steamapps/common/Serious Sam 2/Bin"
GAME_EXE="Sam2.exe"
```

## Adding the desktop shortcut
Copy a default desktop template file from SteamOS-Tools. be sure to replace "my_game" with the desired name. I advise not to use spaces, but hyphens "-" instead. You can always change the Name field below to suit your needs.

```
sudo cp SteamOS-Tools/cfgs/wine/Default.desktop /usr/share/applications/my_game.desktop
```

Per our example above, we would modify the desktop file as follows:

```
[Desktop Entry]
Version=1.0
Name=Serious Sam 2
GenericName=Game
Type=Application
Exec=/usr/bin/ss2
Icon=playonlinux
Categories=Game;
```

The icon file can be a path to any artwork you wish to use. /r/steamgrid on Reddit is a fantastic resource for these images. Also, in a Google Image search, click the "Search Tools" tab and set the search size to exactly 460x215. This is the standard size for Steam images and you will be able to search for specific grid images much easier.

## Adding the game to SteamOS / BPM
Ensure Steam under POL is closed properly, and exit POL. Click "Return to Steam." Navigate to Settings > Add Library Shortcut. Add your game.

# Demo test videos
***
Coming soon!

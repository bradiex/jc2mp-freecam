# FreeCam (v0.3) for JC2-MP
**FreeCam** is a free/spectate camera module for the [Just Cause 2 Multiplayer Mod](http://store.steampowered.com/app/259080/).<br>
You can also add waypoints to a trajectory and let the camera follow that trajectory automatically (still in beta).<br>
It is also possible to save, load and delete these trajectories on the server which comes in handy to create checkpoints for races or borders for some area's.<br>


## Installation notes
It is required to run a JC2-MP server to run this script.
Go to the [jc-mp wiki page](http://wiki.jc-mp.com/Server) for more information on how to confingure your own server and put these FreeCam files in the 'scripts/' folder.<br>
Look into the 'shared/Config.lua' file to change some settings.<br>
Type (re/un)load freecam into the server console  to (re/un)load this module.<br>

## Usage
- Press V while in game to enter the FreeCam mode
- Use SHIFT to speedup, CTRL to slow down or Increase/Decrease trust on gamepad
- Press V again to exit and if the teleport option is set in Config.lua, the player will be teleported to that specific location
- Making trajectories (while in FreeCam mode):
	- numpad1/gamepad X: reset trajectory
	- numpad2/left mouse click/gamepad A: add waypoint to current trajectory
	- numpad3/gamepad B: start/stop auto follow trajectory mode (starting from the first waypoint)
	- numpad4: start/stop auto follow trajectory mode (starting from current camera position)
	- P: pause the auto follow trajectory mode
- Commands for saving trajectories:
	- Type /freecam &lt;save/load/delete&gt; &lt;trajectory_name&gt; in the chat
- Commands for saving single position:
	- Type /freecam save &lt;position_name&gt; in the chat while having one waypoint set

## For developers
This module launches a "FreeCam" event with argument "active" on both client and serverside when the cam is (de)activated.
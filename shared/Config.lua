Config = {
	-- GENERAL --
	["name"] = "[FreeCam]",
	["color"] = Color(200, 200, 255), 
	["colorError"] = Color(255, 150, 150),
	["activateKey"] = "V",

	-- SPEED --

	-- Setting:
	-- 0: instant speedup
	-- 1: gradually speedup
	["speedSetting"] = 0,

	-- Speedfactor (when using setting 0):
	-- Speedup factor
	["speedUp"] = 8,

	-- Speeddown factor
	["speedDown"] = 4,

	-- MISC --
	-- Teleport player to cam location when quiting
	["teleport"] = true,
	-- Location on the server for the saved trajectories file
	["trajectoryPath"] = "trajectories.txt"
}
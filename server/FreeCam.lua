
class("FreeCamManager")

function FreeCamManager:__init()
	local file = io.open(Config.trajectoryPath, "r")
	if file == nil then
		file = io.open(Config.trajectoryPath, "w")
	end
	file:close()
	Network:Subscribe("FreeCam", self, self.SetPlayerPos)
	Network:Subscribe("FreeCamStore", self, self.StoreTrajectory)
end

function FreeCamManager:SetPlayerPos(args, client)
	if client:InVehicle() then
		client:GetVehicle():SetPosition(args.pos)
		client:GetVehicle():SetPosition(args.angle)
	else
		client:SetPosition(args.pos)
		client:SetAngle(args.angle)
	end
end

function FreeCamManager:StoreTrajectory(args, client)
	if args.type == nil or args.name == nil then
		client:SendChatMessage(string.format("%s Usage: /freecam <save/load/delete> <trajectory_name>",
								Config.name, args.name), Config.color)
		return
	end
	if args.type == "save" then
		if args.trajectory == nil then
			client:SendChatMessage(string.format("%s No trajectory found!", Config.name), Config.colorError)
			return
		end
		local found = false
		for line in io.lines(Config.trajectoryPath) do
			local exists = string.find(line, "NAME%(" .. args.name .. "%)")
			if exists then
				client:SendChatMessage(string.format("%s Trajectory with this name already exists!",
								Config.name), Config.colorError)
				found = true
			end
		end
		if found then return end
		file = io.open(Config.trajectoryPath, "a")
		file:write(string.format("NAME(%s)", args.name))
		for k, v in ipairs(args.trajectory) do
			file:write(string.format("W%f,%f,%f %f,%f,%f",
														v.pos.x,
														v.pos.y,
														v.pos.z,
														v.angle.yaw,
														v.angle.pitch,
														v.angle.roll))
		end
		file:write("\n")
		file:close()
		client:SendChatMessage(string.format("%s Saved trajectory '%s' with %d waypoints",
								Config.name, args.name, #args.trajectory), Config.color)
	elseif args.type == "load" then		
		local found = false
		for line in io.lines(Config.trajectoryPath) do
			local exists = string.find(line, "NAME%(" .. args.name .. "%)")
			if exists then
				local trajectory = {}
				line = string.gsub(line, "NAME%(%a+%)", "")
				line = line:split("W")
				table.remove(line, 1)
				for i, v in ipairs(line) do
					-- Waypoint
					local waypoint = v:split(" ")
					local pos = waypoint[1]:split(",")
					local angle = waypoint[2]:split(",")
					pos = Vector3(tonumber(pos[1]), tonumber(pos[2]), tonumber(pos[3]))
					angle = Angle(tonumber(angle[1]), tonumber(angle[2]), tonumber(angle[3]))
					table.insert(trajectory, {["pos"] = pos,
											  ["angle"] = angle})
				end

				Network:Send(client, "FreeCamStore", {["type"] = "load",
													  ["name"] = args.name,
													  ["trajectory"] = trajectory})
				found = true
			end
		end

		if not found then
			client:SendChatMessage(string.format("%s Error: Trajectory '%s' not found",
									Config.name, args.name), Config.colorError)
		end
	elseif args.type == "delete" then		
		local content = {}
		local found = false
		for line in io.lines(Config.trajectoryPath) do
			local remove = string.find(line, "NAME%(" .. args.name .. "%)")
			if not remove then
				content[#content+1] = line
			else
				found = true
			end
		end

		local file = io.open(Config.trajectoryPath, "w+")
		for i, v in ipairs(content) do
			file:write(v .. "\n")
		end
		file:close()

		if found then			
			client:SendChatMessage(string.format("%s Removed trajectory '%s'",
				Config.name, args.name), Config.color)
		else
			client:SendChatMessage(string.format("%s Error: Trajectory '%s' not found",
				Config.name, args.name), Config.colorError)
		end
	else
		print(args.type)
	end

end

freeCamManager = FreeCamManager()
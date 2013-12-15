-- This file supplies the steel pipes

local pipes_empty_nodenames = {}
local pipes_full_nodenames = {}
local outboxes = {}
local outsel = {}
local outimgs = {}

for xm = 0, 1 do
for xp = 0, 1 do
for ym = 0, 1 do
for yp = 0, 1 do
for zm = 0, 1 do
for zp = 0, 1 do

	outboxes = {}
	outsel = {}
	outimgs = {}

	if yp==1 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_topstub)
		table.insert(outsel, pipeworks.pipe_selectboxes[4])
		table.insert(outimgs, "pipeworks_pipe_end.png")
	else
		table.insert(outimgs, "pipeworks_plain.png")
	end
	if ym==1 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_bottomstub)
		table.insert(outsel, pipeworks.pipe_selectboxes[3])
		table.insert(outimgs, "pipeworks_pipe_end.png")
	else
		table.insert(outimgs, "pipeworks_plain.png")
	end
	if xp==1 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_rightstub)
		table.insert(outsel, pipeworks.pipe_selectboxes[2])
		table.insert(outimgs, "pipeworks_pipe_end.png")
	else
		table.insert(outimgs, "pipeworks_plain.png")
	end
	if xm==1 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_leftstub)
		table.insert(outsel, pipeworks.pipe_selectboxes[1])
		table.insert(outimgs, "pipeworks_pipe_end.png")
	else
		table.insert(outimgs, "pipeworks_plain.png")
	end
	if zp==1 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_backstub)
		table.insert(outsel, pipeworks.pipe_selectboxes[6])
		table.insert(outimgs, "pipeworks_pipe_end.png")
	else
		table.insert(outimgs, "pipeworks_plain.png")
	end
	if zm==1 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_frontstub)
		table.insert(outsel, pipeworks.pipe_selectboxes[5])
		table.insert(outimgs, "pipeworks_pipe_end.png")
	else
		table.insert(outimgs, "pipeworks_plain.png")
	end

	local jx = xp+xm
	local jy = yp+ym
	local jz = zp+zm

	if (jx+jy+jz) == 1 then
		if xm == 1 then 
			table.remove(outimgs, 3)
			table.insert(outimgs, 3, "^pipeworks_plain.png")
		end
		if xp == 1 then 
			table.remove(outimgs, 4)
			table.insert(outimgs, 4, "^pipeworks_plain.png")
		end
		if ym == 1 then 
			table.remove(outimgs, 1)
			table.insert(outimgs, 1, "^pipeworks_plain.png")
		end
		if xp == 1 then 
			table.remove(outimgs, 2)
			table.insert(outimgs, 2, "^pipeworks_plain.png")
		end
		if zm == 1 then 
			table.remove(outimgs, 5)
			table.insert(outimgs, 5, "^pipeworks_plain.png")
		end
		if zp == 1 then 
			table.remove(outimgs, 6)
			table.insert(outimgs, 6, "^pipeworks_plain.png")
		end
	end

	if jx+jy+jz >= 2 then
		pipeworks.add_node_box(outboxes, pipeworks.pipe_bendsphere)
	end

	if (jx==2 and jy~=2 and jz~=2) then
		table.remove(outimgs, 5)
		table.remove(outimgs, 5)
		table.insert(outimgs, 5, pipeworks.liquid_texture.."^pipeworks_windowed_XXXXX.png")
		table.insert(outimgs, 5, pipeworks.liquid_texture.."^pipeworks_windowed_XXXXX.png")
	end

	if (jx~=2 and jy~=2 and jz==2) or (jx~=2 and jy==2 and jz~=2) then
		table.remove(outimgs, 3)
		table.remove(outimgs, 3)
		table.insert(outimgs, 3, pipeworks.liquid_texture.."^pipeworks_windowed_XXXXX.png")
		table.insert(outimgs, 3, pipeworks.liquid_texture.."^pipeworks_windowed_XXXXX.png")
	end

	local pname = xm..xp..ym..yp..zm..zp
	local pgroups = ""

	local image = nil
	local pipedesc = "Pipe segment"
	local pgroups = {snappy=3, pipe=1}

	if pname ~= "110000" then
		pgroups = {snappy=3, pipe=1, not_in_creative_inventory=1}
		pipedesc = "Pipe segment (empty, "..pname..")... You hacker, you."
		image = "pipeworks_plain.png"
	end

	minetest.register_node("pipeworks:pipe_"..pname.."_empty", {
		description = pipedesc,
		drawtype = "nodebox",
		tiles = pipeworks.fix_image_names(outimgs, "_empty"),
		inventory_image = image,
		sunlight_propagates=true,
		paramtype = "light",
		selection_box = {
	             	type = "fixed",
			fixed = outsel
		},
		node_box = {
			type = "fixed",
			fixed = outboxes
		},
		groups = pgroups,
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "pipeworks:pipe_110000_empty",
		after_place_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
	})

	minetest.register_node("pipeworks:pipe_"..pname.."_loaded", {
		description = "Pipe segment (loaded, "..pname..")... You hacker, you.",
		drawtype = "nodebox",
		tiles = pipeworks.fix_image_names(outimgs, "_loaded"),
		inventory_image = image,
		sunlight_propagates = true,
		paramtype = "light",
		selection_box = {
	             	type = "fixed",
			fixed = outsel
		},
		node_box = {
			type = "fixed",
			fixed = outboxes
		},
		groups = {snappy=3, pipe=1, not_in_creative_inventory=1},
		sounds = default.node_sound_wood_defaults(),
		walkable = true,
		drop = "pipeworks:pipe_110000_empty",
		after_place_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end,
		after_dig_node = function(pos)
			pipeworks.scan_for_pipe_objects(pos)
		end
	})
	table.insert(pipes_empty_nodenames,"pipeworks:pipe_"..pname.."_empty") -- for the abms
	table.insert(pipes_full_nodenames,"pipeworks:pipe_"..pname.."_loaded") -- for bacon
end
end
end
end
end
end

table.insert(pipes_empty_nodenames,"pipeworks:valve_on_empty")
table.insert(pipes_empty_nodenames,"pipeworks:valve_off_empty")
table.insert(pipes_empty_nodenames,"pipeworks:entry_panel_empty")
table.insert(pipes_empty_nodenames,"pipeworks:flow_sensor_empty")

table.insert(pipes_full_nodenames,"pipeworks:valve_on_loaded")
table.insert(pipes_full_nodenames,"pipeworks:entry_panel_loaded")
table.insert(pipes_full_nodenames,"pipeworks:flow_sensor_loaded")

minetest.register_abm({
	nodenames = pipes_empty_nodenames,
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		pipeworks.check_for_inflows(pos,node)
	end
})

minetest.register_abm({
	nodenames = pipes_full_nodenames,
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		pipeworks.check_sources(pos,node)
	end
})

minetest.register_abm({
	nodenames = {"pipeworks:spigot","pipeworks:spigot_pouring"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider) 
		pipeworks.spigot_check(pos,node)
	end
})

minetest.register_abm({
	nodenames = {"pipeworks:fountainhead","pipeworks:fountainhead_pouring"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider) 
		pipeworks.fountainhead_check(pos,node)
	end
})


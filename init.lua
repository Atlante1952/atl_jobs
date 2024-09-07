atl_jobs = {}
atl_jobs.mod_storage = minetest.get_mod_storage()
atl_jobs.modpath = minetest.get_modpath("atl_jobs")

local function load_file(path)
    local status, err = pcall(dofile, path)
    if not status then
        minetest.log("error", "-!- Failed to load file: " .. path .. " - Error: " .. err)
    else
        minetest.log("action", "-!- Successfully loaded file: " .. path)
    end
end

if atl_jobs.modpath then
    local files_to_load = {
        "script/api.lua",
        "script/events.lua",
        "script/commands.lua",
    }
    for _, file in ipairs(files_to_load) do
        load_file(atl_jobs.modpath .. "/" .. file)
    end
else
    minetest.log("error", "-!- Files in atl_jobs mod are not set or valid.")
end

atl_jobs.jobs_list = {
    miner = {
        description = "Miner",
        level = 0,
        exp = 0
    },
    farmer = {
        description = "Farmer",
        level = 0,
        exp = 0
    },
    lumberjack = {
        description = "Lumberjack",
        level = 0,
        exp = 0
    },
    florist = {
        description = "Florist", 
        level = 0,
        exp = 0
    },
}

atl_jobs.exp_by_block = {
    miner = {
        {blocs = "default:stone", exp = 1},
        {blocs = "default:stone_with_diamond", exp = 5},
    },
    farmer = {
        {blocs = "farming:wheat_8", exp = 2},
        {blocs = "farming:cotton_8", exp = 2},
    },
    lumberjack = {
        {blocs = "default:tree", exp = 1},
        {blocs = "default:aspen_tree", exp = 1},
    },
    florist = {
        {blocs = "flowers:rose", exp = 2},
        {blocs = "flowers:dandelion_white", exp = 2},
    },
}
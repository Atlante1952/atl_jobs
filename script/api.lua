atl_jobs.mod_storage = minetest.get_mod_storage()

function atl_jobs.on_dignode(pos, oldnode, digger)
    if not digger or not oldnode then
        return
    end
    local player_name = digger:get_player_name()
    local node_name = oldnode.name
    local player_data = atl_jobs.load_player_data(player_name)
    for job, blocks in pairs(atl_jobs.exp_by_block) do
        for _, block in ipairs(blocks) do
            if block.blocs == node_name then
                local exp = block.exp
                local job_data = player_data[job]
                if not job_data then
                    job_data = {level = 0, exp = 0}
                    player_data[job] = job_data
                end
                job_data.exp = (job_data.exp or 0) + exp
                --minetest.chat_send_player(player_name, "BLO " .. node_name .. " EXP " .. exp .. " JOB " .. atl_jobs.jobs_list[job].description .. ".")
                atl_jobs.save_player_data(player_name, player_data)
                return
            end
        end
    end
end

function atl_jobs.load_player_data(player_name)
    if not player_name then
        return {}
    end
    local player_data = {}
    for job, _ in pairs(atl_jobs.jobs_list) do
        local job_data_str = atl_jobs.mod_storage:get_string(player_name .. "_" .. job)
        if job_data_str then
            player_data[job] = minetest.deserialize(job_data_str)
        else
            player_data[job] = {level = 0, exp = 0}
        end
    end
    return player_data
end

function atl_jobs.save_player_data(player_name, player_data)
    if not player_name or not player_data then
        return
    end
    for job, job_data in pairs(player_data) do
        atl_jobs.mod_storage:set_string(player_name .. "_" .. job, minetest.serialize(job_data))
    end
end


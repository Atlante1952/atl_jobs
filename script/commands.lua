minetest.register_chatcommand("jobs", {
    description = "Affiche tous les jobs et les niveaux/expériences du joueur",
    func = function(player_name)
        local player_data = atl_jobs.load_player_data(player_name)
        local formspec = "size[8,4]" ..
                          "bgcolor[#000000;true]" ..
                          "background[5,5;1,1;gui_formbg.png;true]" ..
                          "label[0,0;Your jobs, your levels and experience of each :]" ..
                          "style_type[label;font=bold;textcolor=#FFFFFF]" ..
                          "box[0,0.5;7.5,0.25;#555555]" ..
                          "box[0,3.5;7.5,0.25;#555555]"

        local y = 1.0
        for job, job_info in pairs(atl_jobs.jobs_list) do
            local job_data = player_data[job] or {level = 0, exp = 0}
            formspec = formspec .. "label[0," .. y .. ";" .. job_info.description .. ":]"
            formspec = formspec .. "label[2," .. y .. ";Levels " .. job_data.level .. ", Experiences " .. job_data.exp .. "]"
            y = y + 0.5
        end

        minetest.show_formspec(player_name, "atl_jobs:jobs", formspec)
    end,
})

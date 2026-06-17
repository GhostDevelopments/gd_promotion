lib.callback.register("qbx_promo:server:attemptPromotion", function(source, message)
    local player = exports.qbx_core:GetPlayer(source)
    if not player then return false end

    local jobName = player.PlayerData.job.name
    local jobGrade = player.PlayerData.job.grade.level
    local jobConfig = Config.AllowedJobs[jobName]

    -- Security validation
    if not jobConfig or jobGrade < jobConfig.minGrade then
        return false
    end

    -- Money check
    local currentMoney = exports.qbx_core:GetMoney(source, Config.MoneyType)
    if currentMoney < jobConfig.cost then
        TriggerClientEvent("ox_lib:notify", source, {
            title = Config.Locales["menu_title"],
            description = string.format(Config.Locales["no_money"], Config.MoneyType),
            type = "error"
        })
        return false
    end

    -- Process payment
    if exports.qbx_core:RemoveMoney(source, Config.MoneyType, jobConfig.cost, "business-promotion") then
        TriggerClientEvent("ox_lib:notify", source, {
            title = Config.Locales["menu_title"],
            description = Config.Locales["success"],
            type = "success"
        })

        -- Broadcast to everyone
        local charinfo = player.PlayerData.charinfo
        local fullName = ("%s %s"):format(charinfo.firstname, charinfo.lastname)
        TriggerClientEvent("qbx_promo:client:announce", -1, jobConfig.label, message, fullName)
        return true
    end

    return false
end)

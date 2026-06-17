local lastPromotion = 0

--- Check if string contains blacklisted words
--- @param text string
--- @return boolean
local function isBlacklisted(text)
    local lowerText = string.lower(text)
    for _, word in ipairs(Config.BlacklistedWords) do
        if string.find(lowerText, string.lower(word)) then
            return true
        end
    end
    return false
end

--- Opens the promotion input dialog
local function openPromotionMenu()
    local playerData = exports.qbx_core:GetPlayerData()
    local job = playerData.job.name
    local grade = playerData.job.grade.level

    -- Check if job is allowed
    if not Config.AllowedJobs[job] then return end

    -- Check grade
    if grade < Config.AllowedJobs[job].minGrade then
        lib.notify({
            title = Config.Locales["menu_title"],
            description = Config.Locales["no_permission"],
            type = "error"
        })
        return
    end

    -- Check Cooldown
    local currentTime = GetGameTimer()
    if lastPromotion ~= 0 and (currentTime - lastPromotion) < (Config.Cooldown * 60000) then
        local remaining = math.ceil((Config.Cooldown * 60000 - (currentTime - lastPromotion)) / 60000)
        lib.notify({
            title = Config.Locales["menu_title"],
            description = string.format(Config.Locales["cooldown"], remaining),
            type = "error"
        })
        return
    end

    local input = lib.inputDialog(Config.Locales["menu_title"], {
        {
            type = "textarea",
            label = Config.Locales["input_label"],
            placeholder = Config.Locales["input_placeholder"],
            required = true,
            min = 10,
            max = 250
        }
    })

    if not input or not input[1] then return end

    local message = input[1]

    if isBlacklisted(message) then
        lib.notify({
            title = Config.Locales["menu_title"],
            description = Config.Locales["blacklisted"],
            type = "error"
        })
        return
    end

    local success = lib.callback.await("qbx_promo:server:attemptPromotion", false, message)
    
    if success then
        lastPromotion = GetGameTimer()
    end
end

RegisterCommand("promote", function()
    openPromotionMenu()
end, false)

RegisterNetEvent("qbx_promo:client:announce", function(businessLabel, message, senderName)
    SendNUIMessage({
        action = "announce",
        data = {
            header = Config.Locales["broadcast_header"],
            label = businessLabel,
            message = message,
            sender = senderName,
            duration = Config.DisplayDuration
        }
    })
end)

Config = {}

-- Duration the promotion stays on screen (in milliseconds)
Config.DisplayDuration = 10000 

-- Cooldown between promotions (in minutes)
Config.Cooldown = 15 

-- Currency type: "cash" or "bank"
Config.MoneyType = "bank"

-- Allowed Jobs, their minimum grade level (number), and the cost to promote
Config.AllowedJobs = {
    ["police"] = {
        minGrade = 2,
        cost = 0,
        label = "Atlanta Police Department"
    },
    ["ambulance"] = {
        minGrade = 1,
        cost = 0,
        label = "Atlanta Medical Department"
    },
    ["mechanic"] = {
        minGrade = 0,
        cost = 0,
        label = "Atlanta Mechanic Department"
    },
    ["cardealer"] = {
        minGrade = 1,
        cost = 0,
        label = "Premium Deluxe Motorsport"
    }
}

-- Words that will prevent the message from being sent
Config.BlacklistedWords = {
    "badword1",
    "badword2",
    "exploit",
}

Config.Locales = {
    ["menu_title"] = "Business Promotion",
    ["input_label"] = "Promotion Message",
    ["input_placeholder"] = "Type your advertisement here...",
    ["no_permission"] = "You do not have the required rank to promote this business.",
    ["no_money"] = "You don't have enough money in your %s to pay for this promotion.",
    ["cooldown"] = "You must wait %s minutes before promoting again.",
    ["success"] = "Promotion sent successfully!",
    ["blacklisted"] = "Your message contains forbidden words.",
    ["empty_msg"] = "You cannot send an empty message.",
    ["broadcast_header"] = "BUSINESS ANNOUNCEMENT",
}
AutoFight.Combo.TriedFollowups = AutoFight.Combo.TriedFollowups or {}

function AutoFight.Combo.run(combo)
    local startDelay = AutoFight.Config.ComboStartDelay
    local commandDelay = AutoFight.Config.ComboCommandDelay
    local i = 0

    AutoFight.debug("Starting combo: " .. combo)

    for command in combo:gmatch("%S+") do
        local cmd = command
        local delay = startDelay + (i * commandDelay)

        tempTimer(delay, function()
            if AutoFight.State.Stunned then
                AutoFight.debug("Combo command cancelled - stunned.")
                return
            end

            send(cmd)
        end)

        i = i + 1
    end
end

function AutoFight.Combo.resetFollowups()
    AutoFight.Combo.TriedFollowups = {}
end

function AutoFight.Combo.useFollowup()
    if not AutoFight.Settings.combos then
        return
    end

    for _, attack in ipairs(AutoFight.Settings.combofollowuppriority) do
        if not AutoFight.Combo.TriedFollowups[attack] then
            AutoFight.Combo.TriedFollowups[attack] = true

            AutoFight.debug("Trying combo follow-up: " .. attack)
            send(attack)
            return
        end
    end

    AutoFight.debug("No combo follow-up attacks left.")
end
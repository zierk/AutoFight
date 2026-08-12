AutoFight.Attack.Tried = AutoFight.Attack.Tried or {}

function AutoFight.Attack.resetTried()
    AutoFight.Attack.Tried = {}
end

function AutoFight.Attack.usePriority()
    if not AutoFight.Settings.attack then
        return
    end

    for _, attack in ipairs(AutoFight.Settings.attackpriority) do
        if not AutoFight.Attack.Tried[attack] then
            AutoFight.Attack.Tried[attack] = true

            AutoFight.debug("Trying attack: " .. attack)
            send(attack)
            return
        end
    end

    AutoFight.debug("No priority attacks left.")
end
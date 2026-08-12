AutoFight.Defense = AutoFight.Defense or {}

AutoFight.Defense.Timer = AutoFight.Defense.Timer or nil
AutoFight.Defense.Pending = AutoFight.Defense.Pending or nil

function AutoFight.Defense.getPriority()
    if AutoFight.State.RecoveryMode then
        AutoFight.debug("Recovery Mode - using recovery defense priority.")
        return AutoFight.Settings.recoverypriority
    end

    AutoFight.debug("Using TECH BLOCK defense priority.")
    return AutoFight.Settings.defensepriority
end

function AutoFight.Defense.send(defense)

    if not AutoFight.Settings.defense then
        AutoFight.debug("Defense cancelled - AutoDefense disabled.")
        return
    end

    if AutoFight.State.Stunned then
        AutoFight.debug("Defense cancelled - stunned.")
        return
    end

    if AutoFight.State.PowerStruggle then
        AutoFight.debug("Defense cancelled - PowerStruggle active.")
        return
    end

    if AutoFight.State.Renzoku then
        AutoFight.debug("Defense cancelled - Renzoku active.")
        return
    end

    if AutoFight.State.Barrage then
        AutoFight.debug("Defense cancelled - Barrage active.")
        return
    end

    AutoFight.debug("Defense Action: " .. tostring(defense))
    send(defense)
end

function AutoFight.Defense.handle(defenseString, delay)

    if not AutoFight.Settings.defense then
        return
    end

    if AutoFight.State.Stunned then
        AutoFight.debug("Defense ignored - stunned.")
        AutoFight.Defense.cancel()
        return
    end

    if AutoFight.Defense.Timer then
        killTimer(AutoFight.Defense.Timer)

        AutoFight.debug("Cancelled previous defense: ".. tostring(AutoFight.Defense.Pending))
    end

    AutoFight.Defense.Timer = nil
    AutoFight.Defense.Pending = defense

    AutoFight.debug(
        "Scheduled defense: ".. tostring(defense) .. " in " .. tostring(delay) .. "s")

    if delay <= 0 then
        AutoFight.Defense.Pending = nil
        AutoFight.Defense.send(defense)
        return
    end

    local scheduledDefense = defense

    AutoFight.Defense.Timer = tempTimer(delay, function()
        AutoFight.Defense.Timer = nil
        AutoFight.Defense.Pending = nil

        AutoFight.Defense.send(scheduledDefense)
    end)
end

function AutoFight.Defense.cancel()
    if AutoFight.Defense.Timer then
        killTimer(AutoFight.Defense.Timer)
        AutoFight.Defense.Timer = nil
    end

    AutoFight.Defense.Pending = nil
end

function AutoFight.Defense.handle(defenseString, delay)

    if not AutoFight.Settings.defense then
        return
    end

    if AutoFight.State.SkipNextDefense then
        AutoFight.State.SkipNextDefense = false

        AutoFight.debug(
            "Skipping defense to recover timing."
        )

        AutoFight.Defense.cancel()
        return
    end

    local defenses = {}

    for command in defenseString:gmatch("[^/]+") do
        command = command:match("^%s*(.-)%s*$")
        defenses[command] = true
    end

    local priority = AutoFight.Defense.getPriority()
    local defense = nil

    for _, command in ipairs(priority) do
        if defenses[command] then
            defense = command
            break
        end
    end

    if not defense then
        AutoFight.debug("No matching defense found.")
        return
    end

    AutoFight.Defense.schedule(defense, delay or AutoFight.Settings.defensedelay)
end
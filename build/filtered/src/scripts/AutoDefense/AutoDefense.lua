-- Extracted from AutoFight.mpackage
-- Mudlet Script: AutoFight

AutoFight = AutoFight or {}

AutoFight.Debug = AutoFight.Debug or false
AutoFight.InCombat = AutoFight.InCombat or false
AutoFight.PowerStruggle = AutoFight.PowerStruggle or false
AutoFight.Recovery = AutoFight.Recovery or false
AutoFight.TechBlock = AutoFight.TechBlock or false
AutoFight.TechAttackActive = AutoFight.TechAttackActive or false


AutoFight.DefenseTimer = AutoFight.DefenseTimer or nil
AutoFight.PendingDefense = AutoFight.PendingDefense or nil
AutoFight.TriedAttacks = AutoFight.TriedAttacks or {}

AutoFight.Stamina = AutoFight.Stamina or 100

AutoFight.Renzoku = AutoFight.Renzoku or false
AutoFight.Barrage = AutoFight.Barrage or false


AutoFight.DefensePriority = AutoFight.DefensePriority or {}
AutoFight.StaminaThreshold = AutoFight.StaminaThreshold or 75

AutoFight.DefensePriority.Recovery = {
    "jump",
    "duck",
    "dodge left",
    "dodge right",
    "parry high",
    "parry low",
    "sweep",
    "deflect",
}

AutoFight.DefensePriority.Tech = {
    "parry high",
    "parry low",
    "dodge left",
    "dodge right",
    "jump",
    "duck",
    "sweep",
    "deflect",
}

function AutoFight.getDefensePriority()
    if AutoFight.Stamina < AutoFight.StaminaThreshold then
        AutoFight.debug("Low stamina - using recovery defense priority.")
        return AutoFight.DefensePriority.Recovery
    end

    AutoFight.debug("Stamina healthy - using TECH BLOCK priority.")
    return AutoFight.DefensePriority.Tech
end


AutoFight.AttackPriority = {
    "kamehameha",
    "blast",
    "barrage",
}

AutoFight.ComboFollowupPriority = {
    "zanzoken",
    "renzoku",
    "kame",
    "blast",
}

function AutoFight.usePriorityAttack()
    for _, attack in ipairs(AutoFight.AttackPriority) do
        if not AutoFight.TriedAttacks[attack] then
            AutoFight.TriedAttacks[attack] = true
            AutoFight.debug("Trying attack: " .. attack)

            if attack == "kamehameha" then
                enableTrigger("KAMEHAMEHA FIRE")
            end

            send(attack)
            return
        end
    end

    AutoFight.debug("No priority attacks left. Defaulting to sweep.")
    send("sweep")
end

function AutoFight.sendDefense(defense)
    if AutoFight.PowerStruggle then
        AutoFight.debug("Defense cancelled - PowerStruggle active.")
        return
    end

    if AutoFight.Renzoku then
        AutoFight.debug("Defense cancelled - Renzoku active.")
        return
    end
    
    if AutoFight.Barrage then
        AutoFight.debug("Defense cancelled - Barrage active.")
        return
    end

    send(defense)
end

function AutoFight.scheduleDefense(defense, delay)

    -- Cancel previous pending defense
    if AutoFight.DefenseTimer then
        killTimer(AutoFight.DefenseTimer)

        AutoFight.debug(
            "Cancelled previous defense: "
            .. tostring(AutoFight.PendingDefense)
        )
    end

    AutoFight.DefenseTimer = nil
    AutoFight.PendingDefense = defense

    AutoFight.debug(
        "Scheduled defense: "
        .. tostring(defense)
        .. " in "
        .. tostring(delay)
        .. "s"
    )

    -- Immediate defense
    if delay <= 0 then
        AutoFight.PendingDefense = nil
        AutoFight.sendDefense(defense)
        return
    end

    -- IMPORTANT: this timer remembers its own defense
    local scheduledDefense = defense

    AutoFight.DefenseTimer = tempTimer(delay, function()

        AutoFight.DefenseTimer = nil
        AutoFight.PendingDefense = nil

        AutoFight.sendDefense(scheduledDefense)
    end)
end

function AutoFight.cancelDefense()
    if AutoFight.DefenseTimer then
        killTimer(AutoFight.DefenseTimer)
        AutoFight.DefenseTimer = nil
    end

    AutoFight.PendingDefense = nil
end

function AutoFight.echo(message)
  cecho("\n<magenta>[<cyan>AutoFight<magenta>]<reset> " .. tostring(message).."\n")
end

function AutoFight.debug(message)
  if not AutoFight.Debug then
    return
  end
  
  cecho("\n<magenta>[<cyan>AutoFight<magenta>]<reset> " .. tostring(message).."\n")
end

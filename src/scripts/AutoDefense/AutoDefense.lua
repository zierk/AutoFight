-- Extracted from AutoFight.mpackage
-- Mudlet Script: AutoDefense

AutoDefense = AutoDefense or {}

AutoDefense.Debug = AutoDefense.Debug or false
AutoDefense.InCombat = AutoDefense.InCombat or false
AutoDefense.PowerStruggle = AutoDefense.PowerStruggle or false
AutoDefense.Recovery = AutoDefense.Recovery or false
AutoDefense.TechBlock = AutoDefense.TechBlock or false
AutoDefense.TechAttackActive = AutoDefense.TechAttackActive or false


AutoDefense.DefenseTimer = AutoDefense.DefenseTimer or nil
AutoDefense.PendingDefense = AutoDefense.PendingDefense or nil
AutoDefense.TriedAttacks = AutoDefense.TriedAttacks or {}

AutoDefense.Stamina = AutoDefense.Stamina or 100

AutoDefense.Renzoku = AutoDefense.Renzoku or false
AutoDefense.Barrage = AutoDefense.Barrage or false


AutoDefense.DefensePriority = AutoDefense.DefensePriority or {}
AutoDefense.StaminaThreshold = AutoDefense.StaminaThreshold or 75

AutoDefense.DefensePriority.Recovery = {
    "jump",
    "duck",
    "dodge left",
    "dodge right",
    "parry high",
    "parry low",
    "sweep",
    "deflect",
}

AutoDefense.DefensePriority.Tech = {
    "parry high",
    "parry low",
    "dodge left",
    "dodge right",
    "jump",
    "duck",
    "sweep",
    "deflect",
}

function AutoDefense.getDefensePriority()
    if AutoDefense.Stamina < AutoDefense.StaminaThreshold then
        AutoDefense.debug("Low stamina - using recovery defense priority.")
        return AutoDefense.DefensePriority.Recovery
    end

    AutoDefense.debug("Stamina healthy - using TECH BLOCK priority.")
    return AutoDefense.DefensePriority.Tech
end


AutoDefense.AttackPriority = {
    "kamehameha",
    "blast",
    "barrage",
}

AutoDefense.ComboFollowupPriority = {
    "zanzoken",
    "renzoku",
    "kame",
    "blast",
}

function AutoDefense.usePriorityAttack()
    for _, attack in ipairs(AutoDefense.AttackPriority) do
        if not AutoDefense.TriedAttacks[attack] then
            AutoDefense.TriedAttacks[attack] = true
            AutoDefense.debug("Trying attack: " .. attack)

            if attack == "kamehameha" then
                enableTrigger("KAMEHAMEHA FIRE")
            end

            send(attack)
            return
        end
    end

    AutoDefense.debug("No priority attacks left. Defaulting to sweep.")
    send("sweep")
end

function AutoDefense.sendDefense(defense)
    if AutoDefense.PowerStruggle then
        AutoDefense.debug("Defense cancelled - PowerStruggle active.")
        return
    end

    if AutoDefense.Renzoku then
        AutoDefense.debug("Defense cancelled - Renzoku active.")
        return
    end
    
    if AutoDefense.Barrage then
        AutoDefense.debug("Defense cancelled - Barrage active.")
        return
    end

    send(defense)
end

function AutoDefense.scheduleDefense(defense, delay)

    -- Cancel previous pending defense
    if AutoDefense.DefenseTimer then
        killTimer(AutoDefense.DefenseTimer)

        AutoDefense.debug(
            "Cancelled previous defense: "
            .. tostring(AutoDefense.PendingDefense)
        )
    end

    AutoDefense.DefenseTimer = nil
    AutoDefense.PendingDefense = defense

    AutoDefense.debug(
        "Scheduled defense: "
        .. tostring(defense)
        .. " in "
        .. tostring(delay)
        .. "s"
    )

    -- Immediate defense
    if delay <= 0 then
        AutoDefense.PendingDefense = nil
        AutoDefense.sendDefense(defense)
        return
    end

    -- IMPORTANT: this timer remembers its own defense
    local scheduledDefense = defense

    AutoDefense.DefenseTimer = tempTimer(delay, function()

        AutoDefense.DefenseTimer = nil
        AutoDefense.PendingDefense = nil

        AutoDefense.sendDefense(scheduledDefense)
    end)
end

function AutoDefense.cancelDefense()
    if AutoDefense.DefenseTimer then
        killTimer(AutoDefense.DefenseTimer)
        AutoDefense.DefenseTimer = nil
    end

    AutoDefense.PendingDefense = nil
end

function AutoDefense.echo(message)
  cecho("\n<magenta>[<cyan>AutoDefense<magenta>]<reset> " .. tostring(message).."\n")
end

function AutoDefense.debug(message)
  if not AutoDefense.Debug then
    return
  end
  
  cecho("\n<magenta>[<cyan>AutoDefense<magenta>]<reset> " .. tostring(message).."\n")
end

AutoFight = AutoFight or {}

AutoFight.Config = AutoFight.Config or {}
AutoFight.State = AutoFight.State or {}
AutoFight.Defense = AutoFight.Defense or {}
AutoFight.Attack = AutoFight.Attack or {}
AutoFight.Combo = AutoFight.Combo or {}
AutoFight.TechBlock = AutoFight.TechBlock or {}
AutoFight.PowerStruggle = AutoFight.PowerStruggle or {}


AutoFight.DefenseTimer = AutoFight.DefenseTimer or nil
AutoFight.PendingDefense = AutoFight.PendingDefense or nil
AutoFight.TriedAttacks = AutoFight.TriedAttacks or {}

AutoFight.Stamina = AutoFight.Stamina or 100





function AutoFight.getDefensePriority()
    if AutoFight.Stamina < AutoFight.Config.StaminaThreshold then
        AutoFight.debug("Low stamina - using recovery defense priority.")
        return AutoFight.Config.DefensePriority.Recovery
    end

    AutoFight.debug("Stamina healthy - using TECH BLOCK priority.")
    return AutoFight.Config.DefensePriority.Tech
end


function AutoFight.usePriorityAttack()
    for _, attack in ipairs(AutoFight.Config.AttackPriority) do
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
  if not AutoFight.Config.Debug then
    return
  end
  
  cecho("\n<yellow>[<green>AutoFight<yellow>]<reset> " .. tostring(message).."\n")
end

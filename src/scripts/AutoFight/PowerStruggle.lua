function AutoFight.PowerStruggle.start(opponentAttack)
    AutoFight.State.PowerStruggle = true
    AutoFight.State.PowerStruggleDistance = 0

    -- Cancel any defense that was already scheduled
    AutoFight.Defense.cancel()

    AutoFight.debug(
        "Power Struggle started: " .. tostring(opponentAttack)
    )
end


function AutoFight.PowerStruggle.stop(result, opponent)
    AutoFight.State.PowerStruggle = false
    AutoFight.State.PowerStruggleDistance = 0

    AutoFight.debug(
        "Power Struggle ended: "
        .. tostring(result)
        .. " vs "
        .. tostring(opponent)
    )
end


function AutoFight.PowerStruggle.roundWon(distance)
    distance = tonumber(distance)

    if not AutoFight.State.PowerStruggle then
        return
    end

    AutoFight.State.PowerStruggleDistance = distance or 0

    AutoFight.debug(
        "Power Struggle round WON - distance: "
        .. tostring(AutoFight.State.PowerStruggleDistance)
    )
end


function AutoFight.PowerStruggle.roundLost(distance, opponentAttack)
    distance = tonumber(distance)

    if not AutoFight.State.PowerStruggle then
        return
    end

    AutoFight.State.PowerStruggleDistance = distance or 0

    AutoFight.debug(
        "Power Struggle round LOST - "
        .. tostring(opponentAttack)
        .. " distance: "
        .. tostring(AutoFight.State.PowerStruggleDistance)
    )
end
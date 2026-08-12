function AutoFight.Kaioken.start()
    if not AutoFight.Settings.kaioken then
        return
    end

    if AutoFight.State.Kaioken then
        return
    end

    if AutoFight.State.Stamina <= AutoFight.Settings.kaiokenstaminathreshold then
        AutoFight.debug("Kaioken not started - stamina too low.")
        return
    end

    local level = AutoFight.Settings.kaiokenlevel

    AutoFight.debug(
        "Starting Kaioken x" .. tostring(level)
    )

    send("kaioken " .. tostring(level))

    AutoFight.State.Kaioken = true
    AutoFight.State.KaiokenLevel = level
end


function AutoFight.Kaioken.stop(reason)
    if not AutoFight.State.Kaioken then
        return
    end

    AutoFight.debug(
        "Attempting to stop Kaioken"
        .. (reason and " - " .. reason or "")
    )

    send("kaioken 0")
end

function AutoFight.Kaioken.confirmStopped()
    AutoFight.State.Kaioken = false
    AutoFight.State.KaiokenLevel = 0

    AutoFight.debug("Kaioken successfully stopped.")
end

function AutoFight.Kaioken.checkStamina()
    if not AutoFight.State.Kaioken then
        return
    end

    if AutoFight.State.Stamina <= AutoFight.Settings.kaiokenstaminathreshold then
        AutoFight.Kaioken.stop("stamina threshold reached")
    end
end
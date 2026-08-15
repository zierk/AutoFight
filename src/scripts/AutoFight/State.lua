AutoFight.State.InCombat = AutoFight.State.InCombat or false

AutoFight.State.Stunned = AutoFight.State.Stunned or false
AutoFight.State.RecoveryMode = AutoFight.State.RecoveryMode or false
AutoFight.State.SkipNextDefense = AutoFight.State.SkipNextDefense or false
AutoFight.State.Stamina = AutoFight.State.Stamina or 100
AutoFight.State.CurrentPL = AutoFight.State.CurrentPL or 0
AutoFight.State.MaxPL = AutoFight.State.MaxPL or 0
AutoFight.State.EnemyPL = AutoFight.State.EnemyPL or 0

AutoFight.State.TechBlockActive = AutoFight.State.TechBlockActive or false
AutoFight.State.TechAttackActive = AutoFight.State.TechAttackActive or false

AutoFight.State.Renzoku = AutoFight.State.Renzoku or false
AutoFight.State.Barrage = AutoFight.State.Barrage or false

AutoFight.State.PowerStruggle = AutoFight.State.PowerStruggle or false
AutoFight.State.PowerStruggleDistance = AutoFight.State.PowerStruggleDistance or 0

AutoFight.State.Kaioken = AutoFight.State.Kaioken or false
AutoFight.State.KaiokenLevel = AutoFight.State.KaiokenLevel or 0

AutoFight.State.PoweringUp = AutoFight.State.PoweringUp or false
AutoFight.State.PowerUpPending = AutoFight.State.PowerUpPending or false

function AutoFight.State.updateRecoveryMode()
    local staminaLow =
        AutoFight.State.Stamina < AutoFight.Settings.staminathreshold

    local enemyTooStrong = false

    if AutoFight.State.CurrentPL > 0 then
        enemyTooStrong =
            AutoFight.State.EnemyPL >
            (AutoFight.State.CurrentPL * AutoFight.Settings.recoverypldelta)
    end

    local recoveryMode = staminaLow or enemyTooStrong

    -- Only announce when the state actually changes
    if recoveryMode ~= AutoFight.State.RecoveryMode then
        AutoFight.State.RecoveryMode = recoveryMode

        if recoveryMode then
            AutoFight.debug("Recovery Mode: ON")
        else
            AutoFight.debug("Recovery Mode: OFF")
        end
    end
end

function AutoFight.State.checkPowerUp()
    if not AutoFight.Settings.powerup then
        AutoFight.State.PowerUpPending = false
        return
    end

    if not AutoFight.State.InCombat then
        AutoFight.State.PowerUpPending = false
        return
    end

    if AutoFight.State.MaxPL <= 0 then
        return
    end

    local plPercent =
        (AutoFight.State.CurrentPL / AutoFight.State.MaxPL) * 100

    local missingPL = 100 - plPercent

    local shouldPowerUp =
        AutoFight.State.Stamina > AutoFight.Settings.powerupstaminathreshold
        and missingPL > AutoFight.Settings.powerupplthreshold

    if not shouldPowerUp then
        AutoFight.State.PowerUpPending = false
        return
    end

    -- Already confirmed as powering up
    if AutoFight.State.PoweringUp then
        return
    end

    -- Need to power up, but can't act while stunned
    if AutoFight.State.Stunned then
        AutoFight.State.PowerUpPending = true
        AutoFight.debug("Power up pending - currently stunned.")
        return
    end

    AutoFight.State.PowerUpPending = true

    AutoFight.debug("Requesting power up.")
    send("power up")
end
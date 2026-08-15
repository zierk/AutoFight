AutoFight.State.Stunned = false
AutoFight.debug("Movement regained.")

if AutoFight.State.PowerUpPending then
    AutoFight.debug("Retrying pending power up.")
    AutoFight.State.checkPowerUp()
end
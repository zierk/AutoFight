AutoFight.State.Stamina = tonumber(matches[2])
AutoFight.State.CurrentPL = AutoFight.parseNumber(matches[3])
AutoFight.State.MaxPL = AutoFight.parseNumber(matches[4])
AutoFight.State.EnemyPL = AutoFight.parseNumber(matches[5])

if not AutoFight.State.InCombat then
    AutoFight.State.InCombat = true
    AutoFight.debug("Combat state: ON")
end

AutoFight.State.updateRecoveryMode()
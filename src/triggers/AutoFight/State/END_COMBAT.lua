AutoFight.Defense.cancel()

if AutoFight.State.Kaioken then
    AutoFight.Kaioken.stop("combat ended")
end

AutoFight.State.Recovery = false
AutoFight.State.InCombat = false
AutoFight.State.PowerStruggle = false
AutoFight.State.TechBlockActive = false
AutoFight.State.TechAttackActive = false

AutoFight.State.Renzoku = false
AutoFight.State.Barrage = false

AutoFight.debug("End combat.")
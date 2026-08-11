-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: END COMBAT
-- Regex: ^\* (.*) is DEAD!$

AutoFight.cancelDefense()

AutoFight.State.Recovery = false
AutoFight.InCombat = false
AutoFight.State.PowerStruggle = false
AutoFight.State.TechBlock = false
AutoFight.State.TechAttackActive = false

AutoFight.State.Renzoku = false
AutoFight.State.Barrage = false

AutoFight.debug("End combat.")

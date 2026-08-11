-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: END COMBAT
-- Regex: ^\* (.*) is DEAD!$

AutoDefense.cancelDefense()

AutoDefense.Recovery = false
AutoDefense.InCombat = false
AutoDefense.PowerStruggle = false
AutoDefense.TechBlock = false
AutoDefense.TechAttackActive = false

AutoDefense.Renzoku = false
AutoDefense.Barrage = false

AutoDefense.debug("End combat.")

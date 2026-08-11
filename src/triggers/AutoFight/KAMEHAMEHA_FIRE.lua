-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: KAMEHAMEHA FIRE
-- Regex: ^\* Your Kamehameha is READY TO FIRE!$

if not AutoFight.State.TechAttackActive then return end

AutoFight.State.TechAttackActive = false

AutoFight.debug("Firing Kamehameha.")
send("kamehameha")

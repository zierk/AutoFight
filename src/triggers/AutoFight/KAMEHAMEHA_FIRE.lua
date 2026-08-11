-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: KAMEHAMEHA FIRE
-- Regex: ^\* Your Kamehameha is READY TO FIRE!$

if not AutoFight.TechAttackActive then return end

AutoFight.TechAttackActive = false

AutoFight.debug("Firing Kamehameha.")
send("kamehameha")

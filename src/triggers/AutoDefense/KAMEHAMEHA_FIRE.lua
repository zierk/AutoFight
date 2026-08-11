-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: KAMEHAMEHA FIRE
-- Regex: ^\* Your Kamehameha is READY TO FIRE!$

if not AutoDefense.TechAttackActive then return end

AutoDefense.TechAttackActive = false

AutoDefense.debug("Firing Kamehameha.")
send("kamehameha")

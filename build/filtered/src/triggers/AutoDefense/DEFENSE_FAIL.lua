-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: DEFENSE FAIL
-- Regex: ^You parry the air!$

if not AutoFight.InCombat then return end

AutoFight.Recovery = true
AutoFight.debug("Defense Failure Detected! Recovery Mode: " .. tostring(AutoFight.Recovery))

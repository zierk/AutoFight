-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: DEFENSE FAIL
-- Regex: ^You parry the air!$

if not AutoDefense.InCombat then return end

AutoDefense.Recovery = true
AutoDefense.debug("Defense Failure Detected! Recovery Mode: " .. tostring(AutoDefense.Recovery))

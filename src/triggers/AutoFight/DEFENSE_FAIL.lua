-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: DEFENSE FAIL
-- Regex: ^You parry the air!$

if not AutoFight.InCombat then return end

AutoFight.State.Recovery = true
AutoFight.debug("Defense Failure Detected! Recovery Mode: " .. tostring(AutoFight.State.Recovery))

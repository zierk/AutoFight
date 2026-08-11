-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: COMBAT PROMPT
-- Regex: ^<(\d+(?:\.\d+)?)%> / <[^>]+> / vs\. <[^>]+>$

AutoFight.Stamina = tonumber(matches[2])

if not AutoFight.InCombat then
    AutoFight.InCombat = true
    AutoFight.debug("Combat state: ON")
end

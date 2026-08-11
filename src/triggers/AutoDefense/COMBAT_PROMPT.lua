-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: COMBAT PROMPT
-- Regex: ^<(\d+(?:\.\d+)?)%> / <[^>]+> / vs\. <[^>]+>$

AutoDefense.Stamina = tonumber(matches[2])

if not AutoDefense.InCombat then
    AutoDefense.InCombat = true
    AutoDefense.debug("Combat state: ON")
end

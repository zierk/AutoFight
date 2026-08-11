-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: TECH BLOCK ATTACK HANDLER
-- Regex: ^You can't use (.+) for another \d+(?:\.\d+)? second\(s\)!$

local attack = matches[2]

if not AutoFight.TechAttackActive then
    AutoFight.debug("Ignoring priority fallback for: " .. attack)
    return
end

AutoFight.debug(attack .. " unavailable - trying next priority.")

AutoFight.usePriorityAttack()

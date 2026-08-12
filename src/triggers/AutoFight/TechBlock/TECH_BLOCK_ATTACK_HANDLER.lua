local attack = matches[2]

if not AutoFight.State.TechAttackActive then
    AutoFight.debug("Ignoring priority fallback for: " .. attack)
    return
end

AutoFight.debug(attack .. " unavailable - trying next priority.")

AutoFight.Attack.usePriority()
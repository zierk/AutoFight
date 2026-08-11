-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: TECH BLOCK STUN
-- Regex: ^\* TECH BLOCK bonus! (.*) is stunned!$

AutoFight.TechBlock = true
AutoFight.TechAttackActive = false
AutoFight.TriedAttacks = {}

tempTimer(1, function()
    if AutoFight.TechBlock then
        AutoFight.TechBlock = false
        AutoFight.TechAttackActive = true

        AutoFight.debug("No COMBO detected - starting Tech attack.")
        AutoFight.usePriorityAttack()
    end
end)

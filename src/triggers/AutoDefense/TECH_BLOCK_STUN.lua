-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: TECH BLOCK STUN
-- Regex: ^\* TECH BLOCK bonus! (.*) is stunned!$

AutoDefense.TechBlock = true
AutoDefense.TechAttackActive = false
AutoDefense.TriedAttacks = {}

tempTimer(1, function()
    if AutoDefense.TechBlock then
        AutoDefense.TechBlock = false
        AutoDefense.TechAttackActive = true

        AutoDefense.debug("No COMBO detected - starting Tech attack.")
        AutoDefense.usePriorityAttack()
    end
end)

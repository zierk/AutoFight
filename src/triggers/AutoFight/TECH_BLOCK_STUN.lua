-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: TECH BLOCK STUN
-- Regex: ^\* TECH BLOCK bonus! (.*) is stunned!$

AutoFight.State.TechBlock = true
AutoFight.State.TechAttackActive = false
AutoFight.TriedAttacks = {}

tempTimer(1, function()
    if AutoFight.State.TechBlock then
        AutoFight.State.TechBlock = false
        AutoFight.State.TechAttackActive = true

        AutoFight.debug("No COMBO detected - starting Tech attack.")
        AutoFight.usePriorityAttack()
    end
end)

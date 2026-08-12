function AutoFight.TechBlock.start()
    AutoFight.State.TechBlockActive = true
    AutoFight.State.TechAttackActive = false

    AutoFight.Attack.resetTried()

    AutoFight.debug("TECH BLOCK stun detected - waiting for combo.")

    tempTimer(1, function()

        if not AutoFight.State.TechBlockActive then
            AutoFight.debug("Combo claimed TECH BLOCK - fallback cancelled.")
            return
        end

        AutoFight.State.TechBlockActive = false
        AutoFight.State.TechAttackActive = true

        AutoFight.debug("No combo detected - starting TECH attack.")

        AutoFight.Attack.usePriority()
    end)
end

function AutoFight.TechBlock.claimCombo()
    if not AutoFight.State.TechBlockActive then
        return false
    end

    AutoFight.State.TechBlockActive = false
    AutoFight.State.TechAttackActive = false

    AutoFight.debug("COMBO detected - TECH attack cancelled.")

    return true
end
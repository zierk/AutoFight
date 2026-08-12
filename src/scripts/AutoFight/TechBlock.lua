function AutoFight.TechBlock.start()
    AutoFight.Defense.cancel()
    
    AutoFight.State.TechBlockActive = true
    AutoFight.State.TechBlockCombo = false
    AutoFight.State.TechAttackActive = false

    AutoFight.Attack.resetTried()

    AutoFight.debug("TECH BLOCK stun detected - waiting for combo.")

    tempTimer(1, function()

        if not AutoFight.State.TechBlockActive then
            return
        end

        if AutoFight.State.TechBlockCombo then
            AutoFight.debug("Combo detected - priority attack cancelled.")
            return
        end

        AutoFight.State.TechAttackActive = true

        AutoFight.debug("No combo detected - using attack priority during stun.")

        AutoFight.Attack.usePriority()
    end)
end

function AutoFight.TechBlock.claimCombo()
    if not AutoFight.State.TechBlockActive then
        return false
    end

    AutoFight.State.TechBlockCombo = true
    AutoFight.State.TechAttackActive = false

    AutoFight.debug("COMBO detected.")

    return true
end

function AutoFight.TechBlock.endWindow(target)
    if not AutoFight.State.TechBlockActive then
        return
    end

    AutoFight.State.TechBlockActive = false
    AutoFight.State.TechBlockCombo = false
    AutoFight.State.TechAttackActive = false

    AutoFight.debug("TECH BLOCK ended - ".. tostring(target).. " regained movement.")
end
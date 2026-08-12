if not AutoFight.State.TechAttackActive then return end

local attack = matches[2]:lower()
send(attack)

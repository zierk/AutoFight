if not AutoFight.State.InCombat then return end

AutoFight.State.Recovery = true
AutoFight.debug("Defense Failure Detected! Recovery Mode: " .. tostring(AutoFight.State.Recovery))

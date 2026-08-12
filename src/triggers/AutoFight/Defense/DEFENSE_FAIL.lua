if not AutoFight.State.InCombat then return end

AutoFight.State.SkipNextDefense = true
AutoFight.debug("Defense Failure Detected! SkipNextDefense: " .. tostring(AutoFight.State.SkipNextDefense))

local direction = matches[3]

AutoFight.debug("Target sent flying " .. direction)

AutoFight.Combo.resetFollowups()
AutoFight.Combo.useFollowup()

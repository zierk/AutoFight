-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: COMBO FOLLOWUP
-- Regex: ^\* Your .* sends (.*) flying (north|south|east|west|northeast|northwest|southeast|southwest)!$

local direction = matches[3]

AutoFight.debug("Target sent flying " .. direction)

AutoFight.useComboFollowup()

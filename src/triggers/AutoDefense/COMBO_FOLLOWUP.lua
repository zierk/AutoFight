-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: COMBO FOLLOWUP
-- Regex: ^\* Your .* sends (.*) flying (north|south|east|west|northeast|northwest|southeast|southwest)!$

local direction = matches[3]

AutoDefense.debug("Target sent flying " .. direction)

AutoDefense.useComboFollowup()

-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: DEFEND
-- Regex: ^\* (.*)\.\.\. \((.*)\)$

if AutoFight.Recovery then
    AutoFight.Recovery = false

    AutoFight.debug(
        "Allowing hit, will resume defense next round. Recovery Mode: "
        .. tostring(AutoFight.Recovery)
    )

    AutoFight.cancelDefense()
    return
end

local defenses = {}

for command in matches[3]:gmatch("[^/]+") do
    command = command:match("^%s*(.-)%s*$")
    defenses[command] = true
end

local priority = AutoFight.getDefensePriority()

local defense = nil

for _, command in ipairs(priority) do
    if defenses[command] then
        defense = command
        break
    end
end

if not defense then
    AutoFight.debug("ERROR: No matching defense found.")
    return
end

AutoFight.scheduleDefense(defense, 2.5)

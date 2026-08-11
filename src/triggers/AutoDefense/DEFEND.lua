-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: DEFEND
-- Regex: ^\* (.*)\.\.\. \((.*)\)$

if AutoDefense.Recovery then
    AutoDefense.Recovery = false

    AutoDefense.debug(
        "Allowing hit, will resume defense next round. Recovery Mode: "
        .. tostring(AutoDefense.Recovery)
    )

    AutoDefense.cancelDefense()
    return
end

local defenses = {}

for command in matches[3]:gmatch("[^/]+") do
    command = command:match("^%s*(.-)%s*$")
    defenses[command] = true
end

local priority = AutoDefense.getDefensePriority()

local defense = nil

for _, command in ipairs(priority) do
    if defenses[command] then
        defense = command
        break
    end
end

if not defense then
    AutoDefense.debug("ERROR: No matching defense found.")
    return
end

AutoDefense.scheduleDefense(defense, 2.5)

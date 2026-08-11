-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: TIMED DEFENSE
-- Regex: ^\* (.*), (\d+(?:\.\d+)?)s to defend! \(([^)]+)\)(?: .*)?$

local defendTime = tonumber(matches[3])
local defenses = {}

for command in matches[4]:gmatch("[^/]+") do
    command = command:match("^%s*(.-)%s*$")
    defenses[command] = true
end

local priority = {
    "dodge left",
    "dodge right",
    "jump",
    "duck",
    "parry high",
    "parry low",
    "sweep",
    "deflect",
}

local defense = nil

for _, command in ipairs(priority) do
    if defenses[command] then
        defense = command
        break
    end
end

if defense then
    AutoDefense.debug(
        "Timed defense selected: "
        .. defense
        .. " in "
        .. defendTime
        .. "s"
    )

    AutoDefense.scheduleDefense(defense, defendTime)
end

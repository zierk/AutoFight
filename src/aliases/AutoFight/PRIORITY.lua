local input = matches[2] or ""

if input == "" then
    AutoFight.priorityHelp()
    return
end

local parts = {}

for word in input:gmatch("%S+") do
    table.insert(parts, word)
end

local listName = parts[1] and parts[1]:lower() or nil

local validLists = {
    defense = true,
    recovery = true,
    attack = true,
    combo = true,
}

if not listName or not validLists[listName] then
    AutoFight.echo(
        "Unknown priority list: " .. tostring(listName)
    )

    AutoFight.priorityHelp()
    return
end

-- Just "af priority defense"
if #parts == 1 then
    AutoFight.showPriority(listName)
    return
end

local action = parts[2]:lower()

-- Everything after the action is the command
local command = input:match("^%S+%s+%S+%s+(.+)$")

if not command then
    AutoFight.priorityHelp()
    return
end

if action == "add" then
    AutoFight.addPriority(
        listName,
        command
    )

elseif action == "remove" then
    AutoFight.removePriority(
        listName,
        command
    )

else
    AutoFight.echo(
        "Unknown priority action: " .. action
    )

    AutoFight.priorityHelp()
end
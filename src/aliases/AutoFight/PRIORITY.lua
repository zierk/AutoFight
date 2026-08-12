local input = matches[2] or ""

local listName, action, command =
    input:match("^(%S+)%s+(%S+)%s+(.+)$")

if not listName or not action or not command then
    AutoFight.priorityHelp()
    return
end

listName = listName:lower()
action = action:lower()

local validLists = {
    defense = true,
    recovery = true,
    attack = true,
    combo = true,
}

if not validLists[listName] then
    AutoFight.echo("Unknown priority list: " .. listName)
    AutoFight.priorityHelp()
    return
end

if action == "add" then
    AutoFight.addPriority(listName, command)

elseif action == "remove" then
    AutoFight.removePriority(listName, command)

else
    AutoFight.echo("Unknown priority action: " .. action)
    AutoFight.priorityHelp()
end
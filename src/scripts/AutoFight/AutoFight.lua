AutoFight = AutoFight or {}

AutoFight.Config = AutoFight.Config or {}
AutoFight.State = AutoFight.State or {}
AutoFight.Defense = AutoFight.Defense or {}
AutoFight.Attack = AutoFight.Attack or {}
AutoFight.Combo = AutoFight.Combo or {}
AutoFight.TechBlock = AutoFight.TechBlock or {}
AutoFight.PowerStruggle = AutoFight.PowerStruggle or {}

function AutoFight.echo(message)
  cecho("\n<magenta>[<cyan>AutoFight<magenta>]<reset> " .. tostring(message).."\n")
end

function AutoFight.debug(message)
  if not AutoFight.Config.Debug then
    return
  end
  
  cecho("\n<yellow>[<green>AutoFight<yellow>]<reset> " .. tostring(message).."\n")
end

function AutoFight.parseNumber(value)
    local number, suffix = tostring(value):match("([%d%.]+)([KkMmBb]?)")

    number = tonumber(number)

    if not number then
        return 0
    end

    suffix = suffix:lower()

    if suffix == "k" then
        number = number * 1000
    elseif suffix == "m" then
        number = number * 1000000
    elseif suffix == "b" then
        number = number * 1000000000
    end

    return number
end
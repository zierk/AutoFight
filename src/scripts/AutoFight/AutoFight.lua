AutoFight = AutoFight or {}

AutoFight.Config = AutoFight.Config or {}
AutoFight.State = AutoFight.State or {}
AutoFight.Defense = AutoFight.Defense or {}
AutoFight.Attack = AutoFight.Attack or {}
AutoFight.Combo = AutoFight.Combo or {}
AutoFight.TechBlock = AutoFight.TechBlock or {}
AutoFight.PowerStruggle = AutoFight.PowerStruggle or {}

AutoFight.Settings = AutoFight.Settings or {}
AutoFight.SettingsFile = getMudletHomeDir() .. "/AutoFightSettings.lua"

function AutoFight.copyTable(tbl)
    local copy = {}

    for key, value in pairs(tbl) do
        if type(value) == "table" then
            copy[key] = AutoFight.copyTable(value)
        else
            copy[key] = value
        end
    end

    return copy
end

function AutoFight.applyDefaults(settings, defaults)
    for key, value in pairs(defaults) do
        if settings[key] == nil then
            if type(value) == "table" then
                settings[key] = AutoFight.copyTable(value)
            else
                settings[key] = value
            end

        elseif type(value) == "table"
            and type(settings[key]) == "table" then

            AutoFight.applyDefaults(
                settings[key],
                value
            )
        end
    end
end

function AutoFight.loadSettings()
    AutoFight.Settings = {}

    if io.exists(AutoFight.SettingsFile) then
        table.load(
            AutoFight.SettingsFile,
            AutoFight.Settings
        )
    end

    AutoFight.applyDefaults(
        AutoFight.Settings,
        AutoFight.Config.Defaults
    )

    AutoFight.saveSettings()
end


function AutoFight.saveSettings()
    table.save(
        AutoFight.SettingsFile,
        AutoFight.Settings
    )
end

function AutoFight.setSetting(name, value)
    name = name:lower()

    if AutoFight.Settings[name] == nil then
        AutoFight.echo("Unknown setting: " .. name)
        return
    end

    local current = AutoFight.Settings[name]

    if type(current) == "boolean" then
        value = tostring(value):lower()

        if value == "on" or value == "true" then
            AutoFight.Settings[name] = true

        elseif value == "off" or value == "false" then
            AutoFight.Settings[name] = false

        else
            AutoFight.echo("Use on or off for " .. name)
            return
        end

    elseif type(current) == "number" then
        local number = tonumber(value)

        if not number then
            AutoFight.echo("Invalid number for " .. name)
            return
        end

        AutoFight.Settings[name] = number

    else
        AutoFight.echo(
            name .. " cannot be changed with af set."
        )
        return
    end

    AutoFight.saveSettings()

    AutoFight.echo(
        name .. " = "
        .. tostring(AutoFight.Settings[name])
    )
end

function AutoFight.status()
    AutoFight.echo("User Settings")

    cecho(
        "  Defense:          "
        .. tostring(AutoFight.Settings.defense)
        .. "\n"
    )

    cecho(
        "  Attack:           "
        .. tostring(AutoFight.Settings.attack)
        .. "\n"
    )

    cecho(
        "  Combos:           "
        .. tostring(AutoFight.Settings.combos)
        .. "\n"
    )

    cecho(
        "  Stamina Threshold: "
        .. tostring(AutoFight.Settings.staminathreshold)
        .. "%\n"
    )

    cecho(
        "  Defense Delay:     "
        .. tostring(AutoFight.Settings.defensedelay)
        .. "s\n"
    )

    cecho("\nDefense Priority:\n")

    for i, defense in ipairs(AutoFight.Settings.defensepriority) do
        cecho(
            "  " .. i .. ". "
            .. defense
            .. "\n"
        )
    end

    cecho("\nRecovery Priority:\n")

    for i, defense in ipairs(AutoFight.Settings.recoverypriority) do
        cecho(
            "  " .. i .. ". "
            .. defense
            .. "\n"
        )
    end

    cecho("\nAttack Priority:\n")

    for i, attack in ipairs(AutoFight.Settings.attackpriority) do
        cecho(
            "  " .. i .. ". "
            .. attack
            .. "\n"
        )
    end

    cecho("\nCombo Follow-up Priority:\n")

    for i, attack in ipairs(AutoFight.Settings.combofollowuppriority) do
        cecho(
            "  " .. i .. ". "
            .. attack
            .. "\n"
        )
    end
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

--------------------------------------------------
-- MESSAGES
--------------------------------------------------

function AutoFight.echo(message)
  cecho("\n<magenta>[<cyan>AutoFight<magenta>]<reset> " .. tostring(message).."\n")
end

function AutoFight.debug(message)
  if not AutoFight.Config.Debug then
    return
  end
  
  cecho("\n<yellow>[<green>AutoFight<yellow>]<reset> " .. tostring(message).."\n")
end
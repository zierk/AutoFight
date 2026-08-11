-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: COMBO!
-- Regex: ^Combination!\s*\(\s*(.*?)\s*\)$

if not AutoFight.State.TechBlock then
    return
end

AutoFight.State.TechBlock = false
AutoFight.State.TechAttackActive = false

AutoFight.debug("COMBO detected.")

local combo = matches[2]

local function runCombo()
    local startDelay = 0.5
    local commandDelay = 0.25
    local i = 0

    AutoFight.debug("Starting combo: " .. combo)

    for command in combo:gmatch("%S+") do
        local cmd = command
        local delay = startDelay + (i * commandDelay)

        tempTimer(delay, function()
            send(cmd)
        end)

        i = i + 1
    end
end

runCombo()

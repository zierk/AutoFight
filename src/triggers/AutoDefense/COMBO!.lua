-- Extracted from AutoFight.mpackage
-- Mudlet Trigger: COMBO!
-- Regex: ^Combination!\s*\(\s*(.*?)\s*\)$

if not AutoDefense.TechBlock then
    return
end

AutoDefense.TechBlock = false
AutoDefense.TechAttackActive = false

AutoDefense.debug("COMBO detected.")

local combo = matches[2]

local function runCombo()
    local startDelay = 0.5
    local commandDelay = 0.25
    local i = 0

    AutoDefense.debug("Starting combo: " .. combo)

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

if not AutoFight.Settings.autoburst then
    return
end

AutoFight.debug("Flying towards " .. matches[2] .. " - enabling burst.")

send("burst")
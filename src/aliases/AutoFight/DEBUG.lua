AutoFight.Config.Debug = not AutoFight.Config.Debug

if AutoFight.Config.Debug then
    AutoFight.echo("Debug: <green>ON<reset>")
    AutoFight.debug("Debug Test!")
else
    AutoFight.echo("Debug: <red>OFF<reset>")
end

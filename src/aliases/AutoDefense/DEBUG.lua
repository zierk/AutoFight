-- Extracted from AutoFight.mpackage
-- Mudlet Alias: DEBUG

AutoDefense.Debug = not AutoDefense.Debug

if AutoDefense.Debug then
    AutoDefense.echo("Debug: <green>ON<reset>")
    AutoDefense.debug("Debug Test!")
else
    AutoDefense.echo("Debug: <red>OFF<reset>")
end

AutoFight = AutoFight or {}

AutoFight.Config = AutoFight.Config or {}
AutoFight.State = AutoFight.State or {}
AutoFight.Defense = AutoFight.Defense or {}
AutoFight.Attack = AutoFight.Attack or {}
AutoFight.Combo = AutoFight.Combo or {}
AutoFight.TechBlock = AutoFight.TechBlock or {}
AutoFight.PowerStruggle = AutoFight.PowerStruggle or {}



AutoFight.TriedAttacks = AutoFight.TriedAttacks or {}

AutoFight.Stamina = AutoFight.Stamina or 100



function AutoFight.echo(message)
  cecho("\n<magenta>[<cyan>AutoFight<magenta>]<reset> " .. tostring(message).."\n")
end

function AutoFight.debug(message)
  if not AutoFight.Config.Debug then
    return
  end
  
  cecho("\n<yellow>[<green>AutoFight<yellow>]<reset> " .. tostring(message).."\n")
end

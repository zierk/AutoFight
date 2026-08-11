AutoFight.Config = AutoFight.Config or {}

--------------------------------------------------
-- DEFENSE
--------------------------------------------------

AutoFight.Config.StaminaThreshold = 75

AutoFight.Config.DefensePriority = {}

AutoFight.Config.DefensePriority.Recovery = {
    "jump",
    "duck",
    "dodge left",
    "dodge right",
    "parry high",
    "parry low",
    "sweep",
    "deflect",
}

AutoFight.Config.DefensePriority.Tech = {
    "parry high",
    "parry low",
    "dodge left",
    "dodge right",
    "jump",
    "duck",
    "sweep",
    "deflect",
}

--------------------------------------------------
-- ATTACK
--------------------------------------------------

AutoFight.Config.AttackPriority = {
    "kamehameha",
    "blast",
    "barrage",
}

AutoFight.Config.ComboFollowupPriority = {
    "zanzoken",
    "renzoku",
    "kame",
    "blast",
}

--------------------------------------------------
-- RECOVERY / POWER UP
--------------------------------------------------

AutoFight.Config.PowerUpPLThreshold = 50
AutoFight.Config.PowerUpStaminaThreshold = 75

--------------------------------------------------
-- TIMING
--------------------------------------------------

AutoFight.Config.DefenseDelay = 2.5
AutoFight.Config.ComboStartDelay = 0.5
AutoFight.Config.ComboCommandDelay = 0.25
AutoFight.Config.TechBlockWindow = 5
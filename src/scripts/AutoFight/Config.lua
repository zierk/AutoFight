AutoFight.Config = AutoFight.Config or {}

AutoFight.Config.Debug = AutoFight.Config.Debug or false

AutoFight.Config.ComboStartDelay = 0.5
AutoFight.Config.ComboCommandDelay = 0.25
AutoFight.Config.TechBlockWindow = 5

AutoFight.Config.Defaults = {
    combos = true,
    defense = true,
    attack = true,
    
    kaioken = true,
    kaiokenlevel = 2,
    kaiokenstaminathreshold = 50,

    staminathreshold = 75,
    defensedelay = 2.5,

    defensepriority = {
        "parry high",
        "parry low",
        "dodge left",
        "dodge right",
        "jump",
        "duck",
    },

    recoverypriority = {
        "jump",
        "duck",
        "dodge left",
        "dodge right",
        "parry high",
        "parry low",
    },

    attackpriority = {
        "kamehameha",
        "blast",
        "barrage",
    },

    combofollowuppriority = {
        "zanzoken",
        "renzoku",
        "kame",
        "blast",
    },
}

AutoFight.loadSettings()
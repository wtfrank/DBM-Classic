local mod	= DBM:NewMod("Akumai", "DBM-Party-Classic", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(4829)
--mod:SetEncounterID(1672)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 3490"
)

local warningFrenziedRage	= mod:NewSpellAnnounce(3490, 4)

local timerFrenziedRageCD	= mod:NewAITimer(180, 3490, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerFrenziedRageCD:Start(1-delay)
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 3490 then
		warningFrenziedRage:Show()
		timerFrenziedRageCD:Start()
	end
end

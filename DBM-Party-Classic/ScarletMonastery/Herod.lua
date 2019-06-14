local mod	= DBM:NewMod("Herod", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(3975)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 8989",
	"SPELL_AURA_APPLIED 8269"
)

--TODO: Is WW SPELL_CAST_START or success or applied?
local specWarnWhirlwind				= mod:NewSpecialWarningRun(8989, nil, nil, nil, 4, 2)
local warningEnrage					= mod:NewTargetNoFilterAnnounce(8269, 2)

local timerWhirlwindCD				= mod:NewAITimer(180, 8989, nil, nil, nil, 4, nil, DBM_CORE_DEADLY_ICON)

function mod:OnCombatStart(delay)
	timerWhirlwindCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 8989 then
		specWarnWhirlwind:Show()
		specWarnWhirlwind:Play("justrun")
		timerWhirlwindCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8269 then
		warningEnrage:Show(args.destName)
	end
end

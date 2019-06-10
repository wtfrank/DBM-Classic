local mod	= DBM:NewMod("ArcanistDoan", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(6487)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 9435",
	"SPELL_CAST_SUCCESS 8988 9433",
	"SPELL_AURA_APPLIED 13323 8988"
)

local warningPolymorph				= mod:NewTargetNoFilterAnnounce(13323, 2)
local warningSilence				= mod:NewTargetNoFilterAnnounce(8988, 2)
local warningArcaneExplosion		= mod:NewSpellAnnounce(9433, 2)

local specWarnDetonation			= mod:NewSpecialWarningRun(9435, nil, nil, nil, 4, 2)

local timerDetonationCD				= mod:NewAITimer(180, 9435, nil, nil, nil, 2)
local timerSilenceCD				= mod:NewAITimer(180, 8988, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerArcaneExplosionCD		= mod:NewAITimer(180, 9433, nil, nil, nil, 2, nil, DBM_CORE_HEALER_ICON)

function mod:OnCombatStart(delay)
	timerDetonationCD:Start(1-delay)
	timerSilenceCD:Start(1-delay)
	timerArcaneExplosionCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 9435 then
		specWarnDetonation:Show()
		specWarnDetonation:Play("justrun")
		timerDetonationCD:Start()
	end
end

function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 9433 then
		warningArcaneExplosion:Show()
		timerArcaneExplosionCD:Start()
	elseif args.spellId == 8988 then
		timerSilenceCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 13323 then
		warningPolymorph:Show(args.destName)
	elseif args.spellId == 8988 then
		warningSilence:Show(args.destName)
	end
end

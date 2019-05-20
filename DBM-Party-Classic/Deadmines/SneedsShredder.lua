local mod	= DBM:NewMod("SneedsShredder", "DBM-Party-Classic", 3)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(642)
--mod:SetEncounterID(1144)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 7399 6713",
	"SPELL_AURA_APPLIED 7399 6713"
)

local warningFear			= mod:NewTargetNoFilterAnnounce(7399, 2)
local warningDisarm			= mod:NewTargetNoFilterAnnounce(6713, 2)

local timerFearCD			= mod:NewAITimer(180, 7399, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)
local timerDisarmCD			= mod:NewAITimer(180, 6713, nil, nil, nil, 5, nil, DBM_CORE_TANK_ICON)

function mod:OnCombatStart(delay)
	timerFearCD:Start(1-delay)
	timerDisarmCD:Start(1-delay)
end


function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 7399 then
		timerFearCD:Start()
	elseif args.spellId == 7399 then
		timerDisarmCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 7399 then
		warningFear:Show(args.destName)
	elseif args.spellId == 6713 then
		warningDisarm:Show(args.destName)
	end
end

local mod	= DBM:NewMod("Bazzalan", "DBM-Party-Classic", 8)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(11519)
--mod:SetEncounterID(1445)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_SUCCESS 3583",
	"SPELL_AURA_APPLIED 3583"
)

local warningDeadlyPoison			= mod:NewTargetNoFilterAnnounce(3583, 2, nil, "RemovePoison")

local timerDeadlyPoisonCD			= mod:NewAITimer(180, 3583, nil, "RemovePoison", nil, 5, nil, DBM_CORE_POISON_ICON)

function mod:OnCombatStart(delay)
	timerDeadlyPoisonCD:Start(1-delay)
end


function mod:SPELL_CAST_SUCCESS(args)
	if args.spellId == 3583 then
		timerDeadlyPoisonCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 3583 and self:CheckDispelFilter() then
		warningDeadlyPoison:Show(args.destName)
	end
end

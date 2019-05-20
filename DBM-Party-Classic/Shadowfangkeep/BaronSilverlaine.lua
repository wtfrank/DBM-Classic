local mod	= DBM:NewMod("BaronSilverlaine", "DBM-Party-Classic", 15)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(3887)

mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 23224",
	"SPELL_AURA_APPLIED 23224"
)

local warningVeilofShadow			= mod:NewTargetNoFilterAnnounce(23224, 2)

local timerVeilofShadowCD			= mod:NewAITimer(180, 23224, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)

function mod:OnCombatStart(delay)
	timerVeilofShadowCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 23224 then
		timerVeilofShadowCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 23224 then
		warningVeilofShadow:Show(args.destName)
	end
end

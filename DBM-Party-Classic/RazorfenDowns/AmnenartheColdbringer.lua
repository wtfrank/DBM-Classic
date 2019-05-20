local mod	= DBM:NewMod(1141, "DBM-Party-Classic", 9, 233)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(74434)
mod:SetEncounterID(1666)

mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_CAST_START"
)

local warningDruidSlumber			= mod:NewTargetNoFilterAnnounce(8040, 2)
local warningHealingTouch			= mod:NewCastAnnounce(23381, 2)

local specWarnDruidsSlumber			= mod:NewSpecialWarningInterrupt(8040, "HasInterrupt", nil, nil, 1, 2)

local timerDruidsSlumberCD			= mod:NewAITimer(180, 8040, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON..DBM_CORE_MAGIC_ICON)
local timerHealingTouchCD			= mod:NewAITimer(180, 23381, nil, nil, nil, 4, nil, DBM_CORE_INTERRUPT_ICON)

function mod:OnCombatStart(delay)
	timerDruidsSlumberCD:Start(1-delay)
	timerHealingTouchCD:Start(1-delay)
end

function mod:SPELL_CAST_START(args)
	if args.spellId == 8040 then
		timerDruidsSlumberCD:Start()
		if self:CheckInterruptFilter(args.sourceGUID, false, true) then
			specWarnDruidsSlumber:Show(args.sourceName)
			specWarnDruidsSlumber:Play("kickcast")
		end
	elseif args.spellId == 23381 then
		warningHealingTouch:Show()
		timerHealingTouchCD:Start()
	end
end

function mod:SPELL_AURA_APPLIED(args)
	if args.spellId == 8040 then
		warningDruidSlumber:Show(args.destName)
	end
end--]]

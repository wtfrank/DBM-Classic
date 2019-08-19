local mod	= DBM:NewMod("Moam", "DBM-AQ20", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(15340)
mod:SetEncounterID(720)
mod:SetModelID(15392)
mod:RegisterCombat("combat")

--[[
mod:RegisterEventsInCombat(
	"SPELL_AURA_APPLIED 25685",
	"SPELL_AURA_REMOVED 25685"
)

--TODO, this mod needs redoing, spellID for stoneform was wrong, and at this point have no data on this boss
local warnStoneform		= mod:NewSpellAnnounce(25685, 3)

local timerStoneform	= mod:NewNextTimer(90, 25685, nil, nil, nil, 6)
local timerStoneformDur	= mod:NewBuffActiveTimer(90, 25685, nil, nil, nil, 6)

function mod:OnCombatStart(delay)
	timerStoneform:Start(-delay)
end

do
	local MortalWound = DBM:GetSpellInfo(25646)
	function mod:SPELL_AURA_APPLIED(args)
		if args.spellId == 25685 then
			warnStoneform:Show()
			timerStoneformDur:Start()
		end
	end

	function mod:SPELL_AURA_REMOVED(args)
		if args.spellId == 25685 then
			timerStoneformDur:Stop()
			timerStoneform:Start()
		end
	end
end
--]]

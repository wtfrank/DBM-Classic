local mod	= DBM:NewMod("Lucifron", "DBM-MC", 1)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(12118)--, 12119
mod:SetEncounterID(663)
mod:SetModelID(13031)
mod:RegisterCombat("combat")

mod:RegisterEventsInCombat(
	"SPELL_CAST_START 20604",
	"SPELL_CAST_SUCCESS 19702 19703"
--	"SPELL_AURA_APPLIED 20604"
)

--[[
(ability.id = 19702 or ability.id = 19703 or ability.id = 20604) and type = "cast"
--]]
local warnDoom		= mod:NewSpellAnnounce(19702, 2)
local warnCurse		= mod:NewSpellAnnounce(19703, 3)
local warnMC		= mod:NewTargetNoFilterAnnounce(20604, 4)

local specWarnMC	= mod:NewSpecialWarningYou(20604, nil, nil, nil, 1, 2)
local yellMC		= mod:NewYell(20604)

local timerCurseCD	= mod:NewCDTimer(20.5, 19703, nil, nil, nil, 3, nil, DBM_CORE_CURSE_ICON)--20-25N)
local timerDoomCD	= mod:NewCDTimer(20, 19702, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)--20-25
--local timerDoom		= mod:NewCastTimer(10, 19702, nil, nil, nil, 3, nil, DBM_CORE_MAGIC_ICON)

function mod:OnCombatStart(delay)
	timerDoomCD:Start(7-delay)--7-8
	timerCurseCD:Start(12-delay)--12-15
end

do
	local MindControl = DBM:GetSpellInfo(20604)
	function mod:MCTarget(targetname, uId)
		if not targetname then return end
		warnMC:CombinedShow(1, targetname)
		if targetname == UnitName("player") then
			specWarnMC:Show()
			specWarnMC:Play("targetyou")
			yellMC:Yell()
		end
	end

	function mod:SPELL_CAST_START(args)
		local spellName = args.spellName
		if spellName == MindControl and args:IsSrcTypeHostile() then
			self:BossTargetScanner(args.sourceGUID, "MCTarget", 0.2, 8)
		end
	end

	--[[function mod:SPELL_AURA_APPLIED(args)
		--if args.spellId == 20604 then
		if args.spellName == MindControl then
			warnMC:CombinedShow(1, args.destName)
		end
	end--]]
end

do
	local Doom, Curse = DBM:GetSpellInfo(19702), DBM:GetSpellInfo(19703)
	function mod:SPELL_CAST_SUCCESS(args)
		--local spellId = args.spellId
		local spellName = args.spellName
		--if spellId == 19702 then
		if spellName == Doom then
			self:SendSync("Doom")
			if self:AntiSpam(5, 1) then
				warnDoom:Show()
--				timerDoom:Start()
				timerDoomCD:Start()
			end
		--elseif spellId == 19703 then
		elseif spellName == Curse then
			self:SendSync("Curse")
			if self:AntiSpam(5, 2) then
				warnCurse:Show()
				timerCurseCD:Start()
			end
		end
	end
end

function mod:OnSync(msg, targetName)
	if not self:IsInCombat() then return end
	if msg == "Doom" and self:AntiSpam(5, 1) then
		warnDoom:Show()
--		timerDoom:Start()
		timerDoomCD:Start()
	elseif msg == "Curse" and self:AntiSpam(5, 2) then
		warnCurse:Show()
		timerCurseCD:Start()
	end
end

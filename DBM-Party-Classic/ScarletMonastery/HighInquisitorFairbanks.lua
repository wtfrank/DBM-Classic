local mod	= DBM:NewMod("Fairbanks", "DBM-Party-Classic", 12)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(4542)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

local mod	= DBM:NewMod("BloodmageThalnos", "DBM-Party-Classic", 11)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(4543)
--mod:SetEncounterID(585)

mod:RegisterCombat("combat")

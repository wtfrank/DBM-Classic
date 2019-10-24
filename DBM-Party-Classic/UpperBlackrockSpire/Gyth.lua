local mod	= DBM:NewMod("Gyth", "DBM-Party-Classic", 4)
local L		= mod:GetLocalizedStrings()

mod:SetRevision("@file-date-integer@")
mod:SetCreatureID(10339)

mod:RegisterCombat("combat")

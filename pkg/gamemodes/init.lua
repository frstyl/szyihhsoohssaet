-- SPDX-License-Identifier: GPL-3.0-or-later

local extension = Package:new("szyihhsoohssaet_gamemode", Package.SpecialPack)

extension:loadSkillSkelsByPath("./packages/szyihhsoohssaet/pkg/gamemodes/rule_skills")

extension:addGameMode(require ("packages.szyihhsoohssaet.pkg.gamemodes.1v2"))


Fk:loadTranslationTable{ ["szyihhsoohssaet_gamemode"] = "水滸殺模式" }
-- Fk:loadTranslationTable(require 'packages.gamemode.i18n.en_US', 'en_US')

return {
  extension,
}

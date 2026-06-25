local tshjitjjevs = fk.CreateSkill{
  name = "tshjitjjevs",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tshjitjjevs"] = "七燿",
  [":tshjitjjevs"] = "鎖定恆續.伱視爲裝僃七星劍.",

  ["@[:]virtual_equip"] = "虛兵",
  ["@$virtual_equip"] = "虛兵",
  ["$tshjitjjevs1"] = "寒光纵横，血战八方！",
  ["$tshjitjjevs2"] = "七燿霜刃，力贯山河！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tshjitjjevs:addEffect("atkrange", {
  virtual_weapon_func = function(self, player)
    if player:hasSkill(tshjitjjevs.name) then
      return 2
    end
  end,
})

tshjitjjevs:addAcquireEffect(function (self, player)
    player.room:addSkill("#tshjit_seec_kiams_skill")
    S.addVirtualEquip(player,"tshjit_seec_kiams",tshjitjjevs.name)
    -- player.room:addTableMark(player,"@[:]virtual_equip","tshjit_seec_kiams")
end)
tshjitjjevs:addLoseEffect (function (self, player)
    S.removeVirtualEquip(player,"tshjit_seec_kiams",tshjitjjevs.name)
    -- player.room:removeTableMark(player,"@[:]virtual_equip","tshjit_seec_kiams")
end)

tshjitjjevs:addEffect("filter", {
  skill_filter = function (self, player)
    if table.contains(player:getSkillNameList(), tshjitjjevs.name) and
      Fk.skills[tshjitjjevs.name]:isEffectable(player) 
    then
      return {"#tshjit_seec_kiams_skill"}
    end
  end,
})

return tshjitjjevs

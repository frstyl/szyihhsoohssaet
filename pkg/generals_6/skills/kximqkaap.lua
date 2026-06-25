

local kximqkaap= fk.CreateSkill({
  name = "kximqkaap",
  tags = {Skill.Compulsory},
})

Fk:loadTranslationTable{
["kximqkaap"] = "金甲",
[":kximqkaap"] = "鎖定恆續.視爲伱裝僃虛賽唐猊",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- kximqkaap:addEffect(fk.GameStart, {
--   can_refresh = function(self, event, target, player, data)
--     return player:hasSkill(kximqkaap.name)
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:addTableMark(player,"@[:]virtual_equip","soeojs_doac_ceej")
--   end,
-- })

kximqkaap: addAcquireEffect(function (self, player)
    player.room:addSkill("#soeojs_doac_ceej_skill")
    S.addVirtualEquip(player,"soeojs_doac_ceej",kximqkaap.name)
end)
kximqkaap:addLoseEffect (function (self, player)
    S.removeVirtualEquip(player,"soeojs_doac_ceej",kximqkaap.name)
end)

kximqkaap:addEffect("filter", {
  skill_filter = function (self, player)
    if table.contains(player:getSkillNameList(), kximqkaap.name) and
      Fk.skills[kximqkaap.name]:isEffectable(player) 
    then
      return {"#soeojs_doac_ceej_skill"}
    end
  end,
})
return kximqkaap

local ljen_hzfan_maah = fk.CreateSkill {
  name = "#ljen_hzfan_maah_skill",
  tags = { Skill.Compulsory },
  attached_equip = "ljen_hzfan_maah",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ljen_hzfan_maah:addEffect("maxcards", {
  correct_func = function(self, player)
    if   player:hasSkill(ljen_hzfan_maah.name)  then
    -- if  S.hasEquip(player, attached_equip) and self:isEffectable(player)  then
      return  2
    end
  end,
})
return ljen_hzfan_maah

local equipSkill = fk.CreateSkill {
  name = "#soam_ddioc_khoeojh_skill",
  tags = { Skill.Compulsory },
  attached_equip = "soam_ddioc_khoeojh",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(equipSkill.name) and
    data.card.trueName == "ssaet" and data.card.color ~= Card.Red
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.use, data)
    end,
  on_use = function(self, event, target, player, data)

    S.effectNullify(data,player,equipSkill.name)
        -- data.nullified = true
  end
})




return equipSkill

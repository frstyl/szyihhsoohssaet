local equipSkill = fk.CreateSkill {
  name = "#boos_nzjin_kaap_skill",
  attached_equip = "boos_nzjin_kaap",
  -- tags = { Skill.Compulsory },
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 



-- equipSkill:addEffect(fk.PreCardEffect, {
--   anim_type = "defensive",
--   can_trigger = function(self, event, target, player, data)
--     return data.to == player and player:hasSkill(equipSkill.name) 
--     and  data.card.trueName == "ssaet" 
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local judge = {
--       who = player,
--       reason = equipSkill.name,
--       pattern = ".|.|heart,diamod,nocolorred",
--     }
--     room:judge(judge)
--     if judge:matchPattern() then
--       data.nullified = true
--       S.effectNullify(data,player,equipSkill.name)
--     end
--   end,
-- })
equipSkill:addEffect(fk.TargetConfirming, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(equipSkill.name) 
    and  data.card.trueName == "ssaet" 
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.use)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judge = {
      who = player,
      reason = equipSkill.name,
      pattern = ".|.|heart,diamond,nocolorred",
    }
    room:judge(judge)
    if judge:matchPattern() then
      -- data:removeTarget(player)
      data:cancelTarget(player)
    end
  end,
})


return equipSkill

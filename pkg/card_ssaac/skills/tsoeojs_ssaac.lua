local cardSkill = fk.CreateSkill {
  name = "tsoeojs_ssaac_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tsoeojs_ssaac_skill",
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return  Util.GlobalCanUse(self, player, card, extra_data) 
    and S.magicCanUse(player, card)
  end,  
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, true)
  end,
  mod_target_filter = Util.TrueFunc,
  about_to_effect = function(self, room, effect)  --有何意義??不能抵消
    if not effect.to:isWounded() then
      return true
    end
  end,
  offset_func= Util.FalseFunc,
  on_action = function(self, room, use, finished)
    if not finished or not use.extra_data or not use.extra_data.tsoeojs_ssaac then return end
    for _, t in ipairs(use.extra_data.tsoeojs_ssaac) do
      local p =room:getPlayerById(t[1])
      local n =t[2]
      if not p.dead then
        local cards = room:askToDiscard(p, {
          min_num = n,
          max_num = n,
          include_equip = false,
          skill_name = "tsoeojs_ssaac_skill" ,
          cancelable = false,
          prompt = "#tsoeojs_ssaac-discard:::"..n,
        })
        end
    end
  end,
  on_effect = function(self, room, effect)
    room:addSkill("tsoeojs_ssaac_delay")
    if effect.to:isWounded() and not effect.to.dead then
      local n= effect.to:getLostHp()  --被攔截??
      room:recover({
        who = effect.to,
        num = n,
        recoverBy = effect.from,
        card = effect.card,
        skillName = cardSkill.name,
      })
    end
      -- local cards = room:askToDiscard(to, {
      --   min_num = n,
      --   max_num = n,
      --   include_equip = false,
      --   skill_name = cardSkill.name,
      --   cancelable = false,
      --   prompt = "#tsoeojs_ssaac-discard",
      -- })
  end,
})

return cardSkill

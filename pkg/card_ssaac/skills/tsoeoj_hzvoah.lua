local cardSkill = fk.CreateSkill {
  name = "tsoeoj_hzvoah_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tsoeoj_hzvoah_skill",
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return  Util.GlobalCanUse(self, player, card, extra_data) 
    and S.magicCanUse(player, card)
  end,  
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    Util.AoeCardOnUse(self, cardUseEvent.from, cardUseEvent, false)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, distance_limited)
    return to_select ~= player
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local loopTimes = effect:getResponseTimes()
    local respond
    for i = 1, loopTimes do
      local  prompt = "#tsoeoj_hzvoah_skill-ask"
      local params = { ---@type AskToUseCardParams
        skill_name = cardSkill.name,
        pattern = '.|.|red',
        cancelable = true,
        event_data = effect,
        prompt = prompt,
      }
      respond = room:askToResponse(effect.to, params)
      if respond then
        room:responseCard(respond)
        -- S.removeTsziukzzyit()
      else
        S.addTsziukzzyitBuff(effect.to,"debuff",effect.from,effect.card)
        -- room:damage({
        --   from = effect.from,
        --   to = effect.to,
        --   card = effect.card,
        --   damage = 1,
        --   damageType = fk.NormalDamage,
        --   skillName = cardSkill.name,
        -- })
        break
      end
      if effect.to.dead then break end
    end
  end,
})

cardSkill:addAI(nil, "__card_skill")
cardSkill:addAI(nil, "default_card_skill")


return cardSkill

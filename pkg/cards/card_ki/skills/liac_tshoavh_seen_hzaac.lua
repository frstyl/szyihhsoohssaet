local cardSkill = fk.CreateSkill {
  name = "liac_tshoavh_seen_hzaac_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#liac_tshoavh_seen_hzaac_skill",
  mod_target_filter = Util.TrueFunc,
  -- can_use = Util.FalseFunc,
  can_use = function(self, player, card, extra_data)
    return extra_data and (extra_data.liac_tshoavh_seen_hzaac or extra_data.bypass_moment)
  end,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    effect.to:drawCards(2, cardSkill.name)
  end,
})

cardSkill:addEffect(fk.RoundStart, {
  priority=0,
  can_trigger = function (self, event, target, player, data)
    return player.seat==1
  end,
  on_trigger = function (self, event, target, player, data)
    
    local room=target.room
    local params={
      skill_name = "liac_tshoavh_seen_hzaac_skill",
      pattern="liac_tshoavh_seen_hzaac",
      cancelable=true,
      prompt="#liac_tshoavh_seen_hzaac_use",
      skip=true,
      extra_data = {
        liac_tshoavh_seen_hzaac = true,
      }
    }
    while true do  --trigger_times ?
     local use = S.askToUseKoarbiukCard(S.getHolders("liac_tshoavh_seen_hzaac"), params) 

      if use then
        player.room:useCard(use)
      else
        return
      end
    end

  end,
})

return cardSkill

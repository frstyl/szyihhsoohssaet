local cardSkill = fk.CreateSkill {
  name = "mxevs_svoans_quo_seen_buff",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect(fk.PreCardUse, {
  priority=0,
  -- global=true,
  -- is_delay_effect=true,
  can_refresh= function(self, event, target, player, data)
    return player==target and target:getMark("@@mxevs_svoans_quo_seen-turn")>0 
    and S.isCommonTrick(data.card.trueName)
  end,
  on_refresh= function(self, event, target, player, data)
    data.prohibitedCardNames=data.prohibitedCardNames or {}
    -- table.insertIfNeed(data.prohibitedCardNames,"buac_hzfan_mujs_nzjen")
    -- table.insertIfNeed(data.prohibitedCardNames,"tsiac_keejs_dzius_keejs")
    data.unoffsetableList = table.simpleClone(player.room.players)
  end,
})

cardSkill:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return player:getMark("@@mxevs_svoans_quo_seen-turn")>0 and card and S.getCardTypeByName(card.trueName)==2
  end,
})

return cardSkill

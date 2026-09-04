local muoshqinh = fk.CreateSkill {
  name = "muoshqinh",
}

Fk:loadTranslationTable{
  ["muoshqinh"] = "霧隱",
  [":muoshqinh"] = "伱輪始旹,伱可預打出2x手牌指定至多x脚色發動:爲所選脚色附加霧隱幖記,輪終淸除,伱印取得2*x空牌.霧隱幖記效果:脚色受到非雷傷旹,迻除幖記,防止傷害",

  ["#muoshqinh_active"] = "霧隱 打出2x手牌指定x脚色發動",
  ["@@muoshqinh-round"] = "霧隱",

  ["$muoshqinh1"] = "侌司鬼神 護附吾身",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

muoshqinh:addEffect(fk.RoundStart, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(muoshqinh.name) and
      not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local yes, dat = room:askToUseActiveSkill(player, {  
      skill_name = "muoshqinh_active",
      prompt = "#muoshqinh-choose",
      cancelable = true,
      skip = true,  --不執行
    })
    if yes and dat then
      event:setCostData(self, {cards = dat.cards, tos = dat.targets})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards = event:getCostData(self).cards
    S.playCard(cards,muoshqinh.name,player)

    for _, p in ipairs(event:getCostData(self).tos) do
      room:addPlayerMark(p, "@@muoshqinh-round")  --多來源?
    end
    -- room:setPlayerMark(player, "_muoshqinh", table.map(event:getCostData(self).tos, Util.IdMapper))
    -- room:addSkill("muoshqinh")
    room:moveCards({
      ids = S.getKhouc( #cards),
      to = player,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = player,
      skill_name = muoshqinh.name,
      moveVisible = true,
    })
  end,
})
muoshqinh:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player  --問多次?
    and target:getMark("@@muoshqinh-round") > 0 
    and data.damageType ~= fk.ThunderDamage 
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@@muoshqinh-round",0)  --多來源?
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = muoshqinh.name }
    S.preventDamage({damageData=data,skillName=muoshqinh.name})
  end,
})

-- local clean_spec = {
--   can_refresh = function(self, event, target, player, data)
--     return  player:getMark("muoshqinh") ~= 0
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     for _, id in ipairs(player:getMark("_muoshqinh")) do
--       room:removePlayerMark(room:getPlayerById(id), "@@muoshqinh-round")
--     end
--     room:setPlayerMark(player, "_muoshqinh", 0)
--   end,
-- }
-- muoshqinh:addEffect(fk.RoundEnd, clean_spec)
-- -- muoshqinh:addEffect(fk.Death, clean_spec)

return muoshqinh

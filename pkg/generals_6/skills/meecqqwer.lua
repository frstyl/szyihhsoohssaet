local meecqqwer = fk.CreateSkill {
  name = "meecqqwer",
}

Fk:loadTranslationTable{
  ["meecqqwer"] = "冥䘙",
  [":meecqqwer"] = "伱輪始旹,伱可預打出2x手牌指定至多x角色發動:爲所選角色附加冥䘙幖記,輪終清除,伱印取得2x空.冥䘙幖記效果:角色受到非雷傷旹,迻除幖記,防止傷害",

  ["#meecqqwer_active"] = "冥䘙 打出2x手牌指定x角色發動",
  ["@@meecqqwer-round"] = "冥䘙",

  ["$meecqqwer1"] = "侌司鬼神 護附吾身",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

meecqqwer:addEffect(fk.RoundStart, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(meecqqwer.name) and
      not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "meecqqwer_active",
      prompt = "#meecqqwer-choose",
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
    S.playCard(player,cards,meecqqwer.name)

    for _, p in ipairs(event:getCostData(self).tos) do
      room:addPlayerMark(p, "@@meecqqwer-round")  --多來源?
    end
    -- room:setPlayerMark(player, "_meecqqwer", table.map(event:getCostData(self).tos, Util.IdMapper))
    -- room:addSkill("meecqqwer")
    room:moveCards({
      ids = S.getKhouc(room, #cards),
      to = player,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = player,
      skill_name = meecqqwer.name,
      moveVisible = true,
    })
  end,
})
meecqqwer:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player  --問多次?
    and target:getMark("@@meecqqwer-round") > 0 
    and data.damageType ~= fk.ThunderDamage 
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@@meecqqwer-round",0)  --多來源?
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = meecqqwer.name }
    S.preventDamage({damageData=data,skillName=meecqqwer.name})
  end,
})

-- local clean_spec = {
--   can_refresh = function(self, event, target, player, data)
--     return  player:getMark("meecqqwer") ~= 0
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     for _, id in ipairs(player:getMark("_meecqqwer")) do
--       room:removePlayerMark(room:getPlayerById(id), "@@meecqqwer-round")
--     end
--     room:setPlayerMark(player, "_meecqqwer", 0)
--   end,
-- }
-- meecqqwer:addEffect(fk.RoundEnd, clean_spec)
-- -- meecqqwer:addEffect(fk.Death, clean_spec)

return meecqqwer

local ddwenqtsjens = fk.CreateSkill {
  name = "ddwenqtsjens",
}

Fk:loadTranslationTable{
  ["ddwenqtsjens"] = "傳箭",
  [":ddwenqtsjens"] = "額定抽牌旹,若伱抽牌數大于0,伱可發動.抽牌數-1,視爲伱對1其它角色使用探聽.末段,伱抽2,將1手牌幖記交予1角色.(幖記:此牌視爲殺且因花色具有效果.)", 

  ["#ddwenqtsjens-invoke"] = "傳箭 視爲對1角色使用探聽",
  ["#ddwenqtsjens-choose"] = "傳箭",
  ["@@ddwenqtsjens-inhand"] = "傳箭",

  ["$ddwenqtsjens1"] = "此是山寨裏之傳箭,少刻便有船來",
  ["$ddwenqtsjens1"] = "一支響箭穿雲霄",
  ["$ddwenqtsjens1"] = "箭令一起消息立去",

}
ddwenqtsjens:addEffect(fk.DrawNCards, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ddwenqtsjens.name) and data.n > 0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      skill_name = ddwenqtsjens.name,
      prompt = "#ddwenqtsjens-invoke",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)  --鎖
    data.n=data.n-1
    player.room:useVirtualCard("thooms_theec", nil, player, event:getCostData(self).tos, ddwenqtsjens.name, true)
  end,
})




ddwenqtsjens:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:usedSkillTimes(ddwenqtsjens.name, Player.HistoryTurn) > 0 and player.phase == Player.Finish
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    player:drawCards(2, ddwenqtsjens.name)
    local to, card =  room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      min_num = 0,
      max_num = 1,
      targets = room.alive_players,
      prompt = "#ddwenqtsjens-choose",
      skill_name = ddwenqtsjens.name,
      will_throw = true,
      cancelable = false,
    })
    if #card>0 then
        room:setCardMark(Fk:getCardById(card[1]),"@@ddwenqtsjens-inhand",1)
      if  #to>0 then
        room:moveCardTo(card, Player.Hand, to[1], fk.ReasonGive, ddwenqtsjens.name, nil, false, player.id)
      end
    end
  end,
})

ddwenqtsjens:addEffect("filter", {
  card_filter = function(self, to_select, player)
    return to_select:hasMark("@@ddwenqtsjens-inhand")
  end,
  view_as = function(self, player, to_select)
    local card = Fk:cloneCard("dzzjek__ssaet", to_select.suit, to_select.number)
    card.skillName = ddwenqtsjens.name
    return card
  end,
})

-- ddwenqtsjens:addEffect("targetmod", {
--   bypass_distances =  function(self, player, skill, card, to)
--     return  card and card:hasMark("@@ddwenqtsjens-inhand") and card.suit==Card.Heart
--   end,
--   bypass_times = function(self, player, skill, scope, card)
--     return  card and card:hasMark("@@ddwenqtsjens-inhand") and card.suit==Card.Spade
--   end,
-- })


-- ddwenqtsjens:addEffect(fk.PreCardUse, {  --PreCardUse moveCardTo
--   can_refresh = function (self, event, target, player, data)
--     return target == player  and data.card
--       and data.card:getMark("@@ddwenqtsjens-inhand")>0
--   end,
--   on_refresh = function (self, event, target, player, data)
--     if data.card.suit==Card.Spade then
--       data.extraUse = true
--     elseif data.card.suit==Card.Diamond then
--       data.disresponsiveList = table.simpleClone(player.room.players)
--     elseif data.card.suit==Card.Club then
      -- data.extra_data=data.extra_data or {}
      -- data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
--     end
--   end
-- })

return ddwenqtsjens

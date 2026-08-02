local dzyettssaamh = fk.CreateSkill({
  name = "dzyettssaamh",
})

Fk:loadTranslationTable{
  ["dzyettssaamh"] = "絕斬",
  [":dzyettssaamh"] = "伱起動旹伱可發動.伱預測牌堆頂x牌花色,亮出牌堆頂x牌,每預測成功此次傷害基數+1.將所亮出牌置入弃牌堆(x爲伱體力上限)",

  ["@dzyettssaamhRecord"] = "絕斬",
  ["#dzyettssaamh_filter"] = "絕斬",
  ["#dzyettssaamh-choose"] = "絕斬 預測 緟第 %arg 牌花色",

  ["$dzyettssaamh1"] = "矢贯坚石，劲冠三军！",
  ["$dzyettssaamh2"] = "吾虽年迈，箭矢犹锋！",
}



dzyettssaamh:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return
      target == player and
      player:hasSkill(dzyettssaamh.name) and
      data.card.trueName == "ssaet"
  end,
  on_use = function(self, event, target, player, data)
    ---@type string
    local skillName = dzyettssaamh.name
    local room = player.room

    local suits={ "log_spade", "log_club", "log_heart", "log_diamond" }
    local choices = {}
    local n = player.maxHp
    for i=1,n,1 do

    local choice = room:askToChoice(player, { choices = suits, skill_name = skillName ,prompt = "#dzyettssaamh-choose:::"..i,})
      table.insert(choices,choice)
    end


      local cards = room:getNCards(n)
      room:moveCardTo(cards, Card.Processing, nil, fk.ReasonPut, skillName, nil, true, player.id)
      data.additionalDamage = data.additionalDamage or 0
      for i, id in ipairs(cards) do
        if  Fk:getCardById(id):getSuitString(true) == choices[i] then
          room:setCardEmotion(id, "judgegood")
          data.additionalDamage = data.additionalDamage + 1
        else
          room:setCardEmotion(id, "judgebad")
        end
        room:delay(200)
      end
      room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, skillName)

  end,
})

-- ssaocqlioc:addEffect(fk.TargetSpecified, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return data.from  == player and player:hasSkill(ssaocqlioc.name) and
--       table.contains({ "ssaet"}, data.card.trueName)
--       and #table.filter(player.room:getOtherPlayers(player), function (p)
--         return player:inMyAttackRange(p) 
--       end) <3
--   end,
--   on_use = function(self, event, target, player, data)
--     data:setResponseTimes(data:getResponseTimes(to)+1, data.to)  --1?
--   end,
-- })

return dzyettssaamh

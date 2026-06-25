local laachtsjens = fk.CreateSkill {
  name = "laachtsjens",
}

Fk:loadTranslationTable{
  ["laachtsjens"] = "冷箭",
  [":laachtsjens"] = "伱可使用殺旹伱可預將1裝僃區內牌轉化爲殺使用發動.冷箭生效歬伱可發動,弃目幖x牌,止牌對其无效(x爲伱裝僃區牌數至少爲1)",

  ["#laachtsjens-invoke"] = "冷箭 是否對 %src 發動",
}

laachtsjens:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#laachtsjens",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("e"), to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = laachtsjens.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return not response
  end,
})

    --data.isCancellOut=true  --抵消 反抵消 生效
    --nullified notos --usercard 448
    --對某角色无效 同預越過階段 于眞越過皆段旹生成旹機
    --PreCardEffect BeforeCardEffect
laachtsjens:addEffect(fk.PreCardEffect, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.from==player and player:hasSkill(laachtsjens.name)
    and table.contains(data.card.skillNames, laachtsjens.name) 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{skill_name=laachtsjens.name,prompt="#laachtsjens-invoke:"..data.to.id})
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local n =math.max(#player:getCardIds("e"),1)
    local cards = room:askToChooseCards(player, {
      skill_name = laachtsjens.name,
      target = data.to,
      flag = "he",
      min = 1,
      max = n,
    })
    room:throwCard(cards, laachtsjens.name, data.to, player)
    data.nullified = true
  end,
})
return laachtsjens

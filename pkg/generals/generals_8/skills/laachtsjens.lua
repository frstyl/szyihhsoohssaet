local laachtsjens = fk.CreateSkill {
  name = "laachtsjens",
  tags = {Skill.Composite},
}

Fk:loadTranslationTable{
  ["laachtsjens"] = "冷箭",
  [":laachtsjens"] = "印牌:以伱裝僃區內1牌轉化起動｢殺｣｡伱指定｢殺｣目幖旹伱可發動,伱弃置目幖至多x牌,此牌對其无效(x爲伱裝僃區牌數+1)",

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
    --對某脚色无效 同預越過階段 于眞越過皆段旹生成旹機
    --PreCardEffect BeforeCardEffect
laachtsjens:addEffect(fk.TargetConfirming, {  --PreCardEffect
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.from==player and player:hasSkill(laachtsjens.name)
    -- and table.contains(data.card.skillNames, laachtsjens.name) 
    and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{skill_name=laachtsjens.name,prompt="#laachtsjens-invoke:"..data.to.id})
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- local n =math.max(#player:getCardIds("e"),1)
    n =#player:getCardIds("e")+1
    local cards = room:askToChooseCards(player, {
      skill_name = laachtsjens.name,
      target = data.to,
      flag = "he",
      min = 1,
      max = n,
    })
    room:throwCard(cards, laachtsjens.name, data.to, player)
    data:setNullified(data.to)
  end,
})
return laachtsjens

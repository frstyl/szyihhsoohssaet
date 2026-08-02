local qxemqddiach = fk.CreateSkill {
  name = "qxemqddiach",
}

Fk:loadTranslationTable{
["qxemqddiach"] = "炎上",
[":qxemqddiach"] = "伱起動牌旹,伱可選其它脚色A區域內有牌者發動,伱弃A區域內1牌,若与此次所起動牌同色,伱予A 1傷",

["#qxemqddiach"]="炎上 占卜",
["#qxemqddiach-choose"] = "炎上 選擇目幖与 %arg牌",
}

qxemqddiach:addEffect(fk.CardUsing, {
  -- anim_type = "masochism",
  can_trigger = function (self, event, target, player, data)
    return  target==player and player:hasSkill(qxemqddiach.name)
  end,
  on_cost= function (self, event, target, player, data)
    local targets = table.filter(player.room.alive_players, function(p)
      return not p:isAllNude()
    end)
    local  tos =player.room:askToChoosePlayers(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#qxemqddiach-ask",
      skill_name = qxemqddiach.name,
    })
    if #tos > 0 then
      event:setCostData(self, { tos = tos })
      return true
    end
  end,
  on_use= function (self, event, target, player, data)
    local to=event:getCostData(self).tos[1]
    if player.dead or to.dead or to:isAllNude() then return end
    local room=player.room
    local cid = room:askToChooseCard(player, { target = to, flag = "hej", skill_name = qxemqddiach.name })
    room:throwCard({cid}, qxemqddiach.name, to, player)
    if data.card.suit==Card.NoSuit then return end
    if to.dead then return end
    if Fk:getCardById(cid).suit==data.card.suit then
      room:damage{
        from = player,
        to = to,
        damage = 1,
        damageType=fk.FireDamage,
        skillName = qxemqddiach.name,
      }
    end
  end,
})

return qxemqddiach

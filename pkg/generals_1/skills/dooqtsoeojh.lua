local dooqtsoeojh = fk.CreateSkill{
  name = "dooqtsoeojh",
}

Fk:loadTranslationTable{
  ["dooqtsoeojh"] = "屠宰",
  [":dooqtsoeojh"] = "伱使用殺指定目幖後,伱可預弃目幖1牌發動.若其爲{紅/黑},伱{抽1/當轉殺次數上限+1}",

  ["#dooqtsoeojh-invoke"] = "屠宰 對 %src 發動",

  ["$dooqtsoeojh"] = "伱已是刀板上之肉捱宰之分",
}
local spec ={
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dooqtsoeojh.name) and
      data.card.trueName=="ssaet"
      and not data.to:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = dooqtsoeojh.name,
      prompt = "#dooqtsoeojh-invoke:"..data.to.id,
    }) then
      event:setCostData(self,{tos,{data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to=data.to
    local cid = room:askToChooseCard(player, { target = to, flag = "he", skill_name = dooqtsoeojh.name })
    -- to:showCards({cid})
    room:throwCard({cid}, dooqtsoeojh.name, to, player)

    if player.dead then return end
    card=Fk:getCardById(cid)
    if card.color==Card.Red then
      player:drawCards(1,dooqtsoeojh.name)
      -- room:recover{
      --   who = player,
      --   num = 1,
      --   recoverBy = player,
      --   skillName = dooqtsoeojh.name,
      -- }
    elseif card.color==Card.Black then
      room:addPlayerMark(player,"@ssaet_times-turn",1)
      room:addSkill("ssaet_times")
    end
  end,
}
dooqtsoeojh:addEffect(fk.TargetSpecified, spec)
dooqtsoeojh:addEffect(fk.Damage, spec)




return dooqtsoeojh

local qiucqljet = fk.CreateSkill {
  name = "qiucqljet",
}

Fk:loadTranslationTable{
["qiucqljet"] = "雄烈",
[":qiucqljet"] = "伱起動殺指定目幖後伱可發動.伱与其同旹打出0至多手牌,相數量相等,此殺對其傷害基數+1不可響應｡",  --謀奕猜拳眞行

["#qiucqljet-invoke"] = "雄烈 是否對%src 發動",
-- ["#qiucqljetResult"] = "雄烈: %from 于 %to 手牌數 %arg",
}

qiucqljet:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from ==player and player:hasSkill(qiucqljet.name) and data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = qiucqljet.name,
      prompt = "#qiucqljet-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local to =data.to

    local result = room:askToJointCards(player, {
      players = { player, to },
      min_num = 0,
      max_num = 999,
      cancelable = false,
      skill_name = qiucqljet.name,
      prompt = "#qiucqljet-discard",
      will_throw = true,
    })
    local moves = {}
    local dis={}
    for _, p in ipairs({ player, to }) do
      local cards = result[p] or {}
      dis[p]=#cards 
      if #cards > 0 then
        table.insert(moves, {
          ids = cards,
          from = p,
          toArea = Card.DiscardPile,
          moveReason = fk.ReasonDiscard,
          proposer = p,
          skillName = qiucqljet.name,
        })
      end
    end
    room:moveCards(table.unpack(moves))
    if result[player] ~= result[data.to]   then return end

    data.additionalDamage = (data.additionalDamage or 0) + 1
    data.disresponsive=true
  end,
})

return qiucqljet

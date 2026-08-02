local kaehkfes = fk.CreateSkill {
  name = "kaehkfes",
}

Fk:loadTranslationTable{
["kaehkfes"] = "解卦",
[":kaehkfes"] = "一脚色A占卜前,伱可發動.占卜牌生效後,若其花色爲{♠️/♥️/♣️/♦️},A{受到1雷傷/回1/隨機弃2/抽2}(效果皆无源)",

["#kaehkfes-invoke"]="解卦 對 %dest 發動  ",
}


kaehkfes:addEffect(fk.StartJudge, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kaehkfes.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = kaehkfes.name,
      prompt = "#kaehkfes-invoke::"..target.id,
    }) then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    data.extra_data=data.extra_data or  {}
    data.extra_data.kaehkfes=(data.extra_data.kaehkfes or 0) +1
  end,
})
kaehkfes:addEffect(fk.FinishJudge, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return target==player and not target.dead
  end,
  trigger_times = function(self, event, target, player, data)
      return data.extra_data and data.extra_data.kaehkfes or 0
  end,
  on_trigger = function(self, event, target, player, data)
    local suit =data.card.suit 
    if suit==Card.Spade then
      player.room:damage({
        from = nil,
        to = target,
        damage = 1,
        damageType = fk.ThunderDamage,
        skillName = kaehkfes.name,
      })
      return
    end

    if suit==Card.Heart then
      player.room:recover{
        who = target,
        num = 1,
        recoverBy = nil,
        skillName = kaehkfes.name,
      }
      return
    end

    if suit==Card.Diamond then
      target:drawCard(2,kaehkfes.name)
      return
    end
    if suit==Card.Club then
      -- player.room:throwCard(player.room:tableRandomPick(target:getCardIds("h"), 2), kaehkfes.name, target, nil)
      player.room:moveCards({
        ids = player.room:tableRandomPick(target:getCardIds("h"), 2),
        from = target,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonDiscard,
        proposer = nil,
        skillName = kaehkfes.name,
      })
      return
    end
    if suit==Card.NoSuit then
        player.room:addPlayerMark(target, MarkEnum.UncompulsoryInvalidity.."-turn", 1)
      return
    end
  end,
})



return kaehkfes

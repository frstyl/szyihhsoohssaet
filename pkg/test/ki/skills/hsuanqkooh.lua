local hsuanqkooh = fk.CreateSkill {
  name = "hsuanqkooh",
}

Fk:loadTranslationTable {
  ["hsuanqkooh"] = "喧鼓",
  [":hsuanqkooh"] = "其它脚色末段始旹,伱可預打出1{黑/紅}牌發動.其展示全部手牌,弃置其中｢{殺/閃}｣,若弃牌數大于2,伱流失1.",

  ["#hsuanqkooh-invoke"] = "喧鼓： %dest 末段, 伱可打出1黑牌,弃置其殺,或打出1紅牌,弃置其閃",
}

hsuanqkooh:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(hsuanqkooh.name) and target.phase == Player.Finish and
      not target.dead and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local card = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = hsuanqkooh.name,
      prompt = "#hsuanqkooh-invoke::"..target.id,
      cancelable = true,
      pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
        local c= Fk:getCardById(id)
      return not player:prohibitResponse(c) and  c.color~=Card.NoColor
    end)}),
    })
    if #card > 0 then
      event:setCostData(self, {tos = {target}, cards = card})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local card= Fk:getCardById(event:getCostData(self).cards[1])
    
    player.room:responseCard({
				card=card ,
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    if target.dead or target:isKongcheng() then return end
    target:showCards(target:getCardIds("h"))
    if target.dead or target:isKongcheng() then return end
    local name = card.color==Card.Red and "szjemh" or "ssaet"
    local cards = table.filter(target:getCardIds("h"), function(id)
      return Fk:getCardById(id).trueName == name and not target:prohibitDiscard(id)
    end)
    if #cards > 0 then
      room:throwCard(cards, hsuanqkooh.name, target, target)
    end
    if #cards>2 and not player.dead then
      player.room:loseHp(player,1,hsuanqkooh.na,e)
    end
  end,
})

return hsuanqkooh

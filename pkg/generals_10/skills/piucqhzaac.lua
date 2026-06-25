local piucqhzaac = fk.CreateSkill{
  name = "piucqhzaac",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["piucqhzaac"] = "風行",
[":piucqhzaac"] = "鎖定.伱主段弃段歬必發,伱越過之.伱失去牌旹,若伱手牌數小于體力上限,必發.伱抽1",

["$piucqhzaac1"] = "足馭風雷一瞬千里",
["$piucqhzaac2"] = "風行奇術,起",
}


piucqhzaac:addEffect(fk.EventPhaseChanging, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(piucqhzaac.name) 
    and not data.skipped 
    and (data.phase == Player.Draw or data.phase == Player.Discard) 
  end,
  on_use = function(self, event, target, player, data)
    data.skipped = true
  end,
})

piucqhzaac:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not (player:hasSkill(piucqhzaac.name) 
    and #player:getCardIds("h")< player.maxHp) then 
      return false 
    end
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if  (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)  then
            return true
          end
        end
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1,piucqhzaac.name)
  end,
})


return piucqhzaac

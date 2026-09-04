local jyecqhzooj = fk.CreateSkill({
  name = "jyecqhzooj",
})
Fk:loadTranslationTable{
  ["jyecqhzooj"] = "營回",  --䘙生 養生
  [":jyecqhzooj"] = "伱失去手牌後,伱可發動｡伱抽1,展示全部手牌,若有不同色牌,此技能失效至下次觸發旹機", 

  ["#jyecqhzooj-invoke"] = "營回  交予 %src 牌",
  ["#jyecqhzooj-choose"] = "營回  選擇發動目幖",

  ["$jyecqhzooj1"] = "吾大軍援糧何在",
  -- ["$jyecqhzooj2"] = "營回五十六縣皆爲我土",
}

jyecqhzooj:addEffect(fk.AfterCardsMove, {  --褈復檢測受歬技能干擾
  anim_type = "drawcard",

  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(jyecqhzooj.name,true) then return end
    if not self.isEffectable(player) then
      room:validateSkill(player,jyecqhzooj.name, "",jyecqhzooj.name)
      return
    end

    for _, move in ipairs(data) do
      if move.from==player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerHand then
            if  not (move.to==player and move.toArea==Card.PlayerHand) then return true end
          end
        end
      end
    end

  end,
	on_use = function(self, event, target, player, data)
    local room=player.room
    player:drawCards(1,jyecqhzooj.name)

    local cards = player:getCardIds("h")
    if player.dead then return end
    if #cards > 0 then
      player:showCards(cards)
    end
    if player:isKongcheng() or 
      table.every(cards, function(id)
        return Fk:getCardById(id).color == Fk:getCardById(cards[1]).color
      end)
    then
      return
    else
      player.room:invalidateSkill(player,jyecqhzooj.name, "",jyecqhzooj.name)
    end
  end,
})


return jyecqhzooj

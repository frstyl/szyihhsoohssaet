


local louchloak= fk.CreateSkill({
  name = "louchloak",
})

Fk:loadTranslationTable{
["louchloak"] = "籠絡",
[":louchloak"] = "當伱成爲「殺」目幖旹,你可亮出牌堆頂2牌,分配之",

["#louchloak-give"] = "籠絡 分配牌",

["$louchloak1"] = "小心心意 不成敬意",
["$louchloak2"] = "好漢 且慢",
}

louchloak:addEffect(fk.TargetConfirming, {
  anim_type = "defensive",
  -- prompt = "#louchloak",
	can_trigger = function(self, event, target, player, data)
		return target==player  and player:hasSkill(louchloak.name) and data.card.trueName=="ssaet" 
	end,
	on_use = function(self, event, target, player, data)  --jujkeir
    local room = player.room
    local ids = room:getNCards(2)
    while not player.dead do
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 1,
        min_card_num = 1,
        max_card_num = #ids,
        targets = room.alive_players,
        pattern = tostring(Exppattern{ id = ids }),
        skill_name = louchloak.name,
        prompt = "#louchloak-give",
        cancelable = true,
        expand_pile = ids,
      })
      if #tos > 0 and #cards > 0 then
        for _, id in ipairs(cards) do
          table.removeOne(ids, id)
        end
        room:moveCardTo(cards, Card.PlayerHand, tos[1], fk.ReasonGive, louchloak.name, nil, false, player)
        if #ids == 0 then break end
      else
        room:moveCardTo(ids, Card.PlayerHand, player, fk.ReasonGive, louchloak.name, nil, false, player)
        return
      end
    end
  end,
})


return louchloak

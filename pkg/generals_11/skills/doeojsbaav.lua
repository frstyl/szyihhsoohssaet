local doeojsbaav = fk.CreateSkill {
  name = "doeojsbaav",
}

Fk:loadTranslationTable{
  ["doeojsbaav"] = "代庖",
  [":doeojsbaav"] = "一其它角色額定抽牌歬,伱可弃a{紅/黑}牌發動.其抽牌數{+/-}a,若伱弃1紅,伱抽1.(a至多爲其抽牌數)", 

  ["#doeojsbaav-invoke"] = "%src 將抽%arg牌 伱可弃紅令其多出 或弃黑令其少抽",

  ["$doeojsbaav1"] = "白銀在此將了去",  --
}
doeojsbaav:addEffect(fk.DrawNCards, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(doeojsbaav.name) and target~=player
    end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
      local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "doeojsbaav_active",
      prompt = "#doeojsbaav-invoke:"..target.id..":"..data.n,
      cancelable = true,
      skip = true,  --不執行
      extra_data = {  --koans
        n = data.n,
      },
    })
    if yes and dat then
      event:setCostData(self, {cards = dat.cards,})
        return true
    end

  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local color=Fk:getCardById(event:getCostData(self).cards[1]).color
    local n=#event:getCostData(self).cards
    if color == Card.Black then
      room:throwCard(event:getCostData(self).cards, doeojsbaav.name, player, player)
      data.n = data.n -n
    else
      room:throwCard(event:getCostData(self).cards, doeojsbaav.name, player, player)
      data.n = data.n +n
      if n ==1 then
        player:drawCards(1, doeojsbaav.name)
      end
    end
  end,
})


return doeojsbaav

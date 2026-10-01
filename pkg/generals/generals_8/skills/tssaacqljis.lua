local tssaacqljis = fk.CreateSkill{
  name = "tssaacqljis", 
  tags = { Skill.Compulsory },
}


Fk:loadTranslationTable{
  ["tssaacqljis"] = "爭利",
  [":tssaacqljis"] = "伱始段/末段始旹,伱可与1其它腳色賭鬥發動,若伱點數贏伱取得雙方賭鬥牌",

  ["#tssaacqljis-choose"] = "設擂 選擇賭鬥目幖",

  ["$tssaacqljis2"] = "敢有出來和我爭利物的麼",
  ["$tssaacqljis1"] = "四百座軍州，七千餘縣治，好事香官恭敬聖帝，都助將利物來",
}


tssaacqljis:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tssaacqljis.name) 
    and (player.phase == Player.Finish or player.phase == Player.Start)
    and not player:isKongcheng()
    and
      table.find(player.room.alive_players, function(p)
        return player:canPindian(p)
      end)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room.alive_players, function(p)
      return player:canPindian(p)
    end)
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      skill_name = tssaacqljis.name,
      prompt = "#tssaacqljis-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local pindian = player:pindian({to}, tssaacqljis.name)

    if pindian.results[target].winner == player and not player.dead then
      local to_get = {}
      local cid = pindian.fromCard and pindian.fromCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insert(to_get, cid)
      end
      local toCard = pindian.results[target].toCard
      cid = toCard and toCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insertIfNeed(to_get, cid)
      end
      if #to_get > 0  then
        room:obtainCard(player, to_get, true, fk.ReasonPrey, player, tssaacqljis.name)
      end
    end
  end,
})

return tssaacqljis

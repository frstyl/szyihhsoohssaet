local dzoeocsdoo = fk.CreateSkill {
  name = "dzoeocsdoo",
}

Fk:loadTranslationTable{
  ["dzoeocsdoo"] = "贈圖",
  [":dzoeocsdoo"] = "一腳色A預段始旹,(若伱有牌)伱可發動,伱褈鑄1至多牌,交与A1手牌(若爲伱則越過)令其1轉內起動牌无視距離",
  -- [":dzoeocsdoo"] = "伱額定抽牌後,伱可分配一至多張牌發動,伱抽2倍分配花色牌數,1段內伱不可起動牌与被分配牌花色褈合者",

  ["#dzoeocsdoo-invoke"] = "贈圖 對 %src 發動",



  ["$dzoeocsdoo1"] = "治军严谨，方得精锐之师。",
  ["$dzoeocsdoo2"] = "精兵当严于律己，束身自修。",
}


dzoeocsdoo:addEffect(fk.EventPhaseStart, {
  anim_type="drawcard",
  can_trigger = function(self, event, target, player, data)
    return 
    target.phase==Player.Start
    and
     player:hasSkill(dzoeocsdoo.name)
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = dzoeocsdoo.name,
      prompt = "#dzoeocsdoo-invoke:"..target.id,
    }) then
      event:setCostData(self, {tos={target}})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards={}
    local yes, dat = room:askToUseActiveSkill(player, {  
      skill_name = "gwisliac_active",
      -- prompt = "#gwisliac_active",
      cancelable = false,
      skip = true,  --不執行
    })
    if yes then
      cards=dat.cards
    else
      return
    end

    room:recastCard(cards, player, dzoeocsdoo.name)
    if player.dead or player:isKongcheng() then return end
    local to, card =  room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      prompt = "#dzoeocsdoo-give",
      skill_name = dzoeocsdoo.name,
      will_throw = false,
      cancelable = false,
    })
    if to[1]  == player then
      room:addPlayerMark(player,"bypass_distances-turn",1)
      return
    else
      room:moveCardTo(card, Player.Hand, to[1], fk.ReasonGive, dzoeocsdoo.name, nil, false, player)
      room:addPlayerMark(to[1],"bypass_distances-turn",1)
    end

  end,
})


return dzoeocsdoo

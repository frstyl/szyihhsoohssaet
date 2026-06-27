local szuoqquns = fk.CreateSkill {
  name = "szuoqquns",
}

Fk:loadTranslationTable{
  ["szuoqquns"] = "輸運",
  [":szuoqquns"] = "➀補段終旹,若伱无資,伱可發動.伱改爲亮出牌堆頂x牌,伱選其中任意數量類花不全同者各1置于伱武將牌上,稱爲資,餘者置入弃牌堆➁一角色A主段始旹,若伱有資伱可發動.當段內,該A使用打出牌旹,若其類或花与第一張資相同,A獲取該資.",  --清理?

  ["#szuoqquns-choose"] = "輸運 選任意數量類花不全同者 自由排序",
  ["#szuoqquns-give"] = "輸運 %src主段始,是否輸糧",
  ["@@szuoqquns-phase"] = "輸運",
  ["szuoqquns_tsji"] = "資",

  ["$szuoqquns1"] = "糧艸器械䀆在掌握之中",
  ["$szuoqquns2"] = "若何輸運吾自有分寸",
  ["$szuoqquns3"] = "大軍未動糧艸先行",
}

Fk:addPoxiMethod{
  name = "szuoqquns",
  card_filter = function(to_select, selected, data)
    if table.contains(data[2], to_select) then return true end
    local suit = Fk:getCardById(to_select).suit
    local typ = Fk:getCardById(to_select).type
    return table.every(data[2], function (id)
      return Fk:getCardById(id).suit ~= suit 
      or Fk:getCardById(id).type ~= typ
    end)
  end,
  feasible = Util.TrueFunc,
}

szuoqquns:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(szuoqquns.name) and player.phase == Player.Draw 
    and #player:getPile("szuoqquns_tsji")==0
  end,
  on_use = function(self, event, target, player, data)
    -- data.phase_end = true
    local room = player.room
    local n =player.maxHp+player:getLostHp()
    local cards = room:getNCards(n)
    room:moveCards({
      ids = cards,
      toArea = Card.Processing,
      moveReason = fk.ReasonJustMove,
      skillName = szuoqquns.name,
      proposer = player.id,
    })
    local get = {}
    for _, id in ipairs(cards) do
      local suit = Fk:getCardById(id).suit
      if table.every(get, function (id2)
        return Fk:getCardById(id2).suit ~= suit
      end) then
        table.insert(get, id)
      end
    end
    get = room:askToArrangeCards(player, {
      skill_name = szuoqquns.name,
      card_map = cards,
      prompt = "#szuoqquns-choose",
      free_arrange = false,
      box_size = 0,
      max_limit = {n, n},
      min_limit = {0, 0},
      poxi_type = "szuoqquns",
      default_choice = {{}, {}},
    })[2]
    if #get > 0 then
      player:addToPile("szuoqquns_tsji", get, true, szuoqquns.name)
      -- room:obtainCard(player, get, true, fk.ReasonPrey, player, szuoqquns.name)
    end
    room:cleanProcessingArea(cards)
  end,
})

szuoqquns:addEffect(fk.EventPhaseStart, {  --TurnStart ?
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target.phase==Player.Play and player:hasSkill(szuoqquns.name) and #player:getPile("szuoqquns_tsji") > 0 
  end,
  on_cost= function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=szuoqquns.name,
      prompt="#szuoqquns-give:"..target.id
    })
  end,
  on_use = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@@szuoqquns-phase",target.id)
  end,
})


local spec = {
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    player.room:obtainCard(target, player:getPile("szuoqquns_tsji")[1], true, fk.ReasonPrey, target, szuoqquns.name)
  end,
}

szuoqquns:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:getMark("@@szuoqquns-phase") ==target.id and  player:getPile("szuoqquns_tsji")[1]
    and (data.card.tyep== Fk:getCardById(player:getPile("szuoqquns_tsji")[1]).type or data.card.suit==Fk:getCardById(player:getPile("szuoqquns_tsji")[1]).suit )
  end,
  on_trigger = spec.on_trigger
})

szuoqquns:addEffect(fk.PreCardRespond, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:getMark("@@szuoqquns-phase") ==target.id and  player:getPile("szuoqquns_tsji")[1]
    and (data.card.tyep== Fk:getCardById(player:getPile("szuoqquns_tsji")[1]).type or data.card.suit==Fk:getCardById(player:getPile("szuoqquns_tsji")[1]).suit )
  end,
  on_trigger = spec.on_trigger
})

return szuoqquns

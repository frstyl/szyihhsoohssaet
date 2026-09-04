Fk:loadTranslationTable{
  ["lyithzoeoc"] = "律恆",--訾程
  [":lyithzoeoc"] = "伱失去牌後,必發,伱將其置于伱武將牌上.轉終,伱廢置全部律恆牌抽等量牌",

  ["#thoucqliak-active"] = "律恆  先選效果,否則緟置選牌 默認傷害",

  ["#thoucqliak-discard"] = "律恆 ",

  ["lyithzoeoc_liak"] = "程",
  -- ["damage"] = "致傷 ",
}

local lyithzoeoc = fk.CreateSkill{
  name = "lyithzoeoc",
  tags = { Skill.Compulsory },
}

lyithzoeoc:addEffect(fk.AfterCardsMove, {
  derived_piles = "lyithzoeoc_liak",
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(lyithzoeoc.name)  then return false end
    local ids={}
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            table.insert(tids,info.cardId)
          end
        end
      end
    end
    ids = table.filter(ids, function (id)  --迻動防止 失去是操作?結果
      return not table.contains(player:getCardIds("he"), id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if #ids>0 then
      event:setCostData(self, {cards=t})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
      player:addToPile("lyithzoeoc_liak", event:getCostData(self).cards, true, lyithzoeoc.name, player)
  end,
})

lyithzoeoc:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
      return #player:getPile("lyithzoeoc_liak")>0 and player:hasSkill(lyithzoeoc.name)
  end,
  on_use = function(self, event, target, player, data)
    local n= #player:getPile("lyithzoeoc_liak")
    player.room:moveCardTo(player:getPile("lyithzoeoc_liak"), Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, lyithzoeoc.name, nil, true, player)
    if player.dead then return end
    player:drawCards(n,lyithzoeoc.name)
  end,
})

return lyithzoeoc

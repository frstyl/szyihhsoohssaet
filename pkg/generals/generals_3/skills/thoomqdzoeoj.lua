local thoeomqliak = fk.CreateSkill({
  name = "thoeomqliak",
  -- tags = {Skill.Compulsory},
  tags = {Skill.Composite},
})

Skill.Composite="Composite"

Fk:loadTranslationTable{
  ["thoeomqliak"] = "貪略",
  [":thoeomqliak"] = "伱撤段始旹,伱可發動,伱抽x+1｡➁伱牌因弃置進入弃牌堆後,伱可發動,伱將其1至多張排列于牌堆頂",  --伱可流失1且1段存牌數+2*x(x爲伱已損體力數)

  -- ["#thoeomqliak-loseHp"] = "貪略：是否流失體力",
  ["#thoeomqliak-choose"] = "貪略：排列牌置于牌堆頂",

  -- ["$thoeomqliak1"] = "皓月如晝共椉歡爭忍歸來",
  -- ["$thoeomqliak2"] = "瓊林玉殿朝喧弦管暮列笙琶",
}


thoeomqliak:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoeomqliak.name) and player.phase == Player.Discard 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local drawers = {}
    player:drawCards(1+player:getLostHp(),thoeomqliak.name)

    -- if room:askToSkillInvoke(player, { skill_name = thoeomqliak.name ,prompt="#thoeomqliak-loseHp"}) then
    --   room:loseHp(player,1,thoeomqliak.name,player)
    --   room:addPlayerMark(player, MarkEnum.AddMaxCardsInTurn, 2*player:getLostHp())
    --   -- room:addPlayerMark(player, MarkEnum.AddMaxCards, 1)
    -- end
  end,
})

thoeomqliak:addEffect(fk.AfterCardsMove, {

  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(thoeomqliak.name)  then return end   --多次?
    local ids={}

      for _, move in ipairs(data) do
        if move.from==player and  move.moveReason == fk.ReasonDiscard and move.toArea==Card.DiscardPile then
          for _, info in ipairs(move.moveInfo) do
            if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
              table.insert(ids,info.cardId)
            end
          end
        end
      end

    

      ids = table.filter(ids, function (id)
        return table.contains(player.room.discard_pile, id)
      end)
      ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
      if #ids > 0 then
        event:setCostData(self, {cards = ids})
        return true
      end


  end,

  on_use= function(self, event, target, player, data)
    local room=player.room
    -- local cards=room:askToChooseCards(player, {
    --     target = player,
    --     min = 1,
    --     max = 999,
    --     flag = { card_data = {{ thoeomqliak.name, event:getCostData(self).cards }} },  --可見
    --     skill_name = thoeomqliak.name,
    --     prompt = "#thoeomqliak-choose",
    --   })

    local top = room:askToGuanxing(player, {
      skill_name = thoeomqliak.name,
      cards = event:getCostData(self).cards,
      top_limit={1,999},
      bottom_limit = {0, 999},
      prompt = "#thoeomqliak-choose",
      skip=true,
      -- title= thoeomqliak.name,
      area_names =="#thoeomqliak-choose",
    }).top
    top = table.reverse(top)
      room:moveCardTo(top, Card.DrawPile, nil, fk.ReasonPut, thoeomqliak.name, nil, true )
  end,
})

return thoeomqliak

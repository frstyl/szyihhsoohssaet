
local dzzjenqhqyen_give = fk.CreateSkill {
  name = "dzzjenqhqyen_give&",
}

Fk:loadTranslationTable{
  ["dzzjenqhqyen_give&"] = "嬋娟",
  [":dzzjenqhqyen_give&"] = "➀其它角色1<font color='red'>♥</font>牌A因弃置置入判定進入弃牌堆旹,伱可發動,伱抽1,選擇是否弃1牌將A交与一角色.➁伱<font color='red'>♥</font>牌A因弃置置入判定進入弃牌堆旹伱可選1其它角色發動.將此牌交予該角色",

  ["#dzzjenqhqyen_give-invoke&"] = "嬋娟 是否發動",
  ["#dzzjenqhqyen_give-choose&"] = "嬋娟 選擇所得牌 所弃牌 得牌角色",

  -- ["$dzzjenqhqyen_give1"] = "旅人多西望， 客雁難南歬",
  -- ["$dzzjenqhqyen_give2"] = "霜露結瑤華， 煙波勞玉指",
}

dzzjenqhqyen_give:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    -- if not player:hasSkill(dzzjenqhqyen_give.name) then return end

    local ids={}


      for _, move in ipairs(data) do
        if table.contains({fk.ReasonDiscard,fk.ReasonJudge,fk.ReasonPut,fk.ReasonPutIntoDiscardPile}, move.moveReason )  
          and move.from == player 
          and move.toArea == Card.DiscardPile
        then
          for _, info in ipairs(move.moveInfo) do
            if  Fk:getCardById(info.cardId).suit == Card.Heart then
            -- and  (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip) 
              table.insertIfNeed(ids, info.cardId)
            end
          end
        end
      end

      --  if #ids ==0 then return end
    ids = table.filter(ids, function (id)
      return table.contains(player.room.discard_pile, id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if  #ids > 0 then
      event:setCostData(self, {ids = ids})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:askToYiji(player,{
      targets=player.room:getOtherPlayers(player),
      cards=event:getCostData(self).ids,
      expand_pile=event:getCostData(self).ids,
      skip=false,
    })
  end,
})

return dzzjenqhqyen_give


local thoaqtoav = fk.CreateSkill {
  name = "thoaqtoav",
}

Fk:loadTranslationTable{
  ["thoaqtoav"] = "拖刀",
  [":thoaqtoav"] = "牌被弃置後,伱可預起動其1發動｡",--无視次數

  ["#thoaqtoav-invoke"] = "拖刀 是否發動",
  ["#thoaqtoav-choose"] = "拖刀 分配牌",

  ["$thoaqtoav1"] = "旅人多西望， 客雁難南歬",
  ["$thoaqtoav2"] = "霜露結瑤華， 煙波勞玉指",
}


thoaqtoav:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(thoaqtoav.name) then return end

    local ids={}


      for _, move in ipairs(data) do
        if 
        -- move.proposer==player
          -- and  
          move.moveReason==fk.ReasonDiscard
        then
          for _, info in ipairs(move.moveInfo) do
            table.insertIfNeed(ids, info.cardId)
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
  on_cost = function(self, event, target, player, data)
    local cards=event:getCostData(self).ids
      local use = player.room:askToUseRealCard(player, {
        skill_name = thoaqtoav.name,
        prompt = "#thoaqtoav-invoke",
        pattern = tostring(Exppattern{ id = cards }),
        cancelable = true,
        extra_data = {
          expand_pile = cards,
          extraUse=false,
          bypass_times=false,
        },
        skip = true,
      })
      if use then
      event:setCostData(self, {use=use})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)  --可以不給?
    player.room:useCard(event:getCostData(self).use)
  end,
})

return thoaqtoav

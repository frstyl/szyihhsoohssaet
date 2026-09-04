local hzoojqssaok = fk.CreateSkill {
  name = "hzoojqssaok",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["hzoojqssaok"] = "回搠",
[":hzoojqssaok"] = "一腳色轉終旹无限次,伱可起動弃牌堆1轉內因打出進入者發動｡",


}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoojqssaok:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(hzoojqssaok.name) then
      local room=player.room
      local ids={}
      room.logic:getEventsOfScope(GameEvent.MoveCards, 1, function (e)  --順序
      for _, move in ipairs(e.data) do
        if move.moveReason==fk.ReasonResponse then  --弃過又被用?
          for _, info in ipairs(move.moveInfo) do
            if  room:getCardArea(info.cardId) == Card.DiscardPile then
              table.insertIfNeed(ids,info.cardId)
            end
          end
        else
          for _, info in ipairs(move.moveInfo) do
            if  room:getCardArea(info.cardId) == Card.DiscardPile then  --因非打出進入弃牌堆
              table.removeOne(ids,info.cardId)
            end
          end
        end
      end
      end, Player.HistoryTurn)
      if #ids>0 then
        event:setCostData(self, {ids = ids})
        return true
      end
    end
    end,
  trigger_times = function(self, event, target, player, data)
    return 999
  end,
  on_cost = function(self, event, target, player, data)
    local cards=event:getCostData(self).ids
      local use = player.room:askToUseRealCard(player, {
        skill_name = hzoojqssaok.name,
        prompt = "#hzoojqssaok-invoke",
        pattern = tostring(Exppattern{ id = cards }),
        cancelable = true,
        extra_data = {
          expand_pile = cards,
          extraUse=false,
          bypass_times=false,
          bypass_distances=false,
        },
        skip = true,
      })
      if use then
      event:setCostData(self, {extra_data=use,cards={use.card}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)  --可以不給?
    player.room:useCard(event:getCostData(self).extra_data)
  end,
  })
return hzoojqssaok

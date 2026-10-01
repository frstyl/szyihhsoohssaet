local poakloamh = fk.CreateSkill {
  name = "poakloamh",
}

Fk:loadTranslationTable{
  ["poakloamh"] = "博覽",
  [":poakloamh"] = "伱轉終,伱可發動,伱取得弃牌堆x牌,于1輪內進入且花与類不全同",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- Fk:addPoxiMethod{
--   name = "szuoqquns",
--   card_filter = function(to_select, selected, data)
--     if table.contains(data[2], to_select) then return true end
--     local suit = Fk:getCardById(to_select).suit
--     local typ = S.getCardTypeByName(Fk:getCardById(to_select))
--     return table.every(data[2], function (id)
--       return Fk:getCardById(id).suit ~= suit 
--       or  S.getCardTypeByName(Fk:getCardById(id)) ~= typ
--     end)
--   end,
--   feasible = Util.TrueFunc,
-- }

poakloamh:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(poakloamh.name)
    and #player.room.discard_pile>0
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
      local data = {
        skillName =  poakloamh.name,
        prompt = "doavqthoav_poxi",
      }
      local ids={}
      if (room:getBanner("RoundCount") or 0)<2 then 
        ids = room.discard_pile
      else
        room.logic:getEventsOfScope(GameEvent.MoveCards, 1, function (e)  --使用過且在弃牌堆
            for _, move in ipairs(e.data) do
              if move.toArea == Card.DiscardPile then
                for _, info in ipairs(move.moveInfo) do
                  if table.contains(room.discard_pile, info.cardId) then
                    table.insertIfNeed(ids, info.cardId)
                  end
                end
              end
            end
        end, Player.HistoryRound)
      end
      if #ids==0 then return end

      local tobe={}
      for _, id in ipairs(ids) do
        local card=Fk:getCardById(id)
        -- local k=tostring(card.suit ).."-"..tostring( S.getCardTypeByName(card.trueName))
        local k= ( S.getCardTypeByName(card.trueName)-1)*5 +(card.suit )
        tobe[k]=tobe[k] or {}
        table.insert(tobe[k],id)
      end

      local card_data={}
      for k,v in pairs(tobe) do
        table.insert(card_data,{k,v})
      end

    local cards = room:askToPoxi(player, {
      poxi_type ="doavqthoav_poxi",
      data = card_data,
      extra_data = data,
      cancelable = true,
      extra_data={
        min=1,
        max=math.max(1,player.hp),
      }
    })
      player.room:obtainCard(player, cards, true, fk.ReasonPrey, player, poakloamh.name)

  end,
})


return poakloamh

local doavqthoav = fk.CreateSkill{
  name = "doavqthoav",
}


Fk:loadTranslationTable{
["doavqthoav"] = "濤洮",
[":doavqthoav"] = "牌不因弃置不由処理區進入弃牌堆後,伱可發動,伱取得之｡",


["#doavqthoav-invoke"] = "濤洮 獲得牌",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

doavqthoav:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    if not player:hasSkill(doavqthoav.name)  then return   end
    local ids={}
      for _, move in ipairs(data) do
        if move.moveReason~=fk.ReasonDiscard and move.toArea == Card.DiscardPile   then
          for _, info in ipairs(move.moveInfo) do
            if  info.fromArea~=Card.Processing then
              table.insert(ids, info.cardId)
            end
          end
        end
      end

    ids = table.filter(ids, function (id)
      return table.contains(player.room.discard_pile, id)
    end)
    ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
    if #ids > 0 then

      event:setCostData(self, {ids = ids})
      return true
    end
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToViewCardsAndChoice(player, {  --askToChooseCardsAndChoice askToCards
        cards = event:getCostData(self).ids,
        choices = { "OK", "Cancel" },
        skill_name = doavqthoav.name,
        prompt = "#doavqthoav-invoke"
      }) == "OK" 
    then
        return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- local ids = table.simpleClone(event:getCostData(self).ids)
    local ids  = table.filter(event:getCostData(self).ids, function (id)
      return table.contains(player.room.discard_pile, id)
    end)
    player.room:moveCardTo(ids, Card.PlayerHand, player, fk.ReasonPrey, doavqthoav.name, nil, true, player)
  end,
})
-- doavqthoav:addEffect(fk.AfterCardsMove, {
--   anim_type = "drawcard",
--   trigger_times = function (self, event, target, player, data)
--     if not player:hasSkill(doavqthoav.name)  then return 0  end
--     local n = event:getCostData(self)
--     if  n~=nil and n.n then return n.n else n = 0 end
--       for _, move in ipairs(data) do
--         if move.toArea == Card.DrawPile  then
--           for _, info in ipairs(move.moveInfo) do
--             if table.contains({Card.Void,  Card.PlayerSpecial}, info.fromArea) then
--               n=n+1
--             end
--           end
--         end
--       end
--     if n>0 then
--       event:setCostData(self,{n=n})
--     end
--       return n
--   end,
--   can_trigger = function(self, event, target, player, data)
--     return player:hasSkill(doavqthoav.name)
--   end,
--   on_use = function(self, event, target, player, data)
--     player:drawCards(1,doavqthoav.name)
--   end,
-- })

return doavqthoav

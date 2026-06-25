local neemsneems = fk.CreateSkill {
  name = "neemsneems",
}

Fk:loadTranslationTable{

["neemsneems"] = "念念",
[":neemsneems"] = "任一轉終旹,若弃牌堆有牌于當轉內因伱使用打出進入,且當次使用未致傷療,伱可選其1牌發動｡伱獲得之.",--<br/>"..

["#neemsneems-ask"] = "念念 選擇1獲得",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

neemsneems:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(neemsneems.name)  then return end
      local room = player.room
      local cards = {}
      room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
        local use=e.data
          if use.from==player and not use.card:isVirtual() and (use.damageDealt==nil )  and room:getCardArea(use.card.id) == Card.DiscardPile then --記錄virtual id
              table.insertIfNeed(cards, use.card.id)
          end
      end, Player.HistoryTurn)

      room.logic:getEventsOfScope(GameEvent.RespondCard, 1, function (e)
        local use=e.data
          if use.from==player and not use.card:isVirtual()  and room:getCardArea(use.card.id) == Card.DiscardPile then --記錄virtual id
              table.insertIfNeed(cards, use.card.id)
          end
      end, Player.HistoryTurn)

      room.logic:getEventsOfScope(GameEvent.PlayCard, 1, function (e)  --playCard
          local use=e.data
          if use.from==player then

            for _, id in ipairs(use.card_ids) do
              if room:getCardArea(id) == Card.DiscardPile then
                table.insertIfNeed(cards, id)
              end
            end
          end
      end, Player.HistoryTurn)

      room.logic:getEventsOfScope(GameEvent.Recover, 1, function (e)
        local dat=e.data
          if dat.recoverBy==player and dat.card and not dat.card:isVirtual()  and not dat.prevented  then 
            table.removeOne(cards, dat.card.id)  --直接?
          end
      end, Player.HistoryTurn)
            -- if #cards == 0 then return false end

      if #cards > 0 then
        event:setCostData(self, {cards = cards})
        return true
      end
  end,
  on_cost = function(self, event, target, player, data)
      local cards, choice = player.room:askToChooseCardsAndChoice(player, {
        cards = event:getCostData(self).cards,
        min_num = 0,
        max_num = 1,
        skill_name = neemsneems.name,
        prompt = "#neemsneems-ask",
        cancel_choices = {"Cancel"}
      })
      if choice=="Cancel" or #cards==0 then return end
      event:setCostData(self, { cards = cards})
      return true
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local cards = table.simpleClone(event:getCostData(self).cards)
    -- player.room:moveCardTo(event:getCostData(self).ids, Card.PlayerHand, player, fk.ReasonPrey, neemsneems.name, nil, true, player)
    room:obtainCard(player, cards, true, fk.ReasonPrey, player, neemsneems.name)  --置入PutInt?? ReasonJustMove? 


  end,
})



return neemsneems

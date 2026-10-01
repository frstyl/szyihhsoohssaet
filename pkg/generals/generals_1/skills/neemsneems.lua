local neemsneems = fk.CreateSkill {
  name = "neemsneems",
}

Fk:loadTranslationTable{

["neemsneems"] = "念念",
[":neemsneems"] = "一轉終旹,若伱轉內層起動牌,,伱可選其弃牌堆內1牌發動,其于轉內被元牌起動且未致傷療 ｡伱將其交与1腳色之.",--<br/>"..

["#neemsneems-ask"] = "念念 選擇1取得",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

neemsneems:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(neemsneems.name)  then return end
      local room = player.room
      local used=false
      local cards = {}
      room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)  --使用過且在弃牌堆
        local use=e.data
        if use.from==player then used=true end
        if  not use.card:isVirtual() and use.card.name==Fk:getCardById(use.card.id).name
        and (use.damageDealt==nil )  
        and room:getCardArea(use.card.id) == Card.DiscardPile then --記錄virtual id
              table.insert(cards, use.card.id)  --多次起動
        end
      end, Player.HistoryTurn)

      -- room.logic:getEventsOfScope(GameEvent.RespondCard, 1, function (e)
      --   local use=e.data
      --     if use.from==player and not use.card:isVirtual()  and room:getCardArea(use.card.id) == Card.DiscardPile then --記錄virtual id
      --         table.insertIfNeed(cards, use.card.id)
      --     end
      -- end, Player.HistoryTurn)

      -- room.logic:getEventsOfScope(GameEvent.PlayCard, 1, function (e)  --playCard
      --     local use=e.data
      --     if use.from==player then

      --       for _, id in ipairs(use.card_ids) do
      --         if room:getCardArea(id) == Card.DiscardPile then
      --           table.insertIfNeed(cards, id)
      --         end
      --       end
      --     end
      -- end, Player.HistoryTurn)
      if not used then return end
      room.logic:getEventsOfScope(GameEvent.Recover, 1, function (e)
        local dat=e.data
          if dat.recoverBy==player and dat.card  and not dat.prevented  then 
            table.removeOne(cards, dat.card.id)  --直接?
          end
      end, Player.HistoryTurn)
            -- if #cards == 0 then return false end

      if #cards > 0 then

        event:setCostData(self, {ids = cards})
        return true
      end
  end,
  on_cost = function(self, event, target, player, data)
    local ids= event:getCostData(self).ids
      -- local cards, choice = player.room:askToChooseCardsAndChoice(player, {
      --   cards = ids,
      --   min_num = 0,
      --   max_num = 1,
      --   skill_name = neemsneems.name,
      --   prompt = "#neemsneems-ask",
      --   cancel_choices = {"Cancel"}
      -- })
      local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
        min_num = 0,  --不選脚色則爲自己
        max_num = 1,
        min_card_num = 1,
        max_card_num = 1,
        targets = player.room.alive_players,
        pattern = tostring(Exppattern{ id = ids }),
        skill_name = neemsneems.name,
        prompt = "#neemsneems-ask",
        cancelable = true,
        expand_pile = ids, 
      })

      if  #cards==0 then return end
      if not tos[1] then tos[1]=player end
      event:setCostData(self, { cards = cards,tos=tos})
      return true
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- local cards = table.simpleClone(event:getCostData(self).cards)
    player.room:moveCardTo(event:getCostData(self).cards, Card.PlayerHand, event:getCostData(self).tos[1], fk.ReasonGive, neemsneems.name, nil, true, player)
    -- room:obtainCard(player, cards, true, fk.ReasonPrey, player, neemsneems.name)  --置入PutInt?? ttis_tsiuh_szjet_jjen? 


  end,
})



return neemsneems

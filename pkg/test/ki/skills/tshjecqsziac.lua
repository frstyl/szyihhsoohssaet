local tshjecqsziac = fk.CreateSkill{
  name = "tshjecqsziac",
  -- tags={Skill.Limited},
}

Fk:loadTranslationTable{
  ["tshjecqsziac"] = "淸商",
  [":tshjecqsziac"] = "伱抽牌後,伱可展示1手牌發動｡伱占卜,若色与伱所展示相同,伱令1脚色抽1｡因此所抽牌1轉无視存牌數",  --

  ["#tshjecqsziac-invoke"] = "淸商：  選擇手牌發動",
  ["#tshjecqsziac-choose"] = "淸商： 令1脚色抽1",

}


-- local S = require "packages/szyihhsoohssaet/szyih_guos" 


tshjecqsziac:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(tshjecqsziac.name)  then return end

      for _, move in ipairs(data) do
        return move.moveReason==fk.ReasonDraw and data.to==player --不同旹抽牌

        -- if move.to == player and table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)  then
        --   local ids = {}
        --   for _, info in ipairs(move.moveInfo) do
        --     if not (move.from==player and table.contains({Card.PlayerEquip,Card.PlayerHand }, info.fromArea) ) then
        --       table.insertIfNeed(ids,info.cardId)
        --     end
        --   end

        --   ids = table.filter(ids, function (id)  --simpleClone
        --     return table.contains(player:getCardIds("he"), id)
        --   end)
        --   ids = player.room.logic:moveCardsHoldingAreaCheck(ids)
        --   if #ids>0 then
        --     event:setCostData(self,{cards=ids})
        --   return true end

        -- end

      end
        
    
  end,
  -- on_cost = function(self, event, target, player, data)
  --  if player.room:askToViewCardsAndChoice(player, {  --askToChooseCardsAndChoice askToCards
  --       cards = event:getCostData(self).cards,
  --       choices = { "OK", "Cancel" },
  --       skill_name = tshjecqsziac.name,
  --       prompt = "#tshjecqsziac-invoke"
  --     }) == "OK" then
  --       return true
  --     end
  -- end,
  on_cost = function(self, event, target, player, data)
    local cards = player.room:askToCards(player, { ---@type AskToCardsParams
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = tshjecqsziac.name,
      cancelable = false,
      pattern = ".|.|.|hand",
      prompt = "#tshjecqsziac-invoke"
    })
    if #cards>0 then
      event:setCostData(self,{cards=cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards =event:getCostData(self).cards
    player:showCards(cards)
    if player.dead then return end

    local judge = {
        who = player,
        reason = tshjecqsziac.name,
        pattern = ".|.|.",
      }
              -- pattern =".|.|"..card:getSuitString()"

    room:judge(judge)
    if player.dead then return end
    local suit =judge.card.color
    for _,id in ipairs(cards) do
      if suit==Fk:getCardById(id).color then 
        local to = room:askToChoosePlayers(player, {
          targets = room.alive_players,
          min_num = 1,
          max_num = 1,
          prompt = "#tshjecqsziac-choose",
          skill_name = tshjecqsziac.name,
          cancelable = true,
        })
        if #to>0 then
          to[1]:drawCards(1, tshjecqsziac.name,nil,{"@@tshjecqsziac-inhand-turn",1 , "exclude-inhand-turn",1})
        else
          player:drawCards(1, tshjecqsziac.name,nil,{"@@tshjecqsziac-inhand-turn",1 , "exclude-inhand-turn",1})
        end
        return
      end
    end
  end,
})
return tshjecqsziac

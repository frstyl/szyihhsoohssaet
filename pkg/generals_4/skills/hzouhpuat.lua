local hzouhpuat = fk.CreateSkill {
  name = "hzouhpuat",
}

Fk:loadTranslationTable{
  ["hzouhpuat"] = "後發",
  [":hzouhpuat"] = "其它角色殺不因使用打出進入弃牌堆後,伱可發動.獲得其中1至多.伱可將1+a殺轉化爲殺使用發動.伱爲此殺選a項➀不可抵消➁反无效➂无視防具➃目幖非鎖定技當轉失效(a爲1至4整數)",

  ["#hzouhpuat-choose"] = "後發 選擇所用殺与所弃牌",
  ["@@hzouhpuat-inhand"] = "後發",

  ["@@hzouhpuat-turn"] = "後發",

  ["hzouhpuat-offset"] = "不可抵消",
  ["hzouhpuat-nullify"] = "反无效",
  ["hzouhpuat-skill"] = "目幖非鎖定技本轉失效",
  ["hzouhpuat-armor"] = "无視防具",

  ["$hzouhpuat1"] = "後發先至",

}

-- local U = require "packages/utility/utility"
local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzouhpuat:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#hzouhpuat",
  interaction = function(self, player)
    return UI.ComboBox {
      choices = {2,3,4,5},
    }
  end,
  card_filter = function(self, player, to_select, selected)
    return  
      #selected <= 4 and Fk:getCardById(to_select).trueName=="ssaet"
  end,
  view_as = function(self, player, cards)
    if #cards < 2 then return  end
    local card = Fk:cloneCard("ssaet")
    card:addSubcards(cards)
    card.skillName = hzouhpuat.name
    S.mixCard(c)
    return card
  end,
  --   end,
  before_use = function(self, player, use)
      local room=player.room
      local choices = room:askToChoices(player,{
        min_num = #use.card.subcards-1,
        max_num = #use.card.subcards-1,
        choices = {"hzouhpuat-offset","hzouhpuat-nullify","hzouhpuat-armor","hzouhpuat-skill"},--
        skill_name = hzouhpuat.name,
        all_choices = allChoices,
      })
    if table.contains(choices,"hzouhpuat-offset") then
      use.unoffsetableList =table.simpleClone(player.room.players)
    end

    if table.contains(choices,"hzouhpuat-offset") then
      use.extra_data=use.extra_data or {}
      use.extra_data.antiNullify=true
    end

    if table.contains(choices,"hzouhpuat-armor") then
        room:addCardMark(use.card, "@@ignoreArmor")
    end

    if table.contains(choices,"hzouhpuat-skill") then
        for _, to in ipairs(use.tos) do
          if not to.dead then
            room:addPlayerMark(to, "@@hzouhpuat-turn")
            room:addPlayerMark(to, MarkEnum.UncompulsoryInvalidity .. "-turn")
          end
        end
    end

  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})

hzouhpuat:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and card.skillNames and table.contains(card.skillNames, hzouhpuat.name)
  end,
})


hzouhpuat:addEffect(fk.AfterCardsMove, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(hzouhpuat.name)  then return end
          local ids = {}
      for _, move in ipairs(data) do  --data move info
        if move.moveReason ~= fk.ReasonUse and move.moveReason ~= fk.ReasonResponse
          and move.from  and move.from ~= player 
          and  move.toArea == Card.DiscardPile  --元 Area不爲 DiscardPile
        then  

          for _, info in ipairs(move.moveInfo) do
            if  Fk:getCardById(info.cardId).trueName == "ssaet" 
            and  (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)
            then
                        -- player:drawCards(5)
              table.insertIfNeed(ids, info.cardId)
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
  on_cost= function(self, event, target, player, data)
    local room = player.room
    local ids = table.simpleClone(event:getCostData(self).ids)

      local cards, choice = room:askToChooseCardsAndChoice(player, {
        cards = ids,
        min_num = 1,
        max_num = #ids,
        skill_name = hzouhpuat.name,
        prompt = "#hzouhpuat-choose",
        cancel_choices = {"get_all","Cancel"}
      })
      if choice=="Cancel" then return end
      if choice=="get_all" then cards=ids end
      if #cards > 0 then
        event:setCostData(self, {cards = cards})
        return true 
      end
  end,
  on_use = function(self, event, target, player, data)
    player.room:moveCardTo(event:getCostData(self).cards, Player.Hand, player, fk.ReasonJustMove, hzouhpuat.name, nil, true, player,"@@hzouhpuat-inhand")
end,
})

return hzouhpuat

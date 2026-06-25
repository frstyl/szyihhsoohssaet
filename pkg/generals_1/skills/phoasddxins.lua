
local phoasddxins = fk.CreateSkill{
  name = "phoasddxins",
  tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["phoasddxins"] = "破陣",
  [":phoasddxins"] = "伱使用錦囊牌无視距離.伱使用卽旹錦囊牌A旹必發.其它角色不可使用打出牌響應A,若A与上一被使用牌同花,A額外生效1次",
--加彊?

  ["@phoasddxins"] = "破陣",

  ["$phoasddxins1"] = "洞察機先 无有不破",
  ["$phoasddxins2"] = "意志被摧毀了无",
}

phoasddxins:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and  player:hasSkill(phoasddxins.name) and S.isCommonTrick(data.card.trueName)
  end,
  on_use = function(self, event, target, player, data)
    -- data.disresponsiveList = table.simpleClone(player.room:getOtherPlayers(player))
    data.disresponsiveList = table.simpleClone(player.room.players)
    
    -- if data.card.suit==Card.Nosuit then return end
    -- local use_event = player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)
    --   return e.id == event.id 
    -- end, 1)
    -- if #use_event == 1 then
    --   -- local use = use_event[1].data
    --   -- if use.card.suit==data.card.suit then
    --   if use_event[1].data.card==data.card then

    --         data.additionalEffect = (data.additionalEffect or 0) + 1
    --         player:drawCards(use_event[1].id)
    --   end
    -- end
    if data.extra_data and data.extra_data.phoasddxinsCheck then
      data.additionalEffect = (data.additionalEffect or 0) + 1
    end
  end,
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(phoasddxins.name, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    local suit=data.card:getSuitString(true)
    if  target==player and suit == player:getMark("@phoasddxins") and S.isCommonTrick(data.card.trueName) then
      data.extra_data = data.extra_data or {}
      data.extra_data.phoasddxinsCheck = true
    end
    room:setPlayerMark(player, "@phoasddxins", suit )
  end,
})

phoasddxins:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return player:hasSkill(phoasddxins.name) and card and S.getCardTypeByName(card.trueName)==2
  end,
})

return phoasddxins

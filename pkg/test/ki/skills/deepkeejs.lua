local deepkeejs = fk.CreateSkill {
  name = "deepkeejs",
}

Fk:loadTranslationTable{
  ["deepkeejs"] = "諜計",
  [":deepkeejs"] = "印牌:虛擬起動｢護_將計就計｣｡起動前選擇,將1手牌中非計謀牌A置于牌堆頂,或此技能1轉失效",
  -- [":deepkeejs"] = "印牌:起動虛擬｢護_將計就計｣｡起動前,伱選擇執行將1非計謀交予響應事件起動者,或令此技能1轉失效",

  ["#deepkeejs"] = "諜計 起動虛擬｢護_將計就計",

  ["$deepkeejs1"] = "此計如何",
  ["$deepkeejs2"] = "裏外接應。",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

deepkeejs:addEffect("viewas", {
  anim_type = "control",
  pattern = "tsiac_keejs_dzius_keejs",
  prompt = "#deepkeejs",
  handly_pile = false,
  mute_card= true,
  -- card_filter = function(self, player, to_select, selected)
  --   return false
  -- end,
  filter_pattern = {
    min_num = 0,
    max_num = 0,
    pattern = ".",
  },
  include_equip=false,
  view_as = function(self, player, cards)
    local card = Fk:cloneCard("hand__tsiac_keejs_dzius_keejs")
    -- card:addFakeSubcard(cards[1])
    card.skillName = deepkeejs.name
    return card
  end,
  before_use = function(self, player, use)
    local room=player.room
    local cards=room:askToCards(player,{
      min_num=1,
      max_num=1,
      cancelable=true,
      pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
        return S.getCardTypeByName(Fk:getCardById(id).trueName) ~= 2 end) 
        }),
      include_equip=false,
    })
    if cards[1] then
    -- room:moveCardTo(cards,player,Card.DrawPile,nil,fk.ReasonPut,self.name,nil,true,player)
    room:moveCards({
      ids = cards,
      from = player,
      toArea = Card.DrawPile,
      moveReason = fk.ReasonPut,
      skillName = self.name,
      proposer = player,
      moveVisible = true,
    })
    else
      player.room:invalidateSkill(player, deepkeejs.name, "-turn")
    end
  end,
  enabled_at_response = function (self, player, response)
    return  not response
  end,
  -- enabled_at_nullification = function (self, player, data)
  --   return data.from~=player
  -- end,
})


-- deepkeejs:addEffect("viewas", {
--   anim_type = "control",
--   pattern = "tsiac_keejs_dzius_keejs",
--   prompt = "#deepkeejs",
--   handly_pile = true,
--   mute_card= true,
--   card_filter = function(self, player, to_select, selected)
--     return false
--   end,
--   view_as = function(self, player, cards)
--     local card = Fk:cloneCard("hand__tsiac_keejs_dzius_keejs")
--     card.skillName = deepkeejs.name
--     return card
--   end,
--   before_use = function(self, player, use)
--     local room=player.room
--     local valid=true
--     if  player:getMark("deepkeejs-phase")~=0  then
--       local to =room:getPlayerById(player:getMark("deepkeejs-phase"))
--       local tos, cards = room:askToChooseCardsAndPlayers(player, {
--         min_num = 1,
--         max_num = 1,
--         min_card_num = 1,
--         max_card_num = 1,
--         targets = room.players,
--         pattern = tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
--         return S.getCardTypeByName(Fk:getCardById(id).trueName) == 2 end) 
--         }),
--         skill_name = deepkeejs.name,
--         prompt = "#deepkeejs-give",
--         cancelable = false,
--       })
--       if #cards>0 and tos>0 then
--       room:moveCardTo(cards, Player.Hand, to[1], fk.ReasonGive, deepkeejs.name, nil, false, player)
--       valid=false
--       end
--     end
--     if valid then
--       player.room:invalidateSkill(player, deepkeejs.name, "-turn")
--     end
--   end,
--   enabled_at_response = function (self, player, response)
--     return  not response
--   end,
--   -- enabled_at_nullification = function (self, player, data)
--   --   return data.from~=player
--   -- end,
-- })


-- deepkeejs:addEffect(fk.HandleAskForPlayCard, {
--   can_refresh = function(self, event, target, player, data)
--     if  data.eventData 
--         -- and  data.eventData.card
--         -- and  data.eventData.card
--         and S.getCardTypeByName(data.eventData.card)==2
--         and player:hasSkill(deepkeejs.name,true)
--     then
--         return  true
--     end
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if not data.afterRequest then  --不需淸理
--       if data.eventData.from then
--        room:setPlayerMark(player,"deepkeejs-phase",  data.eventData.from.id)
--       end
--     else
--       room:setPlayerMark(player,"deepkeejs-phase",  nil)  --可能空

--     end
--   end,
-- })


return deepkeejs

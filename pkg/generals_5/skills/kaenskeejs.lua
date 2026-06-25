local kaenskeejs = fk.CreateSkill {
  name = "kaenskeejs",
}

Fk:loadTranslationTable{
  ["kaenskeejs"] = "閒計",
  [":kaenskeejs"] = "➀輪始旹,伱可選1至多手牌發動,置之于伱武將牌上➁伱可使用護—將計就計抵消牌A旹,伱可將1閒計牌交予1角色B發動,伱虛擬使用｢將計就計｣,若B不爲A使用者,此技能當轉失效。",

  ["#kaenskeejs-invoke"] = "閒計 可選多在牌置于武將牌上",
  ["kaenskeejs_card"] = "閒計",
  -- ["kaenskeejs_color-phase"] = "閒計",
  -- ["kaenskeejs_suit-phase"] = "花",
  -- ["kaenskeejs_suit"] = "閒計",
  -- ["@kaenskeejs-unoffsetable"] = "不可抵消",

  ["$kaenskeejs1"] = "此計如何",
  ["$kaenskeejs2"] = "裏外接應。",
}

kaenskeejs:addEffect(fk.RoundStart, {
  derived_piles = "kaenskeejs_card",
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kaenskeejs.name)
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
      local cards=player.room:askToCards(player,{
        min_num=1,
        max_num=999,
        include_equip=false,
        -- pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
        --   return  not player:prohibitResponse(Fk:getCardById(id))
        -- end
        -- ) }),
        prompt = "#kaenskeejs-invoke", 
        cancelable = true,
      })
      if #cards>0 then
      event:setCostData(self, {cards = cards})
      return true
      end
  end,
  on_use = function(self, event, target, player, data)
    player:addToPile("kaenskeejs_card", event:getCostData(self).cards, true, kaenskeejs.name, player)
  end,
})

kaenskeejs:addEffect("viewas", {
  anim_type = "control",
  pattern = "tsiac_keejs_dzius_keejs",
  prompt = "#kaenskeejs",
  handly_pile = true,
  mute_card= true,
  card_filter = function(self, player, to_select, selected)
    return false
  end,
  view_as = function(self, player, cards)
    local card = Fk:cloneCard("hand__tsiac_keejs_dzius_keejs")
    card.skillName = kaenskeejs.name
    return card
  end,
  before_use = function(self, player, use)
    local room=player.room
    local expand_pile=player:getPile("kaenskeejs_card")
    local to, cards = room:askToChooseCardsAndPlayers(player, {
      min_num = 1,
      max_num = 1,
      min_card_num = 1,
      max_card_num = 1,
      targets = room.alive_players,
      pattern = tostring(Exppattern{ id = expand_pile }),
      skill_name = kaenskeejs.name,
      prompt = "#kaenskeejs-give",
      cancelable = false,
      expand_pile = expand_pile,
    })
    room:moveCardTo(cards, Player.Hand, to[1], fk.ReasonGive, kaenskeejs.name, nil, false, player)
    if to ~= player:getMark("kaenskeejs-phase") then
      player.room:invalidateSkill(player, kaenskeejs.name, "-turn")
    end
  end,
  enabled_at_response = function (self, player, response)
    return not response and #player:getPile("kaenskeejs_card")>0
  end,
  enabled_at_nullification = function (self, player, data)
    return #player:getPile("kaenskeejs_card")>0
  end,
})


kaenskeejs:addEffect(fk.HandleAskForPlayCard, {
  can_refresh = function(self, event, target, player, data)
    if  data.eventData 
        and  data.eventData.card
        -- and  data.eventData.card
        and player:hasSkill(kaenskeejs.name,true)
    then
        return  true
    end
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if not data.afterRequest then  --不需清理
      -- player:drawCards(1,kaenskeejs.name)
      room:setPlayerMark(player,"kaenskeejs-phase", data.eventData.from)  --可能空

    end
  end,
})


return kaenskeejs

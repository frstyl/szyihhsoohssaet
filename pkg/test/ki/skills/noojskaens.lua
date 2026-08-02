local noojskaens = fk.CreateSkill {
  name = "noojskaens",
}
Fk:loadTranslationTable{
  ["noojskaens"] = "內閒",
  [":noojskaens"] = "印牌:虛擬起動｢將計就計｣",

  ["#noojskaens"] = "內閒 是否對  %src  發動",

  ["$noojskaens1"] = "不破不立破而後立",
}

noojskaens:addEffect("viewas", {
  anim_type = "defensive",
  pattern = "tsiac_keejs_dzius_keejs",
  prompt = function(self,player)
    return "#noojskaens:"..player:getMark("noojskaens_activated-phase")
  end,  mute_card = true,
  -- handly_pile = false,
  card_filter = function(self, player, to_select, selected)
    return table.contains(player:getCardIds("h"), to_select)  and #selected <1
  end,
  view_as = function(self, player, cards)
    local c = Fk:cloneCard("hand__tsiac_keejs_dzius_keejs")
    if #cards ~= 0 then
    c:addFakeSubcard(cards[1])
    end
    c.skillName = noojskaens.name
    return c
  end,
  before_use = function(self, player, use)
    local room=player.room
    local to=player:getMark("noojskaens_activated-phase")
    to=room:getPlayerById(to)
    local cards =use.card.fake_subcards
    if #cards>0 then
    player.room:moveCardTo(cards, Player.Hand, to, fk.ReasonGive, noojskaens.name, nil, true, player.id)
    else
      room:invalidateSkill(player, noojskaens.name, "-round")
    end
    -- data.use.card = Fk:cloneCard("tsiac_keejs_dzius_keejs")
    -- data.tos={}
  end,
  -- enabled_at_play =  function(self, player)
  --   return player:getHandcardNum()~=player.hp
  -- end,
  enabled_at_response = function(self, player, response)
    return not player:isKongcheng() and player:getMark("noojskaens_activated-phase") ~= 0
  end,
  enabled_at_nullification = function (self, player, data)  --data 加入holder
    return player:hasSkill(noojskaens.name) and not player:isKongcheng() --and data and data.from and data.from~=player
  end,
})


noojskaens:addEffect(fk.HandleAskForPlayCard, {
  can_refresh = function(self, event, target, player, data)
    if data.afterRequest or (data.extra_data and data.extra_data.noojskaens_effected) then
      return 
    end

    return
    player:hasSkill(noojskaens.name) 
    and data.eventData

  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room

    if     
    data.eventData.from
    and data.eventData.from~=player
    and Exppattern:Parse(data.pattern):matchExp("tsiac_keejs_dzius_keejs|0|nosuit|none") 
    and not player:prohibitUse(Fk:cloneCard("tsiac_keejs_dzius_keejs"))
    then
    room:setPlayerMark(player, "noojskaens_activated-phase", data.eventData.from.id)
    else
    room:setPlayerMark(player, "noojskaens_activated-phase", 0)
    end
    -- player:drawCards(10)
    data.extra_data = data.extra_data or {}
    data.extra_data.noojskaens_effected = true

  end,
})


return noojskaens

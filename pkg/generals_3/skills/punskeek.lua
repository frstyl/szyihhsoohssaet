local punskeek = fk.CreateSkill {
  name = "punskeek",  --游戲底層是殺
}
Fk:loadTranslationTable{
  ["punskeek"] = "奮毄",
  [":punskeek"] = "伱可將1牌轉化爲殺使用發動.若目幖角色體力值不小于伱體力值,其不可使用閃響應此殺",

  ["$punskeek1"] = "天下兴亡，侠客当为之己任。",
  ["$punskeek2"] = "隐居江湖之远，敢争天下之先！",
}

punskeek:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#punskeek",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = punskeek.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})

punskeek:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return  player==data.to and data.card and table.contains(data.card.skillNames, punskeek.name) 
    and data.from and data.to 
    and data.from.hp >= data.to.hp
  end,
  on_trigger = function(self, event, target, player, data)

    data.prohibitedCardNames=data.prohibitedCardNames or {}
    table.insertIfNeed(data.prohibitedCardNames, "szjemh")

  end,
})

-- punskeek:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
--   can_refresh = function(self, event, target, player, data)  --雙向?
--           return  true
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if data.eventData and  data.eventData.card
--         and table.contains(data.eventData.card.skillNames, punskeek.name) 
--         and player==data.eventData.to and data.eventData.to.hp>data.eventData.from.hp

--     and not data.afterRequest then
--       room:setPlayerMark(player,"@@punskeek-prohibit-phase", 1)
--     else
--       room:setPlayerMark(player,"@@punskeek-prohibit-phase", 0)
--     end
--   end,
-- })

-- punskeek:addEffect("prohibit", {
--   prohibit_use = function(self, player, card)
--    return player:getMark("@@punskeek-prohibit-phase")>0 and card and (card.trueName=="szjemh")
--   end,
-- })

return punskeek

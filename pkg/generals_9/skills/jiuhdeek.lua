local jiuhdeek = fk.CreateSkill {
  name = "jiuhdeek",
}

Fk:loadTranslationTable{
["jiuhdeek"] = "誘敵",
-- [":jiuhdeek"] = "當伱使用閃抵消其它角色所使用殺旹,伱可發動,伱抽1,視爲使用添兵減竈｡",
[":jiuhdeek"] = "當伱可使用｢添兵減竈｣旹,若伱至目幖距離不大于1,伱可將紅牌轉化爲｢添兵減竈｣使用發動｡",

["#jiuhdeek"] = "誘敵 將紅牌轉化爲添兵減竈",
}

jiuhdeek:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "theem_prac_kaemh_tsoavs",
  prompt = "#jiuhdeek",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)  
    return #selected == 0 and Fk:getCardById(to_select).color==Card.Red --and Fk:getCardById(to_select).trueName=="szjemh"
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("hand__theem_prac_kaemh_tsoavs")
    c:addSubcard(cards[1])
    c.skillName = jiuhdeek.name
    return c
  end,
  -- before_use= function(self, player, use)
  --   -- local respond  player.room:askToResponse(to, {
  --   --     skill_name = jiuhdeek.name,
  --   --     pattern = "szjemh",
  --   --     prompt = "#jiuhdeek-ask",
  --   --     cancelable = false,
  --   --   })
  --   --   if not  respond then
  --   --     return jiuhdeek.name
  --   --   end
  --   player:drawCards(1,jiuhdeek.name)
  -- end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return  not response and not player:isKongcheng()
  end,
  enabled_at_nullification = function (self, player, data)
    return data and data.to 
      and not player:isKongcheng()
      and player:compareDistance(data.to, 1, "<=")
  end,
})

-- jiuhdeek:addEffect(fk.CardEffectCancelledOut, {

--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return data.cardsResponded[1].trueName=="szjemh" and data.card.trueName=="ssaet"
--     and data.to == player and player:hasSkill(jiuhdeek.name) 
--   end,
--   on_use = function(self, event, target, player, data)
--     player:drawCards(1,jiuhdeek.name)
--     local card = Fk:cloneCard("jiuh_deek")
--     card.skillName = jiuhdeek.name
--     local use={
--       from = player,
--       tos = {},
--       card = card,
--       extra_data = {
--           jiuh_deek = true,
--         }
--     }
--     use.toCard = data.card
--     use.responseToEvent = data
--     player.room:useCard(use)
--   end,
-- })

return jiuhdeek

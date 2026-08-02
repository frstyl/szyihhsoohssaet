local jiuhdeek = fk.CreateSkill {
  name = "jiuhdeek",
}

Fk:loadTranslationTable{
["jiuhdeek"] = "誘敵",
-- [":jiuhdeek"] = "印牌:以伱1紅牌轉化起動｢添兵減竈｣｡需伱至｢殺｣目幖距離不大于1",
-- [":jiuhdeek"] = "伱起動閃抵消其它脚色所起動殺旹,伱可發動,伱抽1,視爲起動添兵減竈｡",
[":jiuhdeek"] = "伱可起動｢添兵減竈｣抵消｢殺｣旹,若伱至｢殺｣目幖距離不大于1,伱可視爲于元旹機以伱1紅牌轉化起動｢添兵減竈｣發動｡",

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

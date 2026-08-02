local siuqdzjecs_active = fk.CreateSkill {
  name = "siuqdzjecs_active",
}

Fk:loadTranslationTable {
  ["siuqdzjecs_active"] = "修淨",
  [":siuqdzjecs_active"] = "➀主旹,伱可預選1手牌發動.伱將此牌置入裝僃欄(自選),其抽x.➁恆續,伱攻程+x,存牌數+x(x爲伱裝僃區牌數)",

  ["#siuqdzjecs_active"] = "修淨：將1手牌置入伱裝僃區",

  ["$siuqdzjecs_active1"] = "怀兼爱之心，琢世间百器。",
  ["$siuqdzjecs_active2"] = "机巧用尽，方化腐朽为神奇！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


siuqdzjecs_active:addEffect("active", {  --段始旹
  anim_type = "support",
  prompt = "#siuqdzjecs_active",
  max_phase_use_time = 1,
  card_num = 1,
  target_num = 1,
  can_use = function (self, player)
    return player:usedEffectTimes(siuqdzjecs_active.name, Player.HistoryPhase) == 0 
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and S.getCardTypeByName(Fk:getCardById(to_select).trueName)== 3 
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected == 0 
    and selected_cards[1] and #to_select:getAvailableEquipSlots(Fk:getCardById(selected_cards[1]).sub_type)>0
  end,
  on_use = function(self, room, effect)
    local player=effect.from
    local to = effect.tos[1]
    room:moveCardIntoEquip(to, effect.cards, "siuqdzjecs", true, player)
    local cards = to:getCardIds("j")
    if #cards>0 then
      room:throwCard(cards,"siuqdzjecs",to,player)
    end
  end,
})



return siuqdzjecs_active

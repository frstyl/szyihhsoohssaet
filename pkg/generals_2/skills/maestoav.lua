local maestoav = fk.CreateSkill({
  name = "maestoav",
  attached_skill_name = "maestoav_attached&",
})


Fk:loadTranslationTable{
  ["maestoav"] = "賣刀",
  [":maestoav"] = "➀主旹任意次,伱可選1武器牌發動.將其置于武將牌上稱爲刀➁其角色于其主旹可交予伱1~3牌獲取伱1刀.伱可拒絕",

  ["#maestoav"] = "賣刀",

  ["maestoav_toav"] = "刀",


  ["$maestoav1"] = "何人能識此刀",
  ["$maestoav2"] = "伱止給足銀子明日自來与它收屍",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

maestoav:addEffect("active", {
  derived_piles = "maestoav_toav",
  card_num = 1,
  target_num = 0,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).sub_type==Card.SubtypeWeapon
  end,
  on_use = function(self, room, effect)
      effect.from:addToPile("maestoav_toav", effect.cards, true, maestoav.name)
  end,
})
return maestoav

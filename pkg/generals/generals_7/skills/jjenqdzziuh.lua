local jjenqdzziuh = fk.CreateSkill {
  name = "jjenqdzziuh",
  tags = {Skill.Limited}, --?
}

Fk:loadTranslationTable{
  ["jjenqdzziuh"] = "延壽",
  [":jjenqdzziuh"] = "局限1.主旹,伱打出2紅桃牌發動,令1脚色加1體力上限",


  ["$jjenqdzziuh1"] = "助伱延壽十秊",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

jjenqdzziuh:addEffect("active", {
  anim_type = "offensive",
  target_num = 1,
  card_num = 2,
  prompt = "#jjenqdzziuh",
  can_use = function(self, player)
    return player:usedSkillTimes(jjenqdzziuh.name, Player.HistoryGame) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return Fk:getCardById(to_select).suit==Card.Heart
    and not player:prohibitResponse(Fk:getCardById(to_select))
  end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return #selected == 0
  end,
  on_use = function(self, room, effect)
    -- room:throwCard(effect.cards, jjenqdzziuh.name, effect.from, effect.from)
    S.playCard( effect.cards,jjenqdzziuh.name,effect.from )

    room:changeMaxHp(effect.tos[1], 1)  --无來源
  end,
})

return jjenqdzziuh

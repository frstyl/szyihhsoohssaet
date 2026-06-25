local skill = fk.CreateSkill {
  name = "koarbiuk_cardskill",
}
Fk:loadTranslationTable{
  ["koarbiuk_cardskill"] = "葢伏",
  [":koarbiuk_cardskill"] = "主旹,將此牌暗置于伱伏區",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- local U = require "packages/utility/utility"

Fk:loadTranslationTable{
  ["koarbiuk_cardskill"] = "葢伏",
  ["#koarbiuk_cardskill"] = "葢伏此牌 置入伏區",
}
skill:addEffect("active", {
  prompt = "#koarbiuk_cardskill",
  target_num = 0,
  on_use = function(self, room, effect)

	  -- room:addSkill("#koarbiuk_rule")

	  -- card = Card:getIdList(effect.cards)[1]
	  -- local c = Fk:cloneCard("koarbiuk_card")  --koarbiuk_card
	  -- c:addSubcard(card)  --緟寫合成規則 mixCard
	  -- effect.from:addVirtualEquip(c)
	  -- --function MoveEventWrappers:moveCardTo(card, to_place, target, reason, skill_name, special_name, visible, proposer, moveMark, visiblePlayers)

	  -- room:moveCardTo(c, Player.Judge, effect.from, fk.ReasonJustMove, skill.name, nil, false, effect.from, {"koarbiuk-inarea", c.name}, {effect.from.id})
	S.koarbiuk(effect.from, effect.cards[1], skill.name, effect.from)  --止1
-- U.premeditate(effect.from, effect.cards, skill.name, effect.from)
  end,
})



return skill

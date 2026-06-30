
local cardSkill = fk.CreateSkill{
  name = "thou_theen_hzvoans_nzjit",
}

cardSkill:addEffect("active", {
  prompt = "#thou_theen_hzvoans_nzjit",
  -- target_num = 1,
  on_use = function(self, room, effect)
    local cards = room:getNCards(1,"top")
    room:swapCardsWithPile(effect.from, effect.cards, cards, "thou_theen_hzvoans_nzjit","Top", true)
  end,


})


return cardSkill

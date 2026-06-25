local puacsthoeojs = fk.CreateSkill {
  name = "puacsthoeojs",
}

Fk:loadTranslationTable{
  ["puacsthoeojs"] = "放態",
  [":puacsthoeojs"] = "主旹,預弃a(至少爲1)手牌牌發動.伱抽a+1",

  ["#puacsthoeojs-active"] = "放態 弃至少爲1手牌牌發動 抽a+1"",
}
puacsthoeojs:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#puacsthoeojs-active",
  max_phase_use_time = 1,
  target_num = 0,
  min_card_num = 1,
  card_filter = function(self, player, to_select)
    return not player:prohibitDiscard(to_select) and table.contains(player:getCardIds("h"), to_select)
  end,
  on_use = function(self, room, effect)
    local from = effect.from
    room:throwCard(effect.cards, puacsthoeojs.name, from, from)
    if from:isAlive() then
      from:drawCards(1+#effect.cards, puacsthoeojs.name)
    end
  end,
})



return puacsthoeojs

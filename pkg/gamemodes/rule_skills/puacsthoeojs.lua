local puacsthoeojs = fk.CreateSkill {
  name = "puacsthoeojs",
  mode_skill = true,
}

Fk:loadTranslationTable{
  ["puacsthoeojs"] = "放態",
  [":puacsthoeojs"] = "主旹,弃置a(至少爲1)手牌牌發動.伱抽a+1",

  ["#puacsthoeojs-active"] = "放態 弃置至少爲1手牌牌發動 抽a+1",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

puacsthoeojs:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#puacsthoeojs-active",
  max_phase_use_time = 1,
  target_num = 0,
  min_card_num = 1,
  card_filter = function(self, player, to_select)
    return not 
    player:prohibitDiscard(Fk:getCardById(to_select)) 
    -- player:prohibitResponse(Fk:getCardById(to_select)) 
    and table.contains(player:getCardIds("h"), to_select)
  end,
  on_use = function(self, room, effect)
    local from = effect.from
    -- S.playCard(effect.cards,puacsthoeojs.name,from)
    room:throwCard(effect.cards,puacsthoeojs.name,from,from)
    if from:isAlive() then
      from:drawCards(1+#effect.cards, puacsthoeojs.name)
    end
  end,
})



return puacsthoeojs

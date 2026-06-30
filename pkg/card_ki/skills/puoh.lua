local equipSkill = fk.CreateSkill {
  name = "#puoh_skill",
  attached_equip = "puoh",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"

equipSkill:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)
    return data.isCancellOut  and player:hasSkill(equipSkill.name) and data.from == player and data.card.trueName == "ssaet" and not data.to.dead
    and data.cardsResponded[#data.cardsResponded].trueName=="szjemh"  --誤
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    local cards = S.askToPlayCard(player, {
      min_num = 2,
      max_num = 2,
      include_equip = true,
      skill_name = equipSkill.name,
      cancelable = true,
      pattern = tostring(Exppattern{ id = cards }),
      prompt = "#puoh-invoke::"..data.to.id, skip = true })
    if #cards > 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    S.playCard(player,event:getCostData(self).cards,equipSkill.name)
    data.isCancellOut = false
  end,
})

return equipSkill

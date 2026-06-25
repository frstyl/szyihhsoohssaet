local nzjishsian = fk.CreateSkill {
  name = "nzjishsian",
}
Fk:loadTranslationTable{
  ["nzjishsian"] = "二掀",
  [":nzjishsian"] = "伱所使用殺被閃抵消後,伱可發動.伱牢+1,此殺生效",

}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

nzjishsian:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(nzjishsian.name) and data.from == player and data.card.trueName == "ssaet" and not data.to.dead
        and data.cardsResponded[1].trueName=="szjemh"  --誤
  end,
  on_use = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@loav",1)
    data.isCancellOut = false
  end,
})

return nzjishsian

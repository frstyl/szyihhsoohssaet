local openCards = fk.CreateSkill {
  name = "openCards",

}

Fk:loadTranslationTable{
  ["@@opend"] = "明置",
  ["@@open-inhand"] = "明置",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

openCards:addEffect("visibility", {
  card_visible = function(self, player, card)
    if  card:hasMark("@@opend") then
      return true
    end
    if  card:hasMark("concealed") then
      return false
    end
    --葢伏
    if not player then return end
    if table.contains(S.getPlayerKoarbiukCards(player),card.id ) then
      return true
    elseif table.contains(S.getAllKoarbiukCards(),card.id ) then
        return false
    end
  end,
})

return openCards

local openCards = fk.CreateSkill {
  name = "openCards",

}

Fk:loadTranslationTable{
  ["@@open"] = "明置",
  ["@@open-inhand"] = "明置",
}
openCards:addEffect("visibility", {
  card_visible = function(self, player, card)
    if  Fk:currentRoom():getCardArea(card) == Card.PlayerHand and card:hasMark("@@open") then
      return true
    end
  end
})

return openCards

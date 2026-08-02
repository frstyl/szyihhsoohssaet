local openCards = fk.CreateSkill {
  name = "openCards",

}

Fk:loadTranslationTable{
  ["@@open"] = "明置",
  ["@@open-inhand"] = "明置",
}
openCards:addEffect("visibility", {
  card_visible = function(self, player, card)
    if   card:hasMark("@@open") then
      return true
    end
    if card:hasMark("concealed") then
      return false
    end
  end,
})

return openCards

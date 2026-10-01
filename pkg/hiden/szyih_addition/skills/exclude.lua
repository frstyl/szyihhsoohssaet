local exclude = fk.CreateSkill {
  name = "exclude",
}




exclude:addEffect("maxcards", {
  exclude_from = function(self, player, card)
    return card:hasMark("exclude")
  end,
})

return exclude

local bypass_distances = fk.CreateSkill {
  name = "bypass_distances",
}


bypass_distances:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card, to)
    if card:isVirtual() and card.skillName==nil then return true end--bug 能印bypass_distances牌无法用印牌技能--
    if player:hasMark("bypass_distances") then return true end
    if card:hasMark("bypass_distances")  then return true end
    local subCards = Card:getIdList(card)
    return #subCards > 0 and
      table.every(subCards, function (id)
        return Fk:getCardById(id):hasMark("bypass_distances")
      end)
  end,
})



return bypass_distances

local bypass_times = fk.CreateSkill {
  name = "bypass_times",
}


bypass_times:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card, to)
    if card:isVirtual() and card.skillName==nil then return true end--bug 能印bypass_times牌无法用印牌技能--
    if player:hasMark("bypass_times") then return true end
    if card:hasMark("bypass_times")  then return true end
    local subCards = Card:getIdList(card)
    return #subCards > 0 and
      table.every(subCards, function (id)
        return Fk:getCardById(id):hasMark("bypass_times")
      end)
  end,
})



return bypass_times

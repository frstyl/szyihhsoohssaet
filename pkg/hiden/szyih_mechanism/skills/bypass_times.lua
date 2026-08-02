local bypass_times = fk.CreateSkill {
  name = "bypass_times",
}


bypass_times:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card, to)
    if card and card:isVirtual() and card.skillName==nil then return true end--bug 能印bypass_times牌无法用印牌技能--

    if player then
      if player:hasMark("bypass_times") then return true end
      if to and  table.contains(player:getTableMark("bypass_times_to"), to.id) then return true end
    end

    if  card then  
      if  card:hasMark("bypass_times")  then return true end
      local subCards = Card:getIdList(card)
      return #subCards > 0 and
        table.every(subCards, function (id)
          return Fk:getCardById(id):hasMark("bypass_times")
        end)
    end

    --某腳色(有技能)起動某牌
  end,
})



return bypass_times

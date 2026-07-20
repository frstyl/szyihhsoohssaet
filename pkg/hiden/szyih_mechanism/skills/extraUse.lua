local extraUse = fk.CreateSkill {
  name = "extraUse",
}


extraUse:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    if target ~= player or data.extraUse then return end
    if player:hasMark("extraUse") then return true end
    if   ( data.card:hasMark("extraUse")  )    --or data.card:hasMark("ignoreTimes")  --bypass extraUse分寫
    then return true end

    return data.card:isConverted() and
      table.every(data.card.subCards, function (id)
        local c =  Fk:getCardById(id)
        return c:hasMark("extraUse") -- or c:hasMark("ignoreTimes") 
      end)
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse = true
  end,
})



return extraUse

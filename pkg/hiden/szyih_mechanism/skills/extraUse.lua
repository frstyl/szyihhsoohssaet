local extraUse = fk.CreateSkill {
  name = "extra_use",
}


extraUse:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    if target ~= player or data.extraUse then return end
    if player:hasMark("extra_use") then return true end
    if   ( data.card:hasMark("extra_use")  )    --or data.card:hasMark("ignoreTimes")  --bypass extraUse分寫
    then return true end

    return data.card:isConverted() 
    and  table.every(data.card.subcards, 
    function (id)
        local c =  Fk:getCardById(id)
        return c:hasMark("extra_use") -- or c:hasMark("ignoreTimes") 
      end)
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse = true
  end,
})



return extraUse

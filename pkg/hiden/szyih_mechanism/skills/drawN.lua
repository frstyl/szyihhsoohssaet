local drawN = fk.CreateSkill {
  name = "drawN",
}

Fk:loadTranslationTable{

  ["@minus_phase_draw"] = "抽牌-",
  ["@add_phase_draw"] = "抽牌",

  ["@add_drawN-turn"] = "抽牌",
}


drawN:addEffect(fk.DrawNCards, {
  can_refresh = function(self, event, target, player, data)
    return target==player and (player:hasMark("@add_phase_draw") or player:hasMark("@minus_phase_draw") )
  end,
  on_refresh = function(self, event, target, player, data)
    local n = 0
    local t = {"","-round" , "-turn" , "-phase" , "-noclear"}

    for _, suffix in ipairs(t) do
      n=n+player:getMark("@add_phase_draw"..suffix) 
      n=n-player:getMark("@minus_phase_draw"..suffix) 
    end
    data.n=data.n+n
  end
})

return drawN

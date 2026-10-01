
local tssisnzjins = fk.CreateSkill{
  name = "tssisnzjins",
}

Fk:loadTranslationTable{
  ["tssisnzjins"] = "剚刃",
  [":tssisnzjins"] = "伱受傷後,若有傷源牌,伱可虛擬起動之發動",

  ["#tssisnzjins-invoke"] = "剚刃 起動%arg",

  ["$tssisnzjins1"] = "",
  ["$tssisnzjins2"] = "",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

tssisnzjins:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tssisnzjins.name)
    and (data.to==player or data.from==player)
    and data.card
  end,
  on_cost = function(self, event, target, player, data)
    local use=S.askToVirutalUse(player,{
      card=data.card,
      bypass_times=false,
      skip=true,
    })
    if use then
      event:setCostData(self, { extra_data = use,tos=use.tos })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).extra_data)
  end,
})


return tssisnzjins

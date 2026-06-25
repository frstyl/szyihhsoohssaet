local tsziukzzyit_hzaechquns = fk.CreateSkill {
  name = "tsziukzzyit_tthxinsdook",
}

Fk:loadTranslationTable{
  ["#tthxinsdook-effected"] = "%from疢毒發作 弃1",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsziukzzyit_hzaechquns:addEffect(fk.TurnStart, {
  -- globle=true,
  is_delay_effect = true,
  can_trigger= function(self, event, target, player, data)
    return target==player and S.hasTsziukzzyit(player,"tthxinsdook")
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:sendLog{ type = "#tthxinsdook-effected", from = player.id}
    player.room:throwCard(table.random(player:getCardIds("h"),1),tsziukzzyit_hzaechquns.name,player,player)
  end,
})


return tsziukzzyit_hzaechquns

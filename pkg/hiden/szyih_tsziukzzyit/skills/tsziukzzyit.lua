local tsziukzzyit_rule = fk.CreateSkill {
  name = "tsziukzzyit_rule",
}

Fk:loadTranslationTable{
  ["tsziukzzyit_rule"] = "咒術",

  ["@tsziukzzyit_hzaechquns"] = "𡴘運",
  ["@tsziukzzyit_mxiquns"] = "黴運",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


tsziukzzyit_rule:addEffect(fk.TurnEnd, {--放生死之戰包?
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    return target==player
    and S.hasTsziukzzyit(player)
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:removePlayerMark(player,S.hasTsziukzzyit(player),1)
  end,
})


return tsziukzzyit_rule

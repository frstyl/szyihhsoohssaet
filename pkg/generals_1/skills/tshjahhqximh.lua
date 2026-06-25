local tshjahhqximh = fk.CreateSkill {
  name = "tshjahhqximh",
}

Fk:loadTranslationTable{
  ["tshjahhqximh"] = "且飲",
  [":tshjahhqximh"] = "伱越過階段後伱可發動,伱選一角色,伱与其各抽1",

  ["#tshjahhqximh-choose"] = "且飲  選一角色,伱与其各抽1",

  ["$tshjahhqximh1"] = "兄弟若不嫌弃上吾山寨盤桓數日如何",
  ["$tshjahhqximh2"] = "杜某願把昰把交倚讓与兄弟",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 





tshjahhqximh:addEffect(fk.EventPhaseSkipped, {
  anim_type = "drwacard",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(tshjahhqximh.name)  
  end,
  on_cost = function(self, event, target, player, data)
    local to = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),
      skill_name = tshjahhqximh.name,
      prompt = "#tshjahhqximh-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to = event:getCostData(self).tos[1]
    if not player.dead then player:drawCards(1,tshjahhqximh.name) end
    if not to.dead then to:drawCards(1,tshjahhqximh.name) end
  end,

})
return tshjahhqximh

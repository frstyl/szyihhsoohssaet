
local ljeqsoav = fk.CreateSkill {
  name = "ljeqsoav",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["ljeqsoav"] = "離騷",
  [":ljeqsoav"] = "鎖定.伱受到紅殺所致傷後,必發.伱減1體力上限",

  ["$ljeqsoav1"] = "日月忽其不淹兮 萅与秌其代序",
  ["$ljeqsoav2"] = "長太息以掩涕兮 哀民生之多艱",
}

ljeqsoav:addEffect(fk.Damaged, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ljeqsoav.name) and data.card and data.card.trueName == "ssaet" and
       data.card.color == Card.Red 
  end,
  on_use = function(self, event, target, player, data)
    player.room:changeMaxHp(player, -1)
  end,
})

return ljeqsoav

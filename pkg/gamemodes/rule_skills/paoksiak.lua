local paoksiak = fk.CreateSkill {
  name = "m_paoksiak",
  tags = { Skill.Compulsory },
  mode_skill = true,
}

Fk:loadTranslationTable{
  ["m_paoksiak"] = "剝削",
  [":m_paoksiak"] = "鎖，預段末段始旹必發.伱抽1",
}

paoksiak:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(paoksiak.name) and (player.phase == Player.Start or player.phase == Player.Finish)
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1, paoksiak.name)
  end,
})



return paoksiak

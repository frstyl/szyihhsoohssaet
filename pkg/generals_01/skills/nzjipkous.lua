local nzjipkous = fk.CreateSkill {
  name = "nzjipkous",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["nzjipkous"] = "入彀",
  [":nzjipkous"] = "鎖定.伱所受傷害結算前,必發.改爲失去等量體力上限",

  ["$nzjipkous1"] = "你的死活，与我何干？",
  ["$nzjipkous2"] = "无来无去，不悔不怨。",
}

nzjipkous:addEffect(fk.PreDamage, {--
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.to==player and player:hasSkill(nzjipkous.name)
  end,
  on_use = function(self, event, target, player, data)
    player.room:changeMaxHp(player, - data.damage)
    data:preventDamage()  --无旹機
  end,
})

return nzjipkous
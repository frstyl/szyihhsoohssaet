local kveetmracs = fk.CreateSkill{
  name = "kveetmracs",
  tags = { Skill.Compulsory },
}


Fk:loadTranslationTable{
  ["kveetmracs"] = "決命",
  [":kveetmracs"] = "鎖,恆續效果.若伱體力值不大于{1/2/3}伱不是{殺/鬥將/行刺}合理目幖",

  ["$kveetmracs1"] = "絕處逢生",
  ["$kveetmracs2"] = "一腔熱血止賣与識貨者"
}
kveetmracs:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    if to:hasSkill(kveetmracs.name) and card and to.hp<4 then
      local cards={"hzeec_tshjes"}

      if to.hp<2 then
        cards={"hzeec_tshjes","tous_tsiacs","ssaet"}
      elseif to.hp<2 then
        cards={"hzeec_tshjes","tous_tsiacs"}
      end
      return table.contains(cards, card.trueName)
    end
  end,
})

kveetmracs:addEffect(fk.HpChanged, {
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(kveetmracs.name) and data.num < 0 and player.hp<4 
  end,
  on_refresh = function(self, event, target, player, data)
    player:broadcastSkillInvoke(kveetmracs.name)
    player.room:notifySkillInvoked(player, kveetmracs.name, "defensive")
  end,
})


return kveetmracs

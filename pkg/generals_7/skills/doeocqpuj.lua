local doeocqpuj = fk.CreateSkill {
  name = "doeocqpuj",
  tags={Skill.Compulsory, Skill.Permanent}
}

Fk:loadTranslationTable{
  ["doeocqpuj"] = "騰飛",
  [":doeocqpuj"] = "鎖定.轉終後必發,伱體力上限-1,抽1,獲得一額外轉.伱攻程+x(x爲伱體力上限)",  --持恆技!!

  ["$doeocqpuj1"] = "舍吾眞血 畢其功于一役",
  ["$doeocqpuj2"] = "我要飛得更加",
  ["$doeocqpuj3"] = "一䡴到底",
}

doeocqpuj:addEffect(fk.TurnEnd, {
  priority=-0.1,  --禁公孫勝
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  target==player    and player:hasSkill(doeocqpuj.name) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:changeMaxHp(player,-1)
    player:drawCards(1,doeocqpuj.name)
    player:gainAnExtraTurn(true,doeocqpuj.name)
  end,
})

doeocqpuj:addEffect("atkrange", {
  correct_func = function(self, from, to)
    if from:hasSkill(doeocqpuj.name) then
      return from.maxHp
    end
  end,
})

return doeocqpuj

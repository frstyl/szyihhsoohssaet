local khihprac = fk.CreateSkill {
  name = "khihprac",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["khihprac"] = "起兵",
  [":khihprac"] = "鎖定.額定抽牌旹,必發,伱選1項發動,➀抽牌數+x,本段伱攻程爲x.本轉終旹,若伱本轉未致傷,伱流失1體力(x爲伱體力值定值)➁抽牌數+y,本轉伱手牌+y,伱使用牌不可指定其他角色爲目幖(y爲伱已損體力值定值)",  --攻程基于體力值

  ["#khihprac_hp"] = "多抽%arg，",
  ["#khihprac_losthp"] = "多抽%arg",

  ["@@khihprac-damage-turn"] = "起兵 未致傷",
  ["@khihprac-hp-turn"] = "起兵 進攻",
  ["@@khihprac-losthp-turn"] = "起兵 固守",

  ["$khihprac1"] = "有此八州,天子可推,天下可得",
  ["$khihprac2"] = "吾軍勢大,霸業可成",
  ["$khihprac3"] = "止𠟇下兩州之地了",
  ["$khihprac4"] = "兵勢已衰,止得固守",
}
khihprac:addEffect(fk.DrawNCards, {
  can_trigger = function(self, event, target, player, data)
    return     target==player and  player:hasSkill(khihprac.name)
    end,
  on_use = function(self, event, target, player, data)  --鎖
  local room=player.room
  local choice = room:askToChoice(player, {
    choices = { "#khihprac_hp:::"..player.hp, "#khihprac_losthp:::"..player:getLostHp()},
    skill_name = khihprac.name,
  })
  if choice:startsWith("khihprac_hp") then
    data.n = data.n +player.hp
    room:setPlayerMark(player,"@khihprac-hp-turn",player.hp)
    room:setPlayerMark(player,"@@khihprac-damage-turn",1)
  else
    data.n = data.n + player:getLostHp()
    room:setPlayerMark(player,"@@khihprac-losthp-turn",1)
    room:addPlayerMark(player, MarkEnum.AddMaxCardsInTurn, player:getLostHp())  --可合併

    end
  end,
})

khihprac:addEffect(fk.Damage, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:getMark("@@khihprac-damage-turn") >0 and not player.dead
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@@khihprac-damage-turn", 0)
  end,
})

khihprac:addEffect(fk.TurnEnd, {
  is_delay_effect=ture,
  can_refresh= function(self, event, target, player, data)
        return player:getMark("@@khihprac-damage-turn") >0 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:loseHp(player,1)
    player.room:setPlayerMark(player, "@@khihprac-damage-turn", 0)
  end,
})


khihprac:addEffect("atkrange", {
  fixed_func = function(self, player)
    if player:getMark("@khihprac-hp-turn") >0 then
      return   player:getMark("@khihprac-hp-turn")
    end
  end
})

-- khihprac:addEffect("maxcards", {
--   fixed_func = function(self, player)
--     if player:getMark("@@khihprac-losthp-turn") >0 then
--       return   player:getLostHp() 
--     end
--   end
-- })

khihprac:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return from and from:getMark("@@khihprac-losthp-turn") > 0 and card and from ~= to
  end,
})

return khihprac

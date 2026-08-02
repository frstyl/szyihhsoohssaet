local seenqkaok = fk.CreateSkill{
  name = "seenqkaok",
}

Fk:loadTranslationTable{
  ["seenqkaok"] = "先覺",
  [":seenqkaok"] = "伱{占卜/抽牌}前伱可發動.伱觀看牌堆頂{1/抽牌數}牌,將之緟排序置于牌堆頂或牌堆底",

  ["#seenqkaok-draw"] = "先覺伱將抽 %arg 是否發動",
  ["#seenqkaok-judge"] = "先覺 伱將占卜%arg,是否發動",

  ["$seenqkaok1"] = "一眼望天謀定而後動",
  ["$seenqkaok2"] = "略施小計可一通天下",
}

local spec={
  on_use = function(self, event, target, player, data)
    local room = player.room
    local result = room:askToGuanxing(player, { cards = room:getNCards(data.num or 1)})
  end,
}
--EventPhaseStart
seenqkaok:addEffect(fk.BeforeDrawCard, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(seenqkaok.name) 
    and data.num > 0 
  end,
  on_cost== function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = buyi.name,
      prompt = "#seenqkaok-draw::"..data.num,
    }) 
  end,
  on_use=spec.on_use,
})
seenqkaok:addEffect(fk.StartJudge, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(seenqkaok.name) 
    -- and data.num > 0 
  end,
  on_cost== function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = buyi.name,
      prompt = "#seenqkaok-judge:::"..data.reason,
    }) 
  end,
  on_use=spec.on_use,
})
return seenqkaok

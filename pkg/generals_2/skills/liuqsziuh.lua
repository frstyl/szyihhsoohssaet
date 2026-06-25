local liuqsziuh = fk.CreateSkill {
  name = "liuqsziuh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["liuqsziuh"] = "畱守",
  [":liuqsziuh"] = "鎖定.若伱有牢,殺對伱无效.",

  ["#liuqsziuh-invoke"] = "吐信 是否對 %src 發動 0牌确定則其弃牌",
}
liuqsziuh:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(liuqsziuh.name) 
    and    data.card.trueName == "ssaet"
    and    player:getMark("@loav")>0
  end,
  on_use = function(_, _, _, _, data)
    data.nullified = true
  end
})

liuqsziuh:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(liuqsziuh.name) then return end
    for _, move in ipairs(data) do
      if move.from == player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerEquip then
            return true
          end
        end
      end
    end
  end,
  trigger_times = function(self, event, target, player, data)
    local i = 0
    for _, move in ipairs(data) do
      if move.from == player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerEquip then
            i = i + 1
          end
        end
      end
    end
    return i
  end,
  on_use = function(self, event, target, player, data)
    player:romovePlayerMark("@loav",1)  --all?
  end,
})

return liuqsziuh

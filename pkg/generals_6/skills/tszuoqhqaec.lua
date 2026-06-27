local tszuoqhqaec = fk.CreateSkill{
  name = "tszuoqhqaec",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable {
  ["tszuoqhqaec"] = "朱櫻",
  [":tszuoqhqaec"] = "鎖.伱使用酒後,至伱下轉始,伱不是其它角色牌合理目幖",  --使用旹改爲?

  ["@@tszuoqhqaec"] = "朱櫻",

  ["$tszuoqhqaec1"] = "奴家不勝酒力官人休要再勸",
}

tszuoqhqaec:addEffect(fk.CardUseFinished, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and data.card.trueName=="tsiuh"
  end,
  on_use = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@@tszuoqhqaec",1)
  end,
})

tszuoqhqaec:addEffect(fk.TurnStart, {
  anim_type = "offensive",
  can_refresh= function(self, event, target, player, data)
    return target==player and player:hasMark("@@tszuoqhqaec") 
  end,
  on_refresh= function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@@tszuoqhqaec",0)
end,
})
tszuoqhqaec:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    if --to:hasSkill(kongcheng.name) and 
    to:hasMark("@@tszuoqhqaec") and card then  --hasSkill?
      return from and from~=to
    end
  end,
})

-- tszuoqhqaec:addEffect("filter", {
--   card_filter = function(self, card, player)
--     return player:hasSkill(tszuoqhqaec.name) and card.trueName == "tsiuh" 
--     and table.contains(player:getCardIds("h"), card.id)
--   end,
--   view_as = function(self, player, card)
--     local card = Fk:cloneCard("nziuk", card.suit, card.number)
--     card.skillName = tszuoqhqaec.name
--     return card
--   end,
-- })
return tszuoqhqaec

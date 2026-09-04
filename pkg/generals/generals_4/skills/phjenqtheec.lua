local phjenqtheec = fk.CreateSkill {
  name = "phjenqtheec",
}

Fk:loadTranslationTable{
  ["phjenqtheec"] = "偏聽",
  [":phjenqtheec"] = "伱成爲起動目幖後,若爲♣️牌伱可發動.伱抽x(x爲伱體力數)",  --使用者體力

  ["$phjenqtheec1"] = "通判所言有理見得亟明",
  ["$phjenqtheec2"] = "昰个卻正是反詩汝若里得來",
}

phjenqtheec:addEffect(fk.TargetConfirmed, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(phjenqtheec.name) and data.card.suit == Card.Club
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player.hp, phjenqtheec.name)
  end,
})

return phjenqtheec

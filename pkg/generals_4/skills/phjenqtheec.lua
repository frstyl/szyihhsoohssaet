local phjenqtheec = fk.CreateSkill {
  name = "phjenqtheec",
}

Fk:loadTranslationTable{
  ["phjenqtheec"] = "偏聽",
  [":phjenqtheec"] = "當伱成爲梅花牌目幖後，伱可發動.伱抽x(x爲伱體力值)",

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

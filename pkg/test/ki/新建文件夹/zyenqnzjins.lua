local zyenqnzjins = fk.CreateSkill {
  name = "zyenqnzjins",
  tags = { Skill.Compulsory },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable {
  ["zyenqnzjins"] = "旋刃",
  [":zyenqnzjins"] = "伱所起動殺被閃抵消旹,必發.殺額外生效1次",

  ["$zyenqnzjins1"] = "飛影漫天,必有一傷",
  ["$zyenqnzjins2"] = "昰一刀必昰要殺出血灮",
}


zyenqnzjins:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.cardsResponded[1].trueName=="szjemh" 
    and data.from == player
    and player:hasSkill(zyenqnzjins.name)
    and data.card.trueName=="ssaet"
  end,
  on_use = function(self, event, target, player, data)
    data.use.additionalEffect = (data.use.additionalEffect or 0) + 1
  end,
})

return zyenqnzjins
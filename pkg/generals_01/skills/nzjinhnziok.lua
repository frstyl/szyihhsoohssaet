Fk:loadTranslationTable{
  ["nzjinhnziok"] = "忍辱",
  [":nzjinhnziok"] = "鎖定.伱受傷旹,若伱有黴運,必發.防止之.",



  ["$nzjinhnziok1"] = "等我家兄弟回來 決饒不了伱",
  ["$nzjinhnziok2"] = "伱作之勾當 我親手來捉伱姦",
}

local nzjinhnziok = fk.CreateSkill{
  name = "nzjinhnziok",
  tags = { Skill.Compulsory,Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

nzjinhnziok:addEffect(fk.DamageInflicted, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
  return player==target and player:hasSkill(nzjinhnziok.name) and S.hasTsziukzzyit(player,"mxiqquns")
  end,
  on_use = function(self, event, target, player, data)
    S.preventDamage({damageData=data,skillName=nzjinhnziok.name})  --skill??
  end,
})


return nzjinhnziok

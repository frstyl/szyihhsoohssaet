local ljinsssik = fk.CreateSkill {
  name = "#ljinsssik",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["ljinsssik"] = "吝嗇",
  [":ljinsssik"] = "伱存牌數+2,伱越過段/轉前,伱可發動,防止之,伱流失1體力,",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 
ljinsssik:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(ljinsssik.name) then
      return 2
    end
  end,
})

ljinsssik:addEffect(fk.EventPhaseSkipping, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(piktssaes.name)
    and data.skipped
  end,
  on_use = function(self, event, target, player, data)
    data.skipped=false
    player.room:loseHp(player,1,ljinsssik.name,player)
  end,
})

ljinsssik:addEffect(fk.BeforeTurnOver, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(piktssaes.name)
    and data.faceup
    and not data.prevented
  end,
  on_use = function(self, event, target, player, data)
    data.prevented=true
    player.room:loseHp(player,1,ljinsssik.name,player)
  end,
})

return ljinsssik

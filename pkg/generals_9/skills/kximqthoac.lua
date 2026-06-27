local kximqthoac = fk.CreateSkill {
  name = "kximqthoac",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["kximqthoac"] = "金湯",
  -- [":kximqthoac"] = "鎖恆續效果.當伱受傷旹,若伱體力值小于2且傷害爲无屬傷害,防止之;若伱體力值小于3且傷害值大于1,傷害值減至1",
  [":kximqthoac"] = "鎖定.當伱受傷旹,必發.防止之,肰後若此技能當轉發動次數大于:1,伱流失1體力.大于2,伱回1,此技能失效.伱轉始旹,恢復此技能",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kximqthoac:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(kximqthoac.name)
  end,
  on_use = function(self, event, target, player, data)
    data:preventDamage()
S.preventDamage({damageData=data,prevented=true, skillName=kximqthoac.name})
    if  player:usedSkillTimes(kximqthoac.name, Player.HistoryTurn) >1 then
      player.room:loseHp(player,1,kximqthoac.name)
    end
    if  player:usedSkillTimes(kximqthoac.name, Player.HistoryTurn) >2 then
      player.room:recover{
            who = player,
            num = 1,
            recoverBy = player,
            skillName = kximqthoac.name,
          }
      player.room:invalidateSkill(player, kximqthoac.name)
    end
  end,
})

kximqthoac:addEffect(fk.TurnStart, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(kximqthoac.name,true,true)
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:validateSkill(player, kximqthoac.name)
  end,
})
-- kximqthoac:addEffect(fk.DamageInflicted, {
--   anim_type = "defensive",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(kximqthoac.name)  and player.hp<3
--   end,
--   on_trigger = function(self, event, target, player, data)
--     if player.hp<2 and data.damageType==1 then
--       data:preventDamage()
--       -- return
--     else
--       if data.damage>1 then
--       data:changeDamage(1 - data.damage)
--       end
--     end
--   end,
-- })


return kximqthoac

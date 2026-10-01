local kximqthoac = fk.CreateSkill {
  name = "kximqthoac",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["kximqthoac"] = "金湯",
  -- [":kximqthoac"] = "當伱受傷旹,若伱體力值小于2且傷害爲无屬傷害,防止之;若伱體力值小于3且傷害值大于1,傷害值減至1",
  [":kximqthoac"] = "伱受傷旹,必發.防止之,若此技能1轉發動次數爲:2,伱流失2;3,伱回3,此技能失效至伱轉始旹｡➁伱死亾旹,伱可選擇1其它腳色發動,其得到此技能",

  ["#kximqthoac-choose"] = "金湯 選擇1腳色得到｢金湯｣",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kximqthoac:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(kximqthoac.name)
  end,
  on_use = function(self, event, target, player, data)
    event:setCostData(self,{n=1+player:usedSkillTimes(kximqthoac.name, Player.HistoryTurn)})
    return true
  end,
  on_use = function(self, event, target, player, data)
    S.preventDamage({damageData=data,prevented=true, skillName=kximqthoac.name})
    local times=event:getCostData(self).n
    if  times ==2 then
      player.room:loseHp(player,2,kximqthoac.name,player)
    end
    if  times ==3 then
      player.room:recover{
            who = player,
            num = 3,
            recoverBy = player,
            skillName = kximqthoac.name,
          }
      player.room:invalidateSkill(player, kximqthoac.name)
    end
  end,
})

kximqthoac:addEffect(fk.TurnStart, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(kximqthoac.name,true)
  end,
  on_refresh = function(self, event, target, player, data)
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
--           S.preventDamage({damageData=data,prevented=true, skillName=kximqthoac.name})
--       -- return
--     else
--       if data.damage>1 then
--       data:changeDamage(1 - data.damage)
--       end
--     end
--   end,
-- })


kximqthoac:addEffect(fk.Death, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(kximqthoac.name, false, true)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = room.alive_players
    local tos = room:askToChoosePlayers(player, {
      skill_name = kximqthoac.name,
      min_num = 1,
      max_num = 1,
      targets = targets,
      prompt = "#kximqthoac-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:handleAddLoseSkills(player, "-kximqthoac", nil, true, false)
	  room:handleAddLoseSkills(event:getCostData(self).tos[1], "kximqthoac", nil, true, false)
  end,
})
return kximqthoac

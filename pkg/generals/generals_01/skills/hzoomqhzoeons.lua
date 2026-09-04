Fk:loadTranslationTable{
  ["hzoeomqhzoeons"] = "含恨",
  [":hzoeomqhzoeons"] = "自限:此將牌｡伱死亾旹,若1轉脚色不爲伱,伱与其交換武將牌",

  ["$hzoeomqhzoeons1"] = "我死自不妨 和伱軰爭不得了",
  ["$hzoeomqhzoeons2"] = "𠀀 大嫂 苦吁苦吁",
}

local hzoeomqhzoeons = fk.CreateSkill{
  name = "hzoeomqhzoeons",
  tags = {Skill.Proprietary},
  -- tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoeomqhzoeons:addAcquireEffect(function (self, player)
  if  not (
    (Fk.generals[player.general] and table.contains(Fk.generals[player.general]:getSkillNameList(), hzoeomqhzoeons.name))
   or (Fk.generals[player.deputyGeneral] and table.contains(Fk.generals[player.deputyGeneral]:getSkillNameList(), hzoeomqhzoeons.name))
)
  then
  player.room:handleAddLoseSkills(player, "-"..hzoeomqhzoeons.name, nil, false, true)  --不檢測?
  end
end)

hzoeomqhzoeons:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    if  target~=player  then  return end-- and player:hasSkill(hzoeomqhzoeons.name,true,true)
    local current =  player.room:getCurrent()
    if  (current==nil or current==player) then return end

      local deputy = false
      if Fk.generals[player.deputyGeneral] and table.contains(Fk.generals[player.deputyGeneral]:getSkillNameList(), hzoeomqhzoeons.name) then deputy=true end
      local main = false
      if Fk.generals[player.general] and table.contains(Fk.generals[player.general]:getSkillNameList(), hzoeomqhzoeons.name) then main=true end
      
      if  (main or deputy) then
        event:setCostData(self,{current=current,main=main,deputy=deputy})
        return true
      end
    
  end,
  on_trigger= function(self, event, target, player, data)  --兩个將昰武大?
    local current=event:getCostData(self).current
    local deputy = event:getCostData(self).deputy
    local main = event:getCostData(self).main
    local exe=function(isdeputy)

      local togeneral = isdeputy and current.deputyGeneral or current.general
      local playergeneral = isdeputy and player.deputyGeneral or player.general
      player.room:changeHero(current, playergeneral, false, isdeputy, true)
      player.room:changeHero(player, togeneral, false, isdeputy, true)
    end
    if main then exe () end
    if deputy then exe (true) end
  end,
})


return hzoeomqhzoeons

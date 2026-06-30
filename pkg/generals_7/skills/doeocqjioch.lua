local doeocqjioch = fk.CreateSkill {
  name = "doeocqjioch",
}

Fk:loadTranslationTable{
["doeocqjioch"] = "騰涌",  --騰涌
[":doeocqjioch"] = "當一角色受到火傷旹,伱可預打出1牌,防止之.當一角色受到非傳導雷傷後,伱可打出1牌發動.除該角色与伱全體角色受到1无源雷傷",
["#doeocqjioch-fire"]="騰涌 打出1牌  防止 %src 所受傷害",
["#doeocqjioch-thunder"]="騰涌 %src 受到雷傷 伱可打出1基本牌  連鎖其它角色",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

doeocqjioch:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(doeocqjioch.name) 
    and data.damageType == fk.FireDamage
    and not player:isNude() 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards =  S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = doeocqjioch.name,
		  cancelable = true,
          pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
     end)}),
      prompt = "#doeocqjioch-fire:"..target.id,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,event:getCostData(self).cards,doeocqjioch.name)

    S.preventDamage({damageData=data,skillName=doeocqjioch.name})  --skill??
  end,
})

doeocqjioch:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(doeocqjioch.name) 
    and data.damageType == fk.ThunderDamage
    and not data.chain
    and not player:isKongcheng() 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards =  S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = false,
		  skill_name = doeocqjioch.name,
		  cancelable = true,
      -- pattern = ".|.|.|.|.|basic",  ---koaz-- ssaet,szjemh,nziuk,tsiuh
          pattern=".",
          prompt = "#doeocqjioch-thunder:"..target.id,
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,event:getCostData(self).cards,doeocqjioch.name)
    for _, p in ipairs(room:getOtherPlayers(player,true))  do --當前轉
      if  p~=target and not p.dead then
      room:damage{
        from = nil,
        to = p,
        damage = 1,
        damageType = fk.ThunderDamage,
        skillName = doeocqjioch.name,
        chain =true,
      }
      end
    end
  end,
})

return doeocqjioch

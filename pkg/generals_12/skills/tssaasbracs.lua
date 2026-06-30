local tssaasbracs = fk.CreateSkill {
  name = "tssaasbracs",
}

Fk:loadTranslationTable{
["tssaasbracs"] = "詐病",
[":tssaasbracs"] = "當伱受傷旹,若伱已記錄其名(牌或技能),防止傷害,否則伱可發動,伱流失1體力,防止此傷害,(未死)記錄其名.",
-- [":tssaasbracs"] = "當伱{受傷/成爲其它角色牌目幖旹}伱可發動,伱流失1體力,{防止此傷害,伱獲得1護甲/伱迻除目幖.,本局額定手牌數+1},",

["@[:]tssaasbracs"] = "詐病",

["#tssaasbracs-invoke"]="詐病 流失1體力  防止 %arg傷害併記錄之",

-- ["#tssaasbracs-invoke"]="詐病 流失1體力  迻除 %src 所用 %arg 目幖 %dest ",
-- ["#tssaasbracs-discard"]="詐病 弃%src 1牌 ",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- tssaasbracs:addEffect(fk.TargetConfirmed, {
--   anim_type = "defensive",
--   can_trigger = function(self, event, target, player, data)
--     return  target==player
--     and data.from~=player
--     and player:hasSkill(tssaasbracs.name) 

--   end,
--   on_use = function(self, event, target, player, data)
--     player.room:loseHp(player, 1, tssaasbracs.name,player)
--     data:cancelTarget(target)
--     room:addPlayerMark(player, MarkEnum.AddMaxCardsInTurn,1)
--   end,
-- })

tssaasbracs:addLoseEffect (function (self, player)
    player.room:setPlayerMark(player,"@[:]tssaasbracs",0) 
end)

tssaasbracs:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_refresh = function(self, event, target, player, data)
    if  target==player 
    --and  player:hasSkill(tssaasbracs.name) --需要技能?
    and  not data.prevented then
      local name=""
      if data.card then name=data.card.trueName 
      elseif data.skillName then
        name = data.skillName
      else
        return 
      end
    return table.contains(player:getTableMark("@[:]tssaasbracs"), name)
    end
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = tssaasbracs.name }
    S.preventDamage({damageData=data,skillName=tssaasbracs.name})
  end,
  can_trigger = function(self, event, target, player, data)
    return  target==player and not data.prevented
    and player:hasSkill(tssaasbracs.name) 
  end,
  on_cost= function(self, event, target, player, data)
      local name=""
      if data.card then name=data.card.trueName 
      elseif data.skillName then
        name = data.skillName
      else
        name=nil 
      end
    if player.room:askToSkillInvoke(player, {
      skill_name = tssaasbracs.name,
      prompt = "#tssaasbracs-invoke:::"..name or "unknow",
    })  then
      event:setCostData(self,{name=name})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:loseHp(player, 1, tssaasbracs.name,player)
    if player.dead then return end
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = tssaasbracs.name }
    S.preventDamage({damageData=data,skillName=tssaasbracs.name})
    if event:getCostData(self).name==nil then return end
    player.room:addTableMark(player,"@[:]tssaasbracs",event:getCostData(self).name)
  end,
})

return tssaasbracs

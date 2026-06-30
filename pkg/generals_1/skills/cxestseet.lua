local cxestseet = fk.CreateSkill {
  name = "cxestseet",
}

Fk:loadTranslationTable{
["cxestseet"] = "義節",  --誼
[":cxestseet"] = "➀當一角色受到A傷害旹伱可發動,伱流失1體力,防止此傷害,肰後伱選擇令A獲得1護甲或抽2.➁當伱死亾旹,伱可選1其它角色發動,伱將全部牌交与該角色,其回1(无牌亦可發動)",

["#cxestseet-invoke"]="義節  %src 受傷 是否流失1體力 防止此傷害",
["#cxestseet-choose"]="義節  令 %src 執行",
["draw2"]="抽2",
["shield1"]="獲得1護甲",

["#cxestseet-choose"]="義節  將全部牌交予1其它角色 令其回1",

["$cxestseet1"] = "弓弩叢中逃性命 刀槍林裏救英雄",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cxestseet:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(cxestseet.name) 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = cxestseet.name,
      prompt = "#cxestseet-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:loseHp(player,1,cxestseet.name,player)
    S.preventDamage({damageData=data,skillName=cxestseet.name})
    if data.to.dead or player.dead then return end
    local choice= room:askToChoice(player, { choices = {"draw2","shield1"}, skill_name = cxestseet.name,       prompt = "#cxestseet-choose:"..data.to.id,})
    
    if choice=="draw2" then 
      data.to:drawCards(2, cxestseet.name)
    else
    room:changeShield(data.to,1)
    end
    -- room:changeShield(data.to,1)
    -- if  data.to.dead then return  end
    -- data.to:drawCards(1, cxestseet.name)
  end,
})

cxestseet:addEffect(fk.Death, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(cxestseet.name, false, true)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = room.alive_players
    local to = room:askToChoosePlayers(player, {
      skill_name = cxestseet.name,
      min_num = 1,
      max_num = 1,
      targets = targets,
      prompt = "#cxestseet-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    room:moveCardTo(player:getCardIds("he"), Player.Hand, to, fk.ReasonGive, cxestseet.name, nil, false, player.id)
    if to:isWounded() and not to.dead then
      room:recover{
        who = to,
        num = 1,
        recoverBy = player,
        skillName = cxestseet.name,
      }
    end
    player:drawCards(2,cxestseet.name)
  end,
})

return cxestseet

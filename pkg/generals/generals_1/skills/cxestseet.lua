local cijsljet = fk.CreateSkill {
  name = "cijsljet",
}

Fk:loadTranslationTable{
["cijsljet"] = "毅烈",  --誼
[":cijsljet"] = "一脚色受到傷害旹伱可發動,伱流失1體力,防止此傷害,肰後伱選擇令A獲得1護甲或抽1.",

["#cijsljet-invoke"]="毅烈  %src 受傷 是否流失1體力 防止此傷害",
["#cijsljet-choose"]="毅烈  令 %src 執行",
["draw2"]="抽2",
["shield1"]="獲得1護甲",

["#cijsljet-choose"]="毅烈  將全部牌交予1其它脚色 令其回1",

["$cijsljet1"] = "弓弩叢中逃性命 刀槍林裏救英雄",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cijsljet:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(cijsljet.name) 
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = cijsljet.name,
      prompt = "#cijsljet-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:loseHp(player,1,cijsljet.name,player)
    S.preventDamage({damageData=data,skillName=cijsljet.name})
    if data.to.dead or player.dead then return end
    local choice= room:askToChoice(player, { choices = {"draw2","shield1"}, skill_name = cijsljet.name,       prompt = "#cijsljet-choose:"..data.to.id,})
    
    if choice=="draw2" then 
      data.to:drawCards(1, cijsljet.name)
    else
    room:changeShield(data.to,1)
    end
    -- room:changeShield(data.to,1)
    -- if  data.to.dead then return  end
    -- data.to:drawCards(1, cijsljet.name)
  end,
})



return cijsljet

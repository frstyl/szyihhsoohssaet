local ttxinskfan = fk.CreateSkill({
  name = "ttxinskfan",
})

Fk:loadTranslationTable{
  ["ttxinskfan"] = "鎮關",
  [":ttxinskfan"] = "伱攻程內其它脚色起動<a href='AttackCard'>進攻牌</a>旹,伱可發動,其選擇➀起動无效➁對伱起動虛擬｢鬥將｣.",


  ["#ttxinskfan-invoke"] = "觀陣:%dest 起動 %arg 伱可發動",
  ["#ttxinskfan-choose"] = "觀陣: 對 %src 虛擬起動鬥將",

  ["$ttxinskfan1"] = "伱昰太乙三才陣何足爲奇",
  ["$ttxinskfan2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


ttxinskfan:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(ttxinskfan.name) 
      -- and S.isAttackCard(data.card)  
      and player:inMyAttackRange(target)
  end,
  on_cost = function(self, event, target, player, data)
    local room = room
    if player.room:askToSkillInvoke(player, { 
      prompt = "#kvoanqddxins-invoke::" .. target.id .. ":" .. data.card:toLogString(),
      skill_name = ttxinskfan.name,
      })
    then
      event:setCostData(self, {tos={target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room

    if player.room:askToSkillInvoke(target, { 
      prompt = "#kvoanqddxins-choose::" .. player.id ,
      skill_name = ttxinskfan.name,
      })
    then 
      room:useVirtualCard("tous_tsiacs", nil,  target,{player}, ttxinskfan.name, true)
    else
      S.useNullify(data,player,ttxinskfan.name)
    end

  end,
})



return ttxinskfan

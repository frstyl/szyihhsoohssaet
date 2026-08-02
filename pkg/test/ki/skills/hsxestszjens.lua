local hsxestszjens = fk.CreateSkill({
  name = "hsxestszjens",
})

Fk:loadTranslationTable{
  ["hsxestszjens"] = "戲戰",
  [":hsxestszjens"] = "伱攻程內其它脚色起動<a href='AttackCard'>進攻牌</a>旹,伱可發動,其選擇➀此牌起動无效➁對伱起動虛擬｢鬥將｣.",


  ["#hsxestszjens-invoke"] = "觀陣:%dest 起動 %arg 伱可發動",
  ["#hsxestszjens-choose"] = "觀陣: 對 %src 虛擬起動鬥將",

  ["$hsxestszjens1"] = "伱昰太乙三才陣何足爲奇",
  ["$hsxestszjens2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


hsxestszjens:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(hsxestszjens.name) 
      -- and S.isAttackCard(data.card)  
      and player:inMyAttackRange(target)
  end,
  on_cost = function(self, event, target, player, data)
    local room = room
    if player.room:askToSkillInvoke(player, { 
      prompt = "#kvoanqddxins-invoke::" .. target.id .. ":" .. data.card:toLogString(),
      skill_name = hsxestszjens.name,
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
      skill_name = hsxestszjens.name,
      })
    then 
      room:useVirtualCard("tous_tsiacs", nil,  target,{player}, hsxestszjens.name, true)
    else
      S.useNullify(data,player,hsxestszjens.name)
    end

  end,
})



return hsxestszjens

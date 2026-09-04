local kujqdzeek = fk.CreateSkill {
  name = "kujqdzeek",
  -- tags = {Skill.Composite},
}

Fk:loadTranslationTable{
  ["kujqdzeek"] = "歸諔",
  [":kujqdzeek"] = "伱起動/發動旹,若其有旹段次數限制,伱可選擇一旹段B發動,此起動牌名/發動技能B次數記錄段淸零,｢歸諔｣失效B",

  ["kujqdzeek_phase"] = "段",
  ["kujqdzeek_turn"] = "轉",
  ["kujqdzeek_round"] = "輪",
  ["kujqdzeek_game"] = "局",


  ["$kujqdzeek1"] = "後發先至",

}

-- local U = require "packages/utility/utility"
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 


kujqdzeek:addEffect(fk.CardUsing, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    if  data.from==player  and player:hasSkill(kujqdzeek.name)  then
      for _,  scope in ipairs( Player.HistoryTable) do
        if data.card.skill:getMaxUseTime(player, scope, data.card, nil) then
          return true
        end
      end
    end
     
  end,
  on_cost = function(self, event, target, player, data)
    local all={"kujqdzeek_phase","kujqdzeek_turn", "kujqdzeek_round", "kujqdzeek_game",}
        local choice = player.room:askToChoice(player, {
       choices = all,
         skill_name = kujqdzeek.name,
         cancelable=true,
        })
        if choice~="Cancel" then 
          event:setCostData(self,{choice=table.indexOf(all,choice)})
          return true
        end
  end,
  on_use = function(self, event, target, player, data)
    local n =event:getCostData(self).choice
    player:setCardUseHistory(data.card.trueName, 0, n)
    local temp= { "-phase", "-turn", "-round", "" }
    player.room:invalidateSkill(player,kujqdzeek.name,temp[n],kujqdzeek.name)

  end,
})


kujqdzeek:addEffect(fk.SkillEffect, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    if   player:hasSkill(kujqdzeek.name) 
    and target  
    and data.skill:isPlayerSkill(target) 
    and target:hasSkill(data.skill:getSkeleton().name, true, true)
   then
      for _, scope in ipairs( Player.HistoryTable) do
        if data.skill:getMaxUseTime(player, scope) then
          return true
        end
      end
    end
     
  end,
  on_cost = function(self, event, target, player, data)
    local all={"kujqdzeek_phase","kujqdzeek_turn", "kujqdzeek_round", "kujqdzeek_game",}
        local choice = player.room:askToChoice(player, {
       choices = all,
         skill_name = kujqdzeek.name,
         cancelable=true,
        })
        if choice~="Cancel" then 
          event:setCostData(self,{choice=table.indexOf(all,choice)})
          return true
        end
  end,
  on_use = function(self, event, target, player, data)
    local n =event:getCostData(self).choice
    player:setSkillUseHistory(data.skill.name, 0, n)
    local temp= { "-phase", "-turn", "-round", "" }
    player.room:invalidateSkill(player,kujqdzeek.name,temp[n],kujqdzeek.name)

  end,
})
return kujqdzeek

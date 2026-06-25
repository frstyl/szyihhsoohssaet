local ssaacqmaach = fk.CreateSkill {
  name = "ssaacqmaach",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["ssaacqmaach"] = "生猛",
  [":ssaacqmaach"] = "當伱手牌數或體力值變化後,若其相等,伱可選1項發動.➀自攻程含有伱其它角色選1至多个,視爲伱對其使用猛虎下山➁伱抽1➂執行➀➁,此技能當轉失效",

  ["#ssaacqmaach-choose"] = "生猛 選擇目幖",
  ["ssaacqmaach-use"] = "生猛 視爲使用猛虎下山",

  ["$ssaacqmaach1"] = "龙战于野，其血玄黄。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec ={
  -- on_cost = function(self, event, target, player, data)
  --   local room=player.room

  --   local choice={"draw1","ssaacqmaach-use","Cancel"}
  --   if choice=room:room:askToChoice(player, {
  --     choices = choice,
  --     skill_name = ssaacqmaach.name,
  --     prompt = "#ssaacqmaach-choice",
  --   })
  --   if choice =="Cancel" then return end
  --   if choice="ssaacqmaach-use"  then
  --   local others = table.filter(room:getOtherPlayers(player), function(p) 
  --     return p:inMyAttackRange(player) 
  --   end)
  --   local tos = room:askToChoosePlayers(player, {
  --     min_num = 1,
  --     max_num = #others,
  --     targets = others,
  --     skill_name = ssaacqmaach.name,
  --     prompt = "#ssaacqmaach-choose",
  --     cancelable = true,
  --   })  
  --   if #tos>0 then 
  --     event:setCostData(self,{choice=choice,tos=tos})
  --     return true
  --   end
  -- end,
  on_cost = function(self, event, target, player, data)
      local yes, dat = player.room:askToUseActiveSkill(player, {
      skill_name = "ssaacqmaach_active",
      prompt = "#ssaacqmaach-choose",
      cancelable = true,
      skip = true,  --不執行
    })
    if yes and dat and dat.interaction~="Cancel" then
      event:setCostData(self,{choice=dat.interaction, tos= dat.targets})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    if event:getCostData(self).choice~="draw1" then --死不抽牌 但可用牌
      player.room:useVirtualCard("maach_hsooh_hzaah_ssaen", nil, player,event:getCostData(self).tos, ssaacqmaach.name, true)
    end
      if player.dead then return end 
    if event:getCostData(self).choice~="ssaacqmaach-use" then
      player:drawCards(1,ssaacqmaach.name)
    end
    if event:getCostData(self).choice=="both" then
      S.invalidateSkill(player,ssaacqmaach.name,"-turn")
    end
  end,
}

ssaacqmaach:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(ssaacqmaach.name) or player:getHandcardNum()~=player.hp then return false end
    for _, move in ipairs(data) do
      if move.to  and  move.to ==player and move.toArea == Player.Hand then  --防止?
        return true
      end
      if move.from  and  move.from ==player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerHand  then
              return true
          end
        end
      end
    end
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})

ssaacqmaach:addEffect(fk.HpChanged, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return data.who==player and data.num~=0 and not data.prevented 
    and player:hasSkill(ssaacqmaach.name) and player:getHandcardNum()==player.hp
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})

return ssaacqmaach

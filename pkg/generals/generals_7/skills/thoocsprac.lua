local thoocsprac = fk.CreateSkill {
  name = "thoocsprac",
}

Fk:loadTranslationTable{
  ["thoocsprac"] = "統兵",
  [":thoocsprac"] = "伱致傷後/受傷後,伱可選1項令受傷或致傷脚色執行發動.➀將手牌抽至自身體力上限➁手牌弃至自身體力數.因統兵所抽牌不計入次數限制",  --丈八 --削不計入次數

  ["thoocsprac-draw-self"] = "伱 抽牌至體力上限",
  ["thoocsprac-discard-self"] = "伱 手牌弃至體力數",
  ["thoocsprac-draw"] = "令 %src 抽牌至體力上限",
  ["thoocsprac-discard"] = "令 %src 手牌弃至體力數",

  ["#thoocsprac-todiscard"] = "弃 %arg 手牌",

  ["@@thoocsprac-inhand"] = "統兵",

  ["$thoocsprac1"] = "看伱等已是秊衰命䀆",
  ["$thoocsprac2"] = "汝昰斯未聽過我李成聞達之威名无"
}

local spec = {
  anim_type = "drawcard",
  -- can_trigger = function(self, event, target, player, data)
  --   return (data.from == player or data.to == player)
	-- and player:hasSkill(thoocsprac.name)
  -- end,
  on_cost = function(self, event, target, player, data)
    local to
    local choices
   
    
    if data.from==data.to then
      choices={"thoocsprac-draw-self", "thoocsprac-discard-self", "Cancel"}
    else 
      to=data.from~=player and data.from   or data.to
      choices={"thoocsprac-draw-self", "thoocsprac-discard-self",
      "thoocsprac-draw:"..to.id, "thoocsprac-discard:"..to.id, "Cancel",}
    end

    local choice = player.room:askToChoice(player, {
      choices = choices,
      skill_name = thoocsprac.name,
      prompt = "#thoocsprac-choose:",
      cancelable=true,
    })
    if choice ~= "Cancel" then
      local tos=choice:endsWith("-self") and {player} or {to}
      event:setCostData(self, {choice =string.find(choice,"draw") and "draw" or "discard" , tos=tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local to=event:getCostData(self).tos[1]
    local choice=event:getCostData(self).choice
    local room=player.room
    if  choice=="draw" then
      local n=to.maxHp-to:getHandcardNum()
      if n>0 then
          -- room:addSkill("extra_use")        
          -- room:addSkill("bypass_times")
          to:drawCards(n, thoocsprac.name, nil, {"@@thoocsprac-inhand",1,"extra_use-inhand",1})  --,"bypass_times-inhand",1
      end

    elseif  choice=="discard"   then
      local n=to:getHandcardNum()-to.hp
      if n>0 then
        player.room:askToDiscard(to, {
          min_num = n,
          max_num = n,
          include_equip = false,
          skill_name = thoocsprac.name,
          prompt = "#thoocsprac-todiscard:::"..n,
          cancelable = false,
          skip = false,
        })
      end
    end
  end,
}

thoocsprac:addEffect(fk.Damaged,  {
can_trigger = function(self, event, target, player, data)
  return  data.from == player and player:hasSkill(thoocsprac.name)   and self:isEffectable(player)
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})
thoocsprac:addEffect(fk.Damaged,  {
  can_trigger = function(self, event, target, player, data)
    return  data.to == player and player:hasSkill(thoocsprac.name)  and self:isEffectable(player)
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})


return thoocsprac

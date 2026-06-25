local tszjipmaach = fk.CreateSkill {
  name = "tszjipmaach",
}

Fk:loadTranslationTable{
  ["tszjipmaach"] = "執猛",
  [":tszjipmaach"] = "當伱對其它角色致傷旹,或伱受到其它角色傷旹,至多傷害值次,伱可選1項發動.➀伱抽1➁弃對方1.",

  ["tszjipmaach-choose"] = "執猛",
  ["draw1"] = "抽1",
  ["tszjipmaach-discard"] = "弃 %src 1牌",
  ["Cancel"] = "否",
}

local tszjipmaach_spec = {
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_cost = function(self, event, target, player, data)
    local to=event:getCostData(self).to
    
    local choice = player.room:askToChoice(player, {
      choices = {"draw1", "tszjipmaach-discard:"..to.id, "Cancel"},
      skill_name = tszjipmaach.name,
      prompt = "#tszjipmaach-choose:",
    })
    if choice ~= "Cancel" then
      event:setCostData(self, {choice = (choice), tos=choice~="draw1" and {to} or nil})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)

    if event:getCostData(self).choice=="draw1" then
      player:drawCards(1,tszjipmaach.name)
    else
      local to=event:getCostData(self).tos[1]
      local cid = player.room:askToChooseCard(player, { target = to, flag = "he", skill_name = tszjipmaach.name })
      player.room:throwCard({cid}, tszjipmaach.name, to, player)
    end
  end,
}



tszjipmaach:addEffect(fk.DamageCaused,{
  can_trigger = function(self, event, target, player, data)
    if  target == player and player:hasSkill(tszjipmaach.name) and data.to and data.to~=player then
            event:setCostData(self, { to=data.to})
      return true
    end
  end,
  trigger_times=tszjipmaach_spec.trigger_times,
  on_cost=tszjipmaach_spec.on_cost,
  on_use=tszjipmaach_spec.on_use,
  }   
) --

tszjipmaach:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(tszjipmaach.name) and data.from and data.from~=player then
            event:setCostData(self, { to=data.from})
      return true    
    end
  end,
  trigger_times=tszjipmaach_spec.trigger_times,
  on_cost=tszjipmaach_spec.on_cost,
  on_use=tszjipmaach_spec.on_use,
})



return tszjipmaach

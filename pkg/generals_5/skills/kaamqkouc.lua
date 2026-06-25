local kaamqkouc = fk.CreateSkill {
  name = "kaamqkouc",
}

Fk:loadTranslationTable{
  ["kaamqkouc"] = "監工",
  [":kaamqkouc"] = "任意角色越過段或轉後,額外段或轉始旹,伱可選1項發動.➀其抽1➁伱弃其1(需其有牌)➂其使用1牌(可虛擬可轉化有距離次數限制計次數),若不使用則展示全部牌",

  ["#kaamqkouc_invoke"] = "監工 對 %src 發動",

  ["use1"] = "使用一牌",
}


-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={

  on_cost = function(self, event, target, player, data)
    local all_choices={"draw1", "discard1","use1", "Cancel"}
    local choices = {}
    if target:isNude() then choices={"draw1","use1", "Cancel"} else choices=all_choices end
    local choice =player.room:askToChoice(player, {
      choices = choices,
      skill_name = kaamqkouc.name,
      all_choices=all_choices,
      prompt="#kaamqkouc_invoke:"..target.id,
    })
    if choice ~= "Cancel" then
      event:setCostData(self, {choice = choice,tos={target}})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    local choice=event:getCostData(self).choice
    if choice=="draw1" then
      target:drawCards(1,kaamqkouc.name)
    elseif choice=="discard1" then
      local cid = room:askToChooseCard(player, { target = target, flag = "he", skill_name = kaamqkouc.name })
      room:throwCard({cid}, kaamqkouc.name, target, player)
    else
      local params={
        cancelable=false,
        skip=false,
        skill_name=kaamqkouc.name,
        extra_data={
          bypass_distances=false,
          bypass_times=false,
          extraUse=false,
      },
      }
      local use =room:askToPlayCard(target, params)
      if not use then target:showCards(player:getCardIds("he")) end
    end
  end,
}


kaamqkouc:addEffect(fk.EventPhaseStart,{
  can_trigger= function(self, event, target, player, data)
    return  player:hasSkill(kaamqkouc.name)
    and 
    data.reason~="game_rule"
  end,
  on_cost= spec.on_cost,
  on_use= spec.on_use,
})

kaamqkouc:addEffect(fk.TurnStart,{
  can_trigger= function(self, event, target, player, data)
    return  player:hasSkill(kaamqkouc.name)
    and 
    data.reason~="game_rule"
  end,
  on_cost= spec.on_cost,
  on_use= spec.on_use,
})

kaamqkouc:addEffect(fk.EventPhaseSkipped,{
  can_trigger= function(self, event, target, player, data)
    return  player:hasSkill(kaamqkouc.name)
  end,
  on_cost= spec.on_cost,
  on_use= spec.on_use,
})

kaamqkouc:addEffect(fk.TurnedOver,{  --TurnedOver==TurnedOver
  can_trigger= function(self, event, target, player, data)
    return  player:hasSkill(kaamqkouc.name)
  end,
  on_cost= spec.on_cost,
  on_use= spec.on_use,
})

kaamqkouc:addEffect(fk.ChainStateChanged,{  --TurnedOver==TurnedOver
  can_trigger= function(self, event, target, player, data)
    return  player:hasSkill(kaamqkouc.name)
  end,
  on_cost= spec.on_cost,
  on_use= spec.on_use,
})

return kaamqkouc

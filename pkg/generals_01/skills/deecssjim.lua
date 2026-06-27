local deecssjim = fk.CreateSkill {
  name = "deecssjim",
  tags={Skill.Compulsory}
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["deecssjim"] = "定心",
  [":deecssjim"] = "鎖定｡咒術附加或觸發前,必發｡其概率改爲必肰｡伱死亾旹必發｡解除全體角色咒術｡",
}

local spec ={
  -- anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)
    return player:hasSkill(deecssjim.name)
  end,
  on_trigger = function(self, event, target, player, data)
    data.probability=nil
  end,
}
deecssjim:addEffect(S.BeforeTsziukzzyitTrigger, spec)
deecssjim:addEffect(S.BeforeTsziukzzyitAdd, spec)

deecssjim:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(deecssjim.name,false,true)
  end,
  can_use= function(self, event, target, player, data)
    for _,p in ipairs(room.players) do
      S.removeTsziukzzyit(p)
    end
  end,
})
return deecssjim

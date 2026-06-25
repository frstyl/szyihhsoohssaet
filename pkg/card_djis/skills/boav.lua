local equipSkill = fk.CreateSkill {
  name = "#boav_skill",
  tags = { Skill.Compulsory },
  attached_equip = "boav",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect(fk.PreCardEffect, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(equipSkill.name) 
    and not data.nullified
    and  table.contains({"ssaet", "maach_hsooh_hzaah_ssaen", "ttis_tsiuh_szjet_jjen"}, data.card.name)
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.use, data)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:broadcastPlaySound("./packages/maneuvering/audio/card/boav")
    room:setEmotion(player, "./packages/maneuvering/image/anim/boav")
    -- data.nullified = true
    S.effectNullify(data,player,equipSkill.name)
    -- room.logic:trigger("CardEffectNullified", to, data)
  end,
})

equipSkill:addEffect(fk.DamageInflicted, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(equipSkill.name) and data.damageType == fk.FireDamage
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.useData, data.effectData)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:broadcastPlaySound("./packages/maneuvering/audio/card/boavburn")
    room:setEmotion(player, "./packages/maneuvering/image/anim/boavburn")
    S.changeDamage({damageData=data,num=1,skillName=equipSkill.name})
  end,
})


return equipSkill

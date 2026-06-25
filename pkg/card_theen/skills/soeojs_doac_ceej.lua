local equipSkill = fk.CreateSkill {
  name = "#soeojs_doac_ceej_skill",
  tags = { Skill.Compulsory },
  attached_equip = "soeojs_doac_ceej",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect(fk.PreCardEffect, {
  -- mute = true,
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(equipSkill.name) and data.card.trueName=="ssaet"
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.use, data)
    and
      (
        data.card.name=="fire__ssaet" 
      or data.card.name=="thunder__ssaet"
      or ( data.card:isVirtual() )
      -- or data.card.name ~= Fk:getCardById(data.card.id, true).name
    )
  end,
  on_use = function(self, event, target, player, data)
    -- local room = player.room
    -- room:broadcastPlaySound("./packages/maneuvering/audio/card/vine")
    -- room:setEmotion(player, "./packages/maneuvering/image/anim/vine")
    S.effectNullify(data,player,equipSkill.name)
    -- data.nullified = true
  end,
})

equipSkill:addEffect(fk.Damaged, {
  -- mute = true,
  can_trigger = function(self, event, target, player, data)
    return  data.to == player and player:hasSkill(equipSkill.name)
	
  and data.from and data.from~=player   
	and data.card and data.card.trueName=="ssaet"

	-- return true
  end,
  on_use = function(self, event, target, player, data)
    -- local room = player.room
    -- room:broadcastPlaySound("./packages/maneuvering/audio/card/vineburn")
    -- room:setEmotion(player, "./packages/maneuvering/image/anim/vineburn")
    if #data.from:getEquipments(Card.SubtypeWeapon) > 0 then
    player.room:throwCard(data.from:getEquipments(Card.SubtypeWeapon),equipSkill.name,data.from,data.from)  --自弃
    end
  end,
})

return equipSkill

local equipSkill = fk.CreateSkill {
  name = "#tou_miu_skill",
  tags = { Skill.Compulsory },
  attached_equip = "tou_miu",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return target == player 
    -- and player:hasSkill(equipSkill.name)
    and data.damage > 1
    and S.hasEquip(player,equipSkill.attached_equip)  
    and Fk.skills[equipSkill.name]:isEffectable(data.to)    
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.useData, data.effectData)
  end,
  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=(1-data.damage),skillName=equipSkill.name})
  end,
})

equipSkill:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if player.dead or not player:isWounded() or not Fk.skills[equipSkill.name]:isEffectable(player) then return end
    local n =0
    for _, move in ipairs(data) do
      if move.from == player then
        for _, info in ipairs(move.moveInfo) do
          local card = info.beforeCard
          if info.fromArea == Card.PlayerEquip and card.name == equipSkill.attached_equip then
              local effectEvent = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect, true)
              if effectEvent then
                local dat=effectEvent.data
                if not S.isIgnoreArmorFromAToB(move.proposer, player,dat.card,dat.use,dat) then
                  n=n+1
                end
              else
                if not S.isIgnoreArmorFromAToB(move.proposer, player) then
                  n=n+1
                end
              end
          end

        end
      end
    end
    if n>0 then
      event:setCostData(self,{n=n})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:recover{
      who = player,
      num = event:getCostData(self).n,  --多張?
      recoverBy = player,
      skillName = equipSkill.name,
    }
  end,
})


return equipSkill

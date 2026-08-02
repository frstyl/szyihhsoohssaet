local equipSkill = fk.CreateSkill {
  name = "#tou_miu_skill",
  tags = { Skill.Compulsory },
  attached_equip = "tou_miu",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return target == player 
    and player:hasSkill(equipSkill.name)
    and data.damage > 1
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.useData, data.effectData)
  end,
  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=(1-data.damage),skillName=equipSkill.name})
  end,
})

equipSkill:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if player.dead or not player:isWounded() then return end
    for _, move in ipairs(data) do
      if move.from == player then
        for _, info in ipairs(move.moveInfo) do
          if info.fromArea == Card.PlayerEquip and Fk:getCardById(info.cardId).name == equipSkill.attached_equip then
              -- local e=player.room:getCurrentEvent().parent
            if Fk.skills[equipSkill.name]:isEffectable(player) then
               -- and not (move.proposer and  S.isIgnoreArmorFromAToB(move.proposer,player) )--牌?
              local effectEvent = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect, true)
              if effectEvent then
                local dat=effectEvent.data
                return not S.isIgnoreArmorFromAToB(move.proposer, player,dat.card,dat.use,dat)
              else
                return not S.isIgnoreArmorFromAToB(move.proposer, player)
              end
            end
          end
        end
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:recover{
      who = player,
      num = 1,
      recoverBy = player,
      skillName = equipSkill.name,
    }
  end,
})


return equipSkill

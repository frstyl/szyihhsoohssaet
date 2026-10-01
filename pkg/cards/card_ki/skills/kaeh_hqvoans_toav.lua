local equipSkill = fk.CreateSkill {
  name = "#kaeh_hqvoans_toav_skill",
  tags = { Skill.Compulsory },
  attached_equip = "kaeh_hqvoans_toav",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect("targetmod", {
  residue_func = function (self, player, skill, scope, card, to)
    -- if player:hasSkill(equipSkill.name) and 
    if     player
    and  card and card.trueName == "ssaet"
    and S.hasEquip(player,equipSkill.attached_equip)
    and not S.isIgnoreArmorFromAToB(to,player,card)
    and  Fk.skills[equipSkill.name]:isEffectable(player)    
    then 
      -- local n =#table.filter(S.getEquips(player, Card.SubTypeWeapon),function(c) return c.name==equipSkill.attached_equip end) 
         
        return 2*S.hasEquip(player,equipSkill.attached_equip)
    end
  end,
})

equipSkill:addEffect(fk.CardUsing, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(equipSkill.name) and
      data.card.trueName == "ssaet" and not data.extraUse and player:usedCardTimes("ssaet", Player.HistoryPhase) > 1
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:broadcastPlaySound("./packages/standard_cards/audio/card/kaeh_hqvoans_toav")
    room:setEmotion(player, "./packages/standard_cards/image/anim/kaeh_hqvoans_toav")
    room:sendLog{
      type = "#InvokeSkill",
      from = player.id,
      arg = "kaeh_hqvoans_toav",
    }
  end,
})

return equipSkill

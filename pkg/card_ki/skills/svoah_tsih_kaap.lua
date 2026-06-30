local equipSkill = fk.CreateSkill {
  name = "#svoah_tsih_kaap_skill",
  tags = { Skill.Compulsory },
  attached_equip = "svoah_tsih_kaap",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSkill:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(equipSkill.name) and
    data.card.trueName == "ssaet" 
    and not S.isIgnoreArmorFromAToB(data.from, data.to, data.card, data.use, data)
  end,
  on_use = function(self, event, target, player, data)
      local cards =  S.askToPlayCard(data.from, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = equipSkill.name,
        cancelable = true,
        prompt = "#svoah_tsih_kaap_skill-discard:"..data.to.id.."::" .. data.card:toLogString(),
        pattern=".|.|"..data.card:getSuitString(false),
        skip = false
      })    
      -- if not Fk:getCardById(cards[1]):compareSuitWith(data.card) then
      if #cards<1 then
        S.effectNullify(data,player,equipSkill.name)
      end
  end
})

return equipSkill

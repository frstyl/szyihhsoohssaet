local siuqdzjecs = fk.CreateSkill {
  name = "siuqdzjecs",
  tags={Skill.Limit}
}

Fk:loadTranslationTable{
  ["siuqdzjecs"] = "修淨",
  [":siuqdzjecs"] = "其它脚色A轉始旹,伱可將1裝僃牌置入其裝僃欄發動｡伱弃置A伏區牌",

  ["#siuqdzjecs-invoke"] = "修淨： 裝僃牌置入 %src 裝僃欄",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

siuqdzjecs:addEffect(fk.TurnStart, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(siuqdzjecs.name) and target~=player
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local ids =table.filter(player:getCardIds("he"),function(id)
    return S.getCardTypeByName(Fk:getCardById(id).trueName)== 3 
     and #target:getAvailableEquipSlots(Fk:getCardById(id).sub_type)>0
    end)
    if #ids==0 then return end
    local cards = room:askToCards(player,{
      min_num = 1,
      max_num = 1,
      skill_name = siuqdzjecs.name,
      pattern = tostring(Exppattern{ id = ids}),
      prompt = "#siuqdzjecs-ask::"..target.id,
      cancelable = true,
    })
    if #cards>0 then
      event:setCostData(self, {cards = cards, tos={target}})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    local to = event:getCostData(self).tos[1]
    room:moveCardIntoEquip(to, event:getCostData(self).cards, "siuqdzjecs", true, player)
    local cards = to:getCardIds("j")
    if #cards>0 then
      room:throwCard(cards,"siuqdzjecs",to,player)
    end
  end,
})


return siuqdzjecs

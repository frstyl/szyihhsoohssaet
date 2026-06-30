local hzeepkoot = fk.CreateSkill {
  name = "hzeepkoot",
}

Fk:loadTranslationTable{
["hzeepkoot"] = "俠骨",
[":hzeepkoot"] = "當一其色受到傷害旹伱預打出1裝僃或流失1體力發動,若此傷害:大于1,減爲1,等于1,減1",
["#hzeepkoot-ask"]="俠骨 打出1裝僃或流失1體力 減少%src 所受傷害",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


hzeepkoot:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hzeepkoot.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "choose_cards_skill", 
      prompt = "#hzeepkoot-ask:"..data.to.id,
      cancelable = true, 
      extra_data = {
        num = 1,
        min_num = 0,
        include_equip = true,
        skillName = hzeepkoot.name,
        pattern = tostring(Exppattern{ id = table.filter(player:getCardIds("he"), function (id)
          local c= Fk:getCardById(id)
      return c.type == Card.TypeEquip and not player:prohibitResponse(c)
     end)}),
      }, 
      no_indicate = false,
      skip=true,
    })
    if yes then 
      event:setCostData(self, {tos={data.to},cards = ret.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards=event:getCostData(self).cards
    if  cards[1] then
      room:responseCard({
          card=Fk:getCardById(cards[1]),
          from=player,
          attachedSkillAndUser={muteCard=true},
        })
    else
      room:loseHp(player,1,hzeepkoot.name,player)
    end

      S.changeDamage({damageData=data,num=(data.damage ==1 and -1 or 1-data.damage),skillName=hzeepkoot.name})
      -- data:changeDamage(-1)

  end,
})

return hzeepkoot

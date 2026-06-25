local hqoomszjip = fk.CreateSkill {
  name = "hqoomszjip",
}

Fk:loadTranslationTable{
["hqoomszjip"] = "暗襲",
[":hqoomszjip"] = "當一其他角色受到錦囊傷害後,伱預打出1紅色牌選擇1其它角色體力值不小于伱者發動,伱予其1傷",
["#hqoomszjip-invoke"]="暗襲 弃1紅色牌与1角色1傷",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos"
local S = require "packages/szyihhsoohssaet/szyih_guos"


hqoomszjip:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hqoomszjip.name) 
    and data.card and data.card.type==Card.TypeTrick
    and not player:isNude() 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local tos, cards = room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      min_num = 1,
      max_num = 1,
      targets = room:getOtherPlayers(player, false),
      pattern =tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
				return Fk:getCardById(id).Color == Card.Red and not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      include_equip=true,
      prompt = "#hqoomszjip-invoke",
      skill_name = hqoomszjip.name,
      cancelable = true,
      -- will_throw =true,
    })
    if #tos == 1 and #cards==1 then
      event:setCostData(self, {tos = tos, cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(player,event:getCostData(self).cards,hqoomszjip.name)
    local to =event:getCostData(self).tos[1]
    if to.dead then return end
    room:damage{
      from = player,
      to = to,
      damage = 1,
      damageType = fk.NormalDamage,
      skillName = hqoomszjip.name,
    }
  end,
})

return hqoomszjip

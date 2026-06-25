local bunqzjins = fk.CreateSkill {
  name = "bunqzjins",
}

Fk:loadTranslationTable{
["bunqzjins"] = "焚㶳",
[":bunqzjins"] = "當伱致傷➀无屬旹,伱可發動,改爲火傷➁火屬旹,伱可預選1手牌發動.伱置其入弃牌堆,印取1因勢利導",

["#bunqzjins-invoke"] = "焚㶳 伱對 %src 致傷 是否 轉爲火傷",
["#bunqzjins-choose"] = "焚㶳 選1手牌發動.其當轉內視爲因勢利導",

["@@bunqzjins-turn"] = "焚㶳",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

bunqzjins:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(bunqzjins.name) 
    and data.damageType == fk.NormalDamage 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room

    return room:askToSkillInvoke(player, {
      skill_name = bunqzjins.name,
      prompt = "#bunqzjins-invoke:"..data.to.id,
    }) 

  end,
  on_use = function(self, event, target, player, data)
    -- player.room:loseHp(player,1,bunqzjins.name)
    data.damageType = fk.FireDamage 

  end,
})


bunqzjins:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(bunqzjins.name) 
    and data.damageType == fk.FireDamage
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
      local cards = player.room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = bunqzjins.name,
        prompt = "#bunqzjins-choose",
        cancelable = true,
      })
      if #cards>0 then
        event:setCostData(self,{cards=cards})
        return true
      end
    end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:moveCards({
      ids = event:getCostData(self).cards,
      from = player,
      toArea = Card.DiscardPile,
      skillName = bunqzjins.name,
      moveReason = fk.ReasonRecast,
      proposer = player.id,
    })
    S.printKhouc(room,"hqjin_szjer_ljis_doavs", player, bunqzjins.name, 1)
    -- player.room:setCardMark(Fk:getCardById(event:getCostData(self).cards[1]) ,"@@bunqzjins-turn",1)
    -- Fk:filterCard(event:getCostData(self).cards[1],player)

  end,
})

-- bunqzjins:addEffect("filter", {
--   card_filter = function(self, to_select, player)
--     return to_select:getMark("@@bunqzjins-turn")>0
--   end,
--   view_as = function(self, player, to_select)
--     local card = Fk:cloneCard("hqjin_szjer_ljis_doavs", to_select.suit, to_select.number)
--     card.skillName = bunqzjins.name
--     return card
--   end,
-- })


-- bunqzjins:addEffect(fk.DamageCaused, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:hasSkill(bunqzjins.name) 
--     and (data.damageType == fk.NormalDamage 
--     or data.damageType == fk.FireDamage ) 
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     if data.damageType == fk.NormalDamage then
--      room:askToSkillInvoke(player, {
--       skill_name = bunqzjins.name,
--       prompt = "#bunqzjins-invoke:"..data.to.id,
--     }) 
--     return true
--     end

-- 		local cards = room:askToDiscard(player, {
-- 		  min_num = 1,
-- 		  max_num = 1,
-- 		  include_equip = false,
-- 		  skill_name = bunqzjins.name,
-- 		  cancelable = true,
--       pattern = ".",
--       prompt = "#bunqzjins-discard:"..data.to:getNextAlive().id,
-- 		  skip = true,
-- 		})
--     if #cards ~= 0 then
--       event:setCostData(self, {cards = cards})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     if data.damageType == fk.NormalDamage then
--       --旹機?
--       data.damageType = fk.FireDamage 
--       return
--     end
--     room:throwCard(event:getCostData(self).cards,bunqzjins.name,player,player)
--     data.damage =  data.damage+1 

--     -- player.room:useVirtualCard("hsvoah_kouc", nil, player,data.to:getNextAlive(),  bunqzjins.name, true)
--   end,
-- })


return bunqzjins

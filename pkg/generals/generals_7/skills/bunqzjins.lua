local bunqzjins = fk.CreateSkill {
  name = "bunqzjins",
}

Fk:loadTranslationTable{
["bunqzjins"] = "焚㶳",
[":bunqzjins"] = "伱致傷旹若其➀无屬,伱可發動,改爲火傷➁火屬,伱可選擇1手牌發動｡褈鑄爲｢因勢利導｣",

["#bunqzjins-invoke"] = "焚㶳 伱對 %src 致傷 是否 轉爲火傷",
["#bunqzjins-choose"] = "焚㶳 打出1手牌 獲得 ｢因勢利導｣",

["@@bunqzjins-turn"] = "焚㶳",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

bunqzjins:addEffect(fk.DamageInflicted, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from==player and player:hasSkill(bunqzjins.name) 
    and (data.damageType == fk.NormalDamage or data.damageType == fk.FireDamage )
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if data.damageType == fk.NormalDamage then
      if room:askToSkillInvoke(player, {
        skill_name = bunqzjins.name,
        prompt = "#bunqzjins-invoke:"..data.to.id,
      }) 
      then
        event:setCostData(self, {choice = fk.NormalDamage })
        return true
      end
    else
      local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = bunqzjins.name,
        cancelable = true,
        pattern = ".",
        prompt = "#bunqzjins-choose",
        skip = true,
      })
      if #cards ~= 0 then
        event:setCostData(self, {choice = fk.FireDamage ,cards = cards}) --无目幖 tos={target}
        return true
      end
    end

  end,
  on_use = function(self, event, target, player, data)
    if event:getCostData(self).choice==fk.NormalDamage then
    data.damageType = fk.FireDamage 
    else
      -- S.playCard(event:getCostData(self).cards, bunqzjins.name,player)
      if player.dead then return end
      local room=player.room
      -- room:moveCards({
      --   ids = S.getKhouc(1,"hqjin_szjer_ljis_doavs"),
      --   to = player,
      --   toArea = Card.PlayerHand,
      --   moveReason = fk.ReasonJustMove,
      --   proposer = player,
      --   skillName = bunqzjins.name,
      --   moveVisible = true,
      -- })
      room:moveCards({
        ids = event:getCostData(self).cards,
        to = nil,
        toArea = Card.DiscardPile,
        moveReason = fk.ReasonRecast,
        proposer = player,
        skillName = bunqzjins.name,
        moveVisible = true,
      })
      if player.dead then return end
      S.printKhouc(plyayer,1,bunqzjins.name,"hqjin_szjer_ljis_doavs")
      end

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


-- bunqzjins:addEffect(fk.DamageInflicted, {
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

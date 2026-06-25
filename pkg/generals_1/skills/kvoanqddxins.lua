local kvoanqddxins = fk.CreateSkill({
  name = "kvoanqddxins",
})

Fk:loadTranslationTable{
  ["kvoanqddxins"] = "觀陣",
  [":kvoanqddxins"] = "當其它角色使用<a href='AttackCard'>進攻牌</a>旹,伱可預打出1同花色牌發動,伱令此牌使用无效.",


  ["#kvoanqddxins-card"] = "觀陣:%dest 使用 %arg 伱可打出1同花色牌發令其无效",
  -- ["#kvoanqddxins-damage"] = "觀陣：伱受到 %arg 傷害 伱可弃1同花色牌發防止傷害",

  ["$kvoanqddxins1"] = "伱昰太乙三才陣何足爲奇",
  ["$kvoanqddxins2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


kvoanqddxins:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(kvoanqddxins.name) 
      and target ~= player 
      and data.card.suit~=Card.NoSuit
      and S.isAttackCard(data.card)  
      and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = room

    -- local cards = player.room:askToResponse(player,{ ---@type AskToUseCardParams
    --     skill_name = kvoanqddxins.name,
    --     pattern = '.|.|'.. data.card:getSuitString(),  --待
    --     prompt = "#kvoanqddxins-card::" .. target.id .. ":" .. data.card:toLogString(),
    --     cancelable = true,
		-- --   include_equip = true,
    --     -- event_data = effect  --kvoanqddxins
    --   })
    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
				return Fk:getCardById(id).suit == data.card.suit and not player:prohibitResponse(Fk:getCardById(id))
			end
			) }),
      prompt = "#kvoanqddxins-card::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {tos={target},cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room

    local cards=event:getCostData(self).cards

    -- room:responseCard({
		-- 		card=Fk:getCardById(cards[1]),
		-- 		from=player,
		-- 		attachedSkillAndUser={muteCard=true},
		-- 	})
    S.playCard(player,cards,kvoanqddxins.name)
    S.useNullify(data,player,kvoanqddxins.name)
  end,
})


-- kvoanqddxins:addEffect(fk.DamageInflicted, {
--   anim_type = "control",
--   can_trigger = function(self, event, target, player, data)
--     return
--       player:hasSkill(kvoanqddxins.name) 
--       and target == player 
--       and data.card
--       and data.card.suit~=Card.NoSuit
--       and not player:isNude()
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
-- 		local cards = room:askToDiscard(player, {
-- 		  min_num = 1,
-- 		  max_num = 1,
-- 		  include_equip = true,
-- 		  skill_name = kvoanqddxins.name,
-- 		  cancelable = true,
--       pattern = ".|.|"..data.card:getSuitString(),
--       prompt = "#kvoanqddxins-damage::".. data.card:toLogString(),
-- 		  skip = true,
-- 		})
--     if #cards ~= 0 then
--       event:setCostData(self, {cards = cards})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     room:preventDamage()
--   end,
-- })


return kvoanqddxins

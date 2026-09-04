local zzyinspiuc = fk.CreateSkill {
  name = "zzyinspiuc",
}

Fk:loadTranslationTable{
["zzyinspiuc"] = "順風",
[":zzyinspiuc"] = "一脚色A占卜牌生效後,伱可打出1牌与占卜牌同花者發動,伱予A 1火傷",


-- ["#zzyinspiuc-invoke"] = "順風 選擇目幖与 %arg牌",
["#zzyinspiuc-invoke"] = "順風:打出 %arg 牌,予 %dest 1火傷",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


zzyinspiuc:addEffect(fk.FinishJudge, {
  anim_type = "offensive",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(zzyinspiuc.name)
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = zzyinspiuc.name,
		  cancelable = true,
      pattern = ".|.|"..data.card:getSuitString(),
      prompt = "#zzyinspiuc-invoke::"..target.id..":"..data.card:getSuitString(true),
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards,tos={target}})
      return true
    end
  end,
  -- on_cost = function (self, event, target, player, data)

  --   local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
  --     min_card_num = 1,
  --     max_card_num = 1,
  --     include_equip=true,
  --     will_throw=false,
  --     min_num = 1,
  --     max_num = 1,
  --     targets = room:getOtherPlayers(player),  --
  --     -- targets=player.room.alive_players,
  --     pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
	--   local c=Fk:getCardById(id)
  --     return not player:prohibitResponse(c) and c.suit==data.card.suit
  --   end)}),
  --     skill_name = hsuohhsvah.name,
  --     prompt = "#hsuohhsvah-invoke:::"..data.card:getSuitString(),
  --     cancelable = true,
  --   })
	--     if #tos ==1 and #cards == 1 then
  --       event:setCostData(slef,{cards=cards,tos=tos})
	-- 	     return true
  --   end
  -- end,
  on_use = function (self, event, target, player, data)
    S.playCard(event:getCostData(self).cards,zzyinspiuc.name,player)
    player.room:damage{
        from = player,
        to = event:getCostData(self).tos[1],
        damage = 1,
        damageType=fk.FireDamage,
        skillName = zzyinspiuc.name,
      }
  end,
})

return zzyinspiuc

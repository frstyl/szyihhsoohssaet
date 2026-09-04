local soansdzoejs = fk.CreateSkill {
  name = "soansdzoejs",
}

Fk:loadTranslationTable{
["soansdzoejs"] = "㪔財",  --㪔財
[":soansdzoejs"] = "伱對其它腳色致傷後,若x>0,伱可發動,伱分配其x手牌(x爲其手牌數-體力數)",
["#soansdzoejs-fire"]="㪔財 打出1牌  防止 %src 所受傷害",
["#soansdzoejs-thunder"]="㪔財 %src 受到雷傷 伱可打出1牌  連鎖其它脚色",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


soansdzoejs:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return 
    data.from==player
    and data.to~=player
    and player:hasSkill(soansdzoejs.name) 
    and data.to:getHandcardNum()>math.max(0, data.to.hp)
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
	-- 	local cards =  room:askToDiscard(player, {
	-- 	  min_num = 1,
	-- 	  max_num = 1,
	-- 	  include_equip = false,
	-- 	  skill_name = soansdzoejs.name,
	-- 	  cancelable = true,
  --     -- pattern = ".|.|.|.|.|basic",  ---koaz-- ssaet,szjemh,nziuk,tsiuh
  --     pattern=".",
  --     prompt = "#soansdzoejs-thunder:"..target.id,
	-- 	  skip = true,
	-- 	})
  --   if #cards ~= 0 then
  --     event:setCostData(self, {tos = {data.to}})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:askToYiji(player,{
      cards=data.to:getCardIds("h"),
      -- visible_pile={},
      min_num=1,
      max_num=data.to:getHandcardNum() - math.max(0, data.to.hp),
      expand_pile= data.to:getCardIds("h"),
      targets=room:getOtherPlayers(data.to),
      skip=false,
    })
  end,
})

return soansdzoejs

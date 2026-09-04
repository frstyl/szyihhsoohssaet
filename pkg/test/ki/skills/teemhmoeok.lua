local teemhmoeok = fk.CreateSkill({
  name = "teemhmoeok",
})

Fk:loadTranslationTable{
  ["teemhmoeok"] = "點墨",
  [":teemhmoeok"] = "一脚色A起動牌旹,伱可打出1牌發動,伱令此起動无效,A抽x(x爲起動牌与伱打出牌字數絕對差)",


  ["#teemhmoeok-card"] = "點墨:%dest 起動 %arg 伱可打出牌發令其无效",
  -- ["#teemhmoeok-damage"] = "點墨：伱受到 %arg 傷害 伱可弃1同花色牌發防止傷害",

  ["$teemhmoeok1"] = "伱昰太乙三才陣何足爲奇",
  ["$teemhmoeok2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


teemhmoeok:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(teemhmoeok.name) 
      and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room = room

    -- local cards = player.room:askToResponse(player,{ ---@type AskToUseCardParams
    --     skill_name = teemhmoeok.name,
    --     pattern = '.|.|'.. data.card:getSuitString(),  --待
    --     prompt = "#teemhmoeok-card::" .. target.id .. ":" .. data.card:toLogString(),
    --     cancelable = true,
		-- --   include_equip = true,
    --     -- event_data = effect  --teemhmoeok
    --   })
    local cards=player.room:askToCards(player,{
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern=".",
      prompt = "#teemhmoeok-card::" .. target.id .. ":" .. data.card:toLogString(),
			cancelable = true,
		})
      if #cards==1 then
      event:setCostData(self, {tos={target},cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(event:getCostData(self).cards,teemhmoeok.name,player)
    S.useNullify(data,player,teemhmoeok.name)
    if not data.from.dead then
      data.from:drawCards( math.abs(S.getCardNameLength(data.card) - S.getCardNameLength(event:getCostData(self).cards[1])))
    end
  end,
})



return teemhmoeok

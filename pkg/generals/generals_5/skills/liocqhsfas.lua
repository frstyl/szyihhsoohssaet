local liocqhsfas = fk.CreateSkill{
  name = "liocqhsfas",
}

Fk:loadTranslationTable{
  ["liocqhsfas"] = "龍化",
  [":liocqhsfas"] = "一其它脚色A起動卽旹計謀對僅存目幖B生效爲前,伱可打出1牌選1項發動.➀此起動對B无效,伱弃A 1牌➁將效果目幖轉爲除A B外1脚色",  --多次生效?

  ["#liocqhsfas-invoke"] = "龍化 %src 對 %dest 起動%arg 將生效 是否打出1牌轉迻 不選目幖則弃 %src 牌",
  ["#liocqhsfas-choose"] = "龍化選擇目幖 或弃 %src 牌",

  ["$liocqhsfas1"] = "算計于人休要害了自己",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

liocqhsfas:addEffect(fk.PreCardEffect, {  -- BeforeCardEffect
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(liocqhsfas.name) 
    and S.isInstantTrick(data.card.name)
    and (data.use and data.use.from~=player)    --target??
    and data:isOnlyTarget(data.to)
    and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local tos, cards =  room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      min_num = 0,
      max_num = 1,
		  include_equip = true,
      targets = table.filter(room.alive_players,function(p)
      return p~=data.to and p~=data.use.from
      end),
      pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
    end)}),
      prompt = "#liocqhsfas-invoke:" .. data.use.from.id .. ":"..data.to.id..":" .. data.card:toLogString(),
      skill_name = liocqhsfas.name,
      -- will_throw = true,
      cancelable = true,
      -- skip=true,
    })
    -- local cards =player.room:askToResponse(player,{ ---@type AskToUseCardParams
    --     skill_name = liocqhsfas.name,
    --     pattern = '.|.|.',  --待
    --     prompt = "#liocqhsfas-invoke:" .. data.use.from.id .. ":"..data.to.id..":" .. data.card:toLogString(),
    --     cancelable = true,
		-- --   include_equip = true,
    --     -- event_data = effect  --kvoanqddxins
    --   })
    --   local too=room:askToChoosePlayers(player,{
    --       targets = table.filter(room.alive_players,function(p)
    --       return p~=data.to and p~=data.use.from
    --       end),
    --       min_num = 0,
    --       max_num = 1,
    --       prompt = "#liocqhsfas-choose:"..data.use.from.id,
    --       skill_name = liocqhsfas.name,
    --       cancelable = true,
    --     })
    if card then
      event:setCostData(self, {tos = tos,cards=cards})
      return true
    end
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
       S.playCard(event:getCostData(self).cards,liocqhsfas.name,player)
        -- room:throwCard(event:getCostData(self).cards, liocqhsfas.name, player, player)
    if #event:getCostData(self).tos==0 then
      S.effectNullify(data,player,liocqhsfas.name,true)
      local cid = room:askToChooseCard(player, { target = data.use.from, flag = "he", skill_name = liocqhsfas.name })
      room:throwCard({cid}, liocqhsfas.name, data.use.from, player)
      return
    end
    -- data:cancelTarget(data.to)
    -- data:addTarget(event:getCostData(self).tos[1])
    local to =event:getCostData(self).tos[1]
    data.extra_data = data.extra_data or {} 
    data.extra_data.origin_to=data.extra_data.origin_to or data.to
    -- data.target=to
    data.to=to
  end,
})



return liocqhsfas


local ljetkrak = fk.CreateSkill{
  name = "ljetkrak",
}
Fk:loadTranslationTable{
["ljetkrak"] = "烈戟",
[":ljetkrak"] = "伱補段終旹,預打出1牌發動,伱越過1轉主段撤段,可虛擬起動1｢殺｣,此殺:无視距離次數限制,結算期閒伱无視防具,致傷旹伱可起動1元實手牌(无視次數)",

["#ljetkrak-invoke"] = "烈戟 打出1牌發動",
["#ljetkrak-use"] = "烈戟 伱可虛擬起動殺 (目幖上限 %arg) ",
["#ljetkrak-extra_use"] = "烈戟 伱可起動元實手牌 ",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

ljetkrak:addEffect(fk.EventPhaseEnd, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ljetkrak.name) and player.phase == Player.Draw
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room=player.room
  --   --   local targets = table.filter(room:getOtherPlayers(player, false), function (p)
  --   --   return player:canUseTo(Fk:cloneCard("ssaet"), p, {bypass_distances = true, bypass_times = true})
  --   -- end)
  --     local card =Fk:cloneCard("ssaet")
  --     local n =card.skill:getMaxTargetNum(player, card)+1  --止首目幖判斷次數
  --     local tos, cards = room:askToChooseCardsAndPlayers(player, {
  --       min_num = 0,
  --       max_num = n,
  --       min_card_num = 1,
  --       max_card_num = 1,
  --       targets = room:getOtherPlayers(player, false),
  --       pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("he"),function(id)
  --         return  not player:prohibitResponse(Fk:getCardById(id))
  --       end
  --       ) }),
  --       skill_name = ljetkrak.name,
  --       prompt = "#ljetkrak-choose:::"..n,
  --       cancelable = true,
  --       -- will_throw = true,
  --     })
  --   if  #cards>0 then
  --       event:setCostData(self, {tos = tos, cards = cards})  --not tos
  --       return true
  --   end
  --   end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local cards = S.askToPlayCard(player, {
		  min_num = 1,
		  max_num = 1,
		  include_equip = true,
		  skill_name = ljetkrak.name,
		  cancelable = true,
      pattern = ".",
      prompt = "#ljetkrak-invoke",
		  skip = true,
		})
    if #cards ~= 0 then
      event:setCostData(self, {cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.playCard(event:getCostData(self).cards,ljetkrak.name,player)

    player:skip(Player.Play)
    player:skip(Player.Discard)
    if player.dead then return end


    player.room:addPlayerMark(player, "@@ignore_Armor",1)
    player.room.logic:getCurrentEvent():findParent(GameEvent.SkillEffect, true):addCleaner(function()  --防kill --應該是useCard refresh
        player.room:removePlayerMark(player, "@@ignore_Armor",1)
    end)

    -- player.room:addPlayerMark(player, "ssaet_target_number",1)
    local card =Fk:cloneCard("ssaet")
    local n =card.skill:getMaxTargetNum(player, card)+1
    local use =room:askToUseVirtualCard(player, {
      name = "ssaet",
      skill_name = ljetkrak.name,
      prompt = "#ljetkrak-use:::"..n,
      cancelable = true,
      extra_data = {
        bypass_distances=true,
        bypass_times = true,
        extraUse = true,
        ljetkrak=player.id,
        target_number=1,
      },
      skip = true,
    })
    -- player.room:removePlayerMark(player, "ssaet_target_number",1)
    if use then
      use.extra_data=use.extra_data or {}
      use.extra_data.ljetkrak=player.id
      use.extraUse=true
      room:useCard(use)
    end
    -- local card =Fk:cloneCard("ssaet")
    -- local n =card.skill:getMaxTargetNum(player, card)+1  --止首目幖判斷次數
    -- local tos  = room:askToChoosePlayers(player, {
    --       targets = table.filter(room:getOtherPlayers(player, false), function (p)
    --       return player:canUseTo(card, p, {bypass_distances = true, bypass_times = true})
    --     end),
    --       min_num = 1,
    --       max_num = n,
    --       prompt = "#ljetkrak-use:::"..n,
    --       skill_name = ljetkrak.name,
    --       cancelable = true,
    --     })
    -- -- local tos = event:getCostData(self).tos
    -- if #tos==0 then return end
    -- room:useVirtualCard("ssaet", nil, player, tos, ljetkrak.name, true, {ljetkrak=player.id})  --zzin souk
  end,
})


ljetkrak:addEffect(fk.Damaged, {  --致傷用牌
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return 
    -- and data.card 
    -- and table.contains(data.card.skillNames, ljetkrak.name)    --傷源未必爲起動者 起動者未必爲技能發動者
    data.event_data
    and data.event_data.extra_data
    and data.event_data.extra_data.ljetkrak==player.id
    
  end,
  on_trigger = function(self, event, target, player, data)
    local use = player.room:askToUseRealCard(player, {
      -- pattern = Player.Hand,  --被封
      skill_name = ljetkrak.name,
      prompt = "#ljetkrak-extra_use",
      extra_data = {
        bypass_times = true,
        extraUse = true,
      }
    })
    -- if use then
    -- player.room:useCard(use)  
    -- end
  end,
})



return ljetkrak

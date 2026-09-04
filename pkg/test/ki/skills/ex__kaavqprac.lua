local ex__kaavqprac = fk.CreateSkill {
  name = "ex__kaavqprac",
}


Fk:loadTranslationTable{ --拆解
  ["ex__kaavqprac"] = "交兵",
  [":ex__kaavqprac"] = "伱起傷害牌指定目幖A後伱可与A賭鬥發動｡若賭鬥牌點數絕對差不大于A體力值,伱弃置A 1牌,A不能起動{閃/防患未肰}抵消此",
  ["#ex__kaavqprac"] = "交兵 流失體力加傷",


  ["$ex__kaavqprac1"] = "賊子伱往若里去",
  ["$ex__kaavqprac2"] = "",
}

ex__kaavqprac:addEffect(fk.TargetConfirmed, {  -- --PreCardEffect
  anim_type = "offensive",
  prompt = "#ex__kaavqprac",
	can_trigger = function(self, event, target, player, data)
		return data.from ==player and player:hasSkill(ex__kaavqprac.name)
    and data.card.is_damage_card
    and player:canPindian(data.to)
    -- and data:isOnlyTarget(data.to)
	end,
	on_use = function(self, event, target, player, data)
    local room=player.room

    local pindian = player:pindian({target}, ex__kaavqprac.name)
    if player.dead or target.dead then return end

    local fromCard= pindian.fromCard --可能變
    local toCard =  pindian.results[target].toCard
    if not fromCard or toCard==nil then return end
    if math.abs(fromCard.number-toCard.number) >= data.to.hp then
      if not data:isKongcheng() then 
        local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = ex__kaavqprac.name })
        room:throwCard({cid}, ex__kaavqprac.name, data.to, player)
        if data.to.dead then return end
      end
        data.currentExtraData=data.currentExtraData or {}
        data.currentExtraData.ex__kaavqprac=data.to.id
        -- room:setPlayerMark(data.to, ex__kaavqprac.name, room.logic.current_event_id)      
    end
  end,
})

-- ex__kaavqprac:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
--   can_refresh = function(self, event, target, player, data)  --雙向?
--     return  player.seat==1 and
--     data.eventData   
--     and  data.eventData.currentExtraData
--     and  data.eventData.currentExtraData.ex__kaavqprac==player.id
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if  data.afterRequest then
--         room:setPlayerMark(player,ex__kaavqprac.name, nil)      
--     else
--         room:setPlayerMark(player,ex__kaavqprac.name, 1)      
--     end
--   end,
-- })

ex__kaavqprac:addEffect("prohibit", {
  prohibit_use = function(self, player, card)  --應自供 current接口  --ClientInstance不知current_event
    if player and card and (card.trueName=="szjemh" or card.trueName=="buac_hzfan_mujs_nzjen") then
      if  player:getMark(ex__kaavqprac.name)  then
        return true
      end
    end
  end,
})

return ex__kaavqprac

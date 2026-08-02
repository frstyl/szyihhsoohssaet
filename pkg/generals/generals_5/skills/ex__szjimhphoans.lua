

local ex__szjimhphoans= fk.CreateSkill{
  name = "ex__szjimhphoans",
}



Fk:loadTranslationTable{
  ["ex__szjimhphoans"] = "宷判",
  [":ex__szjimhphoans"] = "一脚色判斷牌生效歬,伱可發動,全體脚色非必發技能失效至占卜牌生效後.伱取得元占卜牌,該脚色再次占卜,以此次占卜代替元占卜",
  ["#ex__szjimhphoans-reJudge"] = "%from 发动了〖%arg〗 %to 新占卜牌爲 %arg2",
}

ex__szjimhphoans:addEffect(fk.AskForRetrial,{
	anim_type = "control",
	can_trigger = function(self, event, target, player, data)
	  return player:hasSkill(ex__szjimhphoans.name)  --and not  data.unchangable
	end,
  on_use = function(self, event, target, player, data)
      local room = player.room
      --0
      for _, p in ipairs(room.players) do  --
        room:addPlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
      end

      -- room.logic:getCurrentEvent():findParent(GameEvent.Judge, true):addCleaner(function()
      --   for _, p in ipairs(room:getOtherPlayers(player)) do  --
      --     room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", 1)
      --   end
      -- end)
      --1
      local oldId = data.card:getEffectiveId()
      if oldId  and room:getCardArea(oldId) ==  Card.Processing  and not  player.dead  then --data.card Card
        player.room:obtainCard(player, oldId, true, fk.ReasonPrey, player, ex__szjimhphoans.name)
      end
      --2
      local judge = {
        who = data.who,
        reason = ex__szjimhphoans.name,  --寫多个?
        pattern = data.pattern,
        --unchangable=true,
		  }
		  room:judge(judge)
      data.card = judge.card

      room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = { data.who.id },
      arg2 = judge.card:toLogString(),
      arg = ex__szjimhphoans.name,
    }
    --3
      for _, p in ipairs(room.players) do  --
        room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
      end
      return true --中止此旹機?
	end,
})


return ex__szjimhphoans

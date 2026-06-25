

local szjimhphoans= fk.CreateSkill{
  name = "szjimhphoans",
}



Fk:loadTranslationTable{
  ["szjimhphoans"] = "宷判",
  [":szjimhphoans"] = "當一角色判斷牌生效歬,伱可發動,伱獲得元判定牌,該角色再次判定,以此次判定牌代替元判定牌,終止元旹機",
  ["#szjimhphoans-reJudge"] = "%from 发动了〖%arg〗 %to 新判定牌爲 %arg2",
}

szjimhphoans:addEffect(fk.AskForRetrial,{
	anim_type = "control",
	can_trigger = function(self, event, target, player, data)
	  return player:hasSkill(szjimhphoans.name)  --and not  data.unchangable
	end,
  on_use = function(self, event, target, player, data)
      --0

      local room = player.room
      --1
      local oldId = data.card:getEffectiveId()
      if oldId  and room:getCardArea(oldId) ==  Card.Processing  and not  player.dead    then --data.card Card
        room:moveCards{
          ids = { oldId},
          toArea = Card.PlayerHand ,
          moveReason =  fk.ReasonJustMove,
          to =  player ,
          skillName = szjimhphoans.name,
          }
      end
      --2
      local judge = {
        who = data.who,
        reason = szjimhphoans.name,  --寫多个?
        pattern = data.pattern,
        --unchangable=true,
		  }
		  room:judge(judge)
      data.card = judge.card
      -- data.unchangable=true
      -- room:sendLog{
      --   type = "#szjimhphoans-reJudge",
      --   from = {player.id},
      --   to = { data.who.id },
      --   arg2 = judge.card:toLogString(),
      --   arg = szjimhphoans.name,
      -- }
      room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = { data.who.id },
      arg2 = judge.card:toLogString(),
      arg = szjimhphoans.name,
    }
    --3
      return true --中止此旹機?
	end,
})

szjimhphoans:addEffect(fk.AskForRetrial,{
  priority=999, --彀大
  mute=true,
  can_trigger = function(self, event, target, player, data)
    return  data.reason == szjimhphoans.name
  end,
  -- on_cost = function(self, event, target, player, data)
  --   return true
  -- end,
  on_trigger = function(self, event, target, player, data)
    return  true
  end,
})
return szjimhphoans

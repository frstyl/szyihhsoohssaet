local pxemqkoot = fk.CreateSkill {
  name = "pxemqkoot",
}

Fk:loadTranslationTable{
  ["pxemqkoot"] = "砭骨",
  [":pxemqkoot"] = "伱起動殺對目幖生效前,伱可聲明1花色發動,目幖可演練1此花牌,未執行則不可起動打出轉化該花牌至其轉終",

  ["@pxemqkoot"] = "砭骨",
  ["#pxemqkoot-choose"] = "砭骨 聲明花色 %src不能起動打出之",
  ["#pxemqkoot-response"] = "砭骨 來自%src 打出 %arg",
}

pxemqkoot:addEffect(fk.PreCardEffect, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.from==player and player:hasSkill(pxemqkoot.name)
    and data.card.trueName=="ssaet"
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local suits = {"log_spade", "log_heart", "log_club", "log_diamond"}
    local choices = room:askToChoice(player, {
      choices = suits,
      -- min_num = 1,
      -- max_num = 1,
      skill_name = pxemqkoot.name,
      prompt = "#pxemqkoot-choose:"..data.to.id,
      cancelable = true,
    })
    if choices~="Cancel" then
      event:setCostData(self, {choice = choices})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local logsuit =event:getCostData(self).choice
    local room = player.room
    local respond = room:askToResponse(data.to, {--?? SkillEffectDataSpec
      skill_name = pxemqkoot.name,
      pattern = ".|.|"..logsuit:split("_")[2],
      prompt = "#pxemqkoot-response:" .. player.id .. "::"  .. logsuit,
      cancelable = true,
      extra_data={}
      -- event_data = {
      --   to=to,
      --   from=player,
      -- },--skill card
    })
    if respond then
      respond.extra_data=respond.extra_data or {}
      respond.extra_data.skill_effect_event={who=player,skill_name=pxemqkoot.name}
      -- respond.event_data = {
      --   skill_effect_event={who=player,skill_name=pxemqkoot.name} --player.room.logic:getCurrentEvent().data
      -- }

      room:responseCard(respond)
    else
      player.room:addTableMarkIfNeed(data.to, "@pxemqkoot", logsuit)
    end
  end,
})

pxemqkoot:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@pxemqkoot") ~= 0 and card then
      if table.contains(player:getMark("@pxemqkoot"), card:getSuitString(true))  then
        return true
      end
      local subcards = card:isVirtual() and card.subcards or {card.id}  --isVirtual id==0
      for _, id in ipairs(subcards) do
        if table.contains(player:getTableMark("@pxemqkoot"), Fk:getCardById(id):getColorString()) then
          return true
        end
      end
    end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@pxemqkoot") ~= 0 and card then
      if table.contains(player:getMark("@pxemqkoot"), card:getSuitString(true))  then
        return true
      end
      local subcards = card:isVirtual() and card.subcards or {card.id}  --isVirtual id==0
      for _, id in ipairs(subcards) do
        if table.contains(player:getTableMark("@pxemqkoot"), Fk:getCardById(id):getColorString()) then
          return true
        end
      end
    end
  end,
})


pxemqkoot:addEffect(fk.TurnEnd, {
  -- is_delay_effect=true,
  can_refresh = function (self, event, target, player, data)
    return target==player and player:getMark("@pxemqkoot") ~= 0 
  end,
  on_refresh = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "@pxemqkoot", nil)
  end,
})
return pxemqkoot

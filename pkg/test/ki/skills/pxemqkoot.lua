local pxemqkoot = fk.CreateSkill {
  name = "pxemqkoot",
}

Fk:loadTranslationTable{
  ["pxemqkoot"] = "砭骨",
  [":pxemqkoot"] = "伱起動殺對目幖A生效前,伱可隱祕選擇1花色發動,A可演練牌,未演練同花牌則不可起動投出該花牌,其挩離瀕死旹除除",

  ["@pxemqkoot"] = "砭骨",
  ["#pxemqkoot-choose"] = "砭骨 選擇花色 %src不能起動投出之",
  ["#pxemqkoot-response"] = "砭骨 來自%src 演練1",
  -- ["#pxemqkoot-response"] = "砭骨 來自%src 投出 %arg",
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
      event:setCostData(self, {choice = choices,tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local logsuit =event:getCostData(self).choice
    local room = player.room
    local to =event:getCostData(self).tos[1]  
    local respond = room:askToResponse(to, {--?? SkillEffectDataSpec
      skill_name = pxemqkoot.name,
      -- pattern = ".|.|"..logsuit:split("_")[2],
      -- prompt = "#pxemqkoot-response:" .. player.id .. "::"  .. logsuit,
      pattern=".",
      prompt = "#pxemqkoot-response:" .. player.id ,
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
    end
    if not to.dead and not respond or respond.card:getSuitString(true)==logsuit then
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


pxemqkoot:addEffect(fk.AfterDying, {
  -- is_delay_effect=true,
  can_trigger = function (self, event, target, player, data)
    return target==player and player:getMark("@pxemqkoot") ~= 0 and not player.dead
  end,
  on_trigger = function (self, event, target, player, data)
    player.room:setPlayerMark(player, "@pxemqkoot", nil)
  end,
})

return pxemqkoot

local toojskveet = fk.CreateSkill {
  name = "toojskveet",
}

Fk:loadTranslationTable{
  ["toojskveet"] = "對決",
  [":toojskveet"] = "殺效果結算後,若伱爲其使用者或目幖,伱可選1其他角色發動,其判定,視爲伱對其使用鬥將,无視距離且止被与判定牌同色牌響應｡",
  ["#toojskveet-choose"] = "對決 選擇鬥將目幖",
}

local toojskveet_spec = {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return 
    -- target==player  
    (data.from==player or data.to==player)
    and player:hasSkill(toojskveet.name) 
    and data.card and data.card.trueName == "ssaet" 
  end,
  on_cost = function(self, event, target, player, data)
    --  local targets = table.filter(player.room:getOtherPlayers(player, false), function (p)
    --     return player:canUseTo(Fk:cloneCard("tous_tsiacs"), p, {bypass_distances = true, bypass_times = true})
    --   end)
    local  targets = player.room:getOtherPlayers(player)
      local tos = player.room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = 1,
        targets = targets,
        prompt = "#toojskveet-choose"
      })
      if #tos>0  then
        event:setCostData(self, {tos = tos})
        return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to = event:getCostData(self).tos[1]

    local room=player.room
    local judge = {
      who = to,
      reason = "toojskveet",
      pattern = ".",
    }
    room:judge(judge)
    if player.dead or to.dead then return end

    local card=Fk:cloneCard("distance__tous_tsiacs") 
    if not player:canUseTo(card, to, {bypass_distances = true, bypass_times = true}) then return end
    card.skillName = toojskveet.name    
    card.exral_data=card.extra_data or {}  --虛牌書于card
    card.exral_data.toojskveet_color = judge.card.color
    room:useCard({      
      from = player,
      tos = {to},
      card =  card ,
    })
  end,
}


-- toojskveet:addEffect(fk.TargetSpecified, {
--   can_trigger = function(self, event, target, player, data)
--     return target == player --and player:hasSkill(toojskveet.name) 
--       and data.card and data.card.skillName == toojskveet.name
--   end,
--   on_use = function(self, event, target, player, data)
--     data.extra_data = data.extra_data or {}
--     data.extra_data.toojskveet_color = data.card.color
--   end,
-- })
---@class AskForCardData
---@field user ServerPlayer
---@field skillName? string @ 烧条显示的技能名称
---@field pattern string
---@field extraData UseExtraData
---@field eventData? CardEffectData @ 询问此响应的事件，例如借刀之于问杀
---@field result? any
---@field isResponse? boolean @ 是否为打出事件
---@field afterRequest? boolean @ 是否已询问
---@field overtimes? ServerPlayer[] @ 此响应超时的玩家

toojskveet:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
  can_refresh = function(self, event, target, player, data)  --雙向?
    return  player.seat==1 and
    data.eventData and  data.eventData.card
    and data.eventData.card.exral_data
    and  data.eventData.card.exral_data.toojskveet_color
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if not data.afterRequest then
      room:setBanner("toojskveet_color", data.eventData.card.exral_data.toojskveet_color)
    else
      room:setBanner("toojskveet_color", nil)
    end
  end,
})

toojskveet:addEffect(fk.AskForCardUse, {--trigger技用牌 會封其它結算
  can_refresh = function(self, event, target, player, data)  --雙向?
    return  data.eventData and  data.eventData.card
        and data.eventData.card.exral_data
        and  data.eventData.card.exral_data.toojskveet_color
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setBanner("toojskveet_color", data.eventData.card.exral_data.toojskveet_color)
  end,
})

toojskveet:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    local color = Fk:currentRoom():getBanner("toojskveet_color")
    if not color then return end 
    
    if card.color~=color or color==Card.NoColor or card.color==Card.NoColor then
      -- local subcards = card:isVirtual() and card.subcards or {card.id}
      -- return #subcards > 0
      return true
    end
  end,
  prohibit_response = function(self, player, card)
    local color = Fk:currentRoom():getBanner("toojskveet_color")
    if not color then return end 
    
    if card.color~=color or color==Card.NoColor or card.color==Card.NoColor then
      -- local subcards = card:isVirtual() and card.subcards or {card.id}
      -- return #subcards > 0
      return true
    end
  end,
})

-- toojskveet:addEffect(fk.Damaged, toojskveet_spec)
-- toojskveet:addEffect(fk.Damage, toojskveet_spec)
toojskveet:addEffect(fk.CardEffectFinished, toojskveet_spec)
-- toojskveet:addEffect(fk.TargetConfirmed, toojskveet_spec)

return toojskveet

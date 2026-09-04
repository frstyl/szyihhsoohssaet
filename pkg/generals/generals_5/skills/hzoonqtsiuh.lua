local hzoonqtsiuh = fk.CreateSkill {
  name = "hzoonqtsiuh",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["hzoonqtsiuh"] = "渾酒",
  [":hzoonqtsiuh"] = "印牌:以伱1{酒/肉/迷}轉化爲{酒/肉/迷}起動｡此牌可選擇其它脚色,執行效果後對伱執行元牌效果.",

  ["#hzoonqtsiuh"] = "渾酒：酒肉迷轉化爲酒肉迷",
  -- ["#hzoonqtsiuh-choose"] = "渾酒：爲 %arg 選擇額外目幖",
  -- ["#hzoonqtsiuh-extraUse"] = "渾酒 是否令 %arg 不計入次數",

  ["$hzoonqtsiuh1"] = "客官,昰酒可渾",
}

hzoonqtsiuh:addEffect("viewas", {
  anim_type = "offensive",
  prompt = "#hzoonqtsiuh",
  pattern =".|.|.|.|nziuk,tsiuh,meej",  --free__meej
  mute_card = true,
  interaction = function(self, player)
    local choices=table.filter({"nziuk","tsiuh","meej"},function(name)
      local card = Fk:cloneCard(name)
      card:setVSPattern(hzoonqtsiuh.name, player, ".")
      -- return player:canUseOrResponseInCurrent(card, nil)
      return Fk.currentResponsePattern==nil or card:matchVSPattern(Fk.currentResponsePattern)
    end
    )
    return UI.CardNameBox {
      choices = choices,
      all_choices = {"nziuk","tsiuh","meej"},
      default_choice = "meej",
    }
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains({"nziuk","tsiuh","meej"} ,Fk:getCardById(to_select).trueName )
  end,
  view_as = function(self, player, cards)  --待改 如轉化歬不能用 轉化後不能用
    return nil
    -- if Fk.all_card_types[self.interaction.data] == nil or  #cards ~= 1 then return end
    -- local card = Fk:cloneCard(self.interaction.data)
    -- card:addSubcard(cards[1])
    -- card.skillName = hzoonqtsiuh.name
    -- return card
  end,

  target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
    if not selected_cards[1] then return end
    if  selected[1] then return end  --target_num??
    if extra_data and #extra_data.fix_targets>0 and not table.contains(extra_data.fix_targets, to_select.id) then return end 
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcard(selected_cards[1])
    card.skillName = hzoonqtsiuh.name
    -- if card.skill:getMaxTargetNum(player, card)==#selected then return end
    -- return not (player:prohibitUse(card) or player:isProhibited(to_select, card))
    return player:canUseTo(card,to_select, {fix_target={selected.id}})
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return #selected ~=0
  end,
  on_use = function(self, room, cardUseEvent, _, params)
    local player = cardUseEvent.from
    local tos = cardUseEvent.tos
    
    local card = Fk:cloneCard(self.interaction.data)
    card:addSubcard(cardUseEvent.cards[1])
    card.skillName = hzoonqtsiuh.name
    return {
      from=player,
      tos=tos,
      card=card,
      extra_data={
        bypass_times=true,
        extraUse=true,
        hzoonqtsiuh= player.id
        }
      }
  end,

  -- before_use = function(self, player, use)
  --   use.extra_data =use.extra_data or {}
  --   use.extra_data.hzoonqtsiuh = player.id
  --   use.extra_data.extraUse=true
  -- end,
  -- after_use = function(self, player, use)
  --   player:drawCards(1,hzoonqtsiuh)
  -- end,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})

hzoonqtsiuh:addEffect(fk.CardEffectFinished, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return 
     data.extra_data and data.extra_data.hzoonqtsiuh == player.id
  end,
  on_trigger= function(self, event, target, player, data)
    local card= Fk:getCardById(data.card.subcards[1])
    if not card then return end
    local effect_data = CardEffectData:new {
        from=player,
        card = card,
        tos = { player },
        to = player,
      }
      player.room:doCardEffect(effect_data)
  end,
})

-- hzoonqtsiuh:addEffect(fk.PreCardUse,{
--   can_trigger = function (self, event, target, player, data)
--     return target == player  and data.card
--       and data.card:getMark("@@ddwenqtsjens-inhand")>0
--   end,
--   on_cost = function(self, event, target, player, data)
--     return player.room:askToSkillInvoke(player,{
--       skill_name=hzoonqtsiuh.name, 
--       prompt="#hzoonqtsiuh-extraUse::"..data.card:toLogString(),
--     })
--   end,
--   on_use = function(self, event, target, player, data)
--     data.extraUse = true
--   end,
-- })



-- hzoonqtsiuh:addEffect(fk.CardUsing, {  --refresh?
  -- anim_type = "offensive",
  -- can_trigger = function(self, event, target, player, data)
    -- return   player:hasSkill(hzoonqtsiuh.name) 
    -- and target == player
    -- and table.contains({"nziuk", "tsiuh", "meej"}, data.card.trueName)
  -- end,
  -- on_cost = function(self, event, target, player, data)
		-- local tos = player.room:askToChoosePlayers(player,{
      -- targets=data:getExtraTargets(),
      -- min_num=1,
      -- max_num=1,
      -- cancelable=true,
      -- prompt = "#hzoonqtsiuh-choose::"..data.card:toLogString(),
    -- })
    -- if #tos ~= 0 then
      -- event:setCostData(self, {tos = tos})
      -- return true
    -- end
  -- end,
  -- on_use = function(self, event, target, player, data)
    -- data:addTarget(event:getCostData(self).tos[1])
  -- end,
-- })



-- hzoonqtsiuh:addEffect("targetmod", {
--   extra_target_func = function(self, player, skill,card)
--     if player:hasSkill(hzoonqtsiuh.name) card.trueName == "nziuk"  then
--       return 1
--     end
--   end,
  -- fix_target = function(self, player, skill,card,extra_data)
  -- end,
-- })
return hzoonqtsiuh

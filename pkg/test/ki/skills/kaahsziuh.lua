local kaahsziuh = fk.CreateSkill {
  name = "kaahsziuh",
}

Fk:loadTranslationTable{
  ["kaahsziuh"] = "假手",
  [":kaahsziuh"] = "伱可起動牌旹,選擇1其它腳色發動,視爲其起動",

  ["#kaahsziuh"] = "假手：选择一名其他角色，你的下一张牌视为由该角色使用",
  ["#kaahsziuh-use"] = "假手：选择一张牌并选择目标，视为由 %dest 使用",

  ["$kaahsziuh1"] = "待君归时，共泛轻舟于湖海。",
  ["$kaahsziuh2"] = "妾有一曲，可壮卿之峥嵘。",
}


kaahsziuh:addEffect("viewas", {
  anim_type = "control",
  pattern = ".",
  prompt = "#kaahsziuh",
  -- mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    return nil
  end,
  target_filter = function(self, player, to_select, selected, selected_cards, c, extra_data)
    return #selected == 0 and to_select ~= player 
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return #selected ~= 0
  end,
  on_cost =function(self, player, data,extra_data)
    if extra_data then
      data.extar_data=extar_data 
    end
  end,
  on_use = function(self, room, SkillUseData, card, params)  --beforeUse前 returun轉化起動信息  --cardUseEvent 實爲SkillUseData ,params handleUseCardParams is_response, card viewAs--beforeUse
    local player = SkillUseData.from
    local target =SkillUseData.tos[1]
    -- local extra_data=SkillUseData.extra_data or {}
    -- extra_data.bypass_times = extra_data.bypass_times  or false
    -- extra_data.extraUse = extra_data.extraUse  or false
    -- extra_data.fix_user =target.id
    -- extra_data.not_passive = pattern=="."
    -- extra_data.kaahsziuh=true

    local pattern = player:getMark("kaahsziuh_pattern")~=0 and player:getMark("kaahsziuh_pattern") or "."
    local params = { ---@type AskToUseCardParams
      skill_name = kaahsziuh.name,
      pattern = pattern,
      prompt = "#kaahsziuh-use::" .. target.id,
      cancelable = true,
      extra_data =  {
        -- bypass_times = true,
        bypass_times = false,
        extraUse=false,
        fix_user = target.id,
        -- bypass_moment=true,
        kaahsziuh=true,
      }
    }
    local use = room:askToUseCard(player, params)
    if use then
      use.from = target
      room:useCard(use)
    else
      room:setPlayerMark(player, "kaahsziuh_prohibit-phase", 2)
    end
    return kaahsziuh.name
  end,
  enabled_at_play = function(self, player) 
    return not player:hasMark("kaahsziuh_prohibit-phase")
  end,
  enabled_at_response = function(self, player, response) 
    return  not response and not player:hasMark("kaahsziuh_prohibit-phase")
  end,
  enabled_at_nullification = function (self, player, cardEffectData)
    return false
  end,
})

kaahsziuh:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
  can_refresh = function(self, event, target, player, data)  --雙向?
    return  data.user==player
    and player:hasSkill(kaahsziuh.name,true)
     
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if not data.afterRequest 
    and (data.extraData and data.extraData.kaahsziuh) then
      room:setPlayerMark(player, "kaahsziuh_prohibit-phase", 2)
      room:setPlayerMark(player, "kaahsziuh_pattern", data.pattern)
    else
      room:setPlayerMark(player, "kaahsziuh_prohibit-phase", nil)
      room:setPlayerMark(player, "kaahsziuh_pattern", nil)
    end
  end,
})

kaahsziuh:addEffect(fk.StartPlayCard, {
  can_refresh = function(self, event, target, player, data)
    return player == target and player:getMark("kaahsziuh_prohibit-phase") > 0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:removePlayerMark(player, "kaahsziuh_prohibit-phase", 1)
  end,
})

-- kaahsziuh:addEffect("active", {
--   anim_type = "control",
--   prompt = "#kaahsziuh",
--   can_use = function(self, player)
--     return player:getMark("kaahsziuh_prohibit-phase") == 0
--   end,
--   card_filter = Util.FalseFunc,
--   target_filter = function(self, player, to_select, selected)
--     return #selected == 0 and to_select ~= player and to_select:getMark("kaahsziuh_damaged-turn") == 0
--   end,
--   target_num = 1,
--   on_use = function(self, room, effect)
--     local player = effect.from
--     local target = effect.tos[1]
--     local params = { ---@type AskToUseCardParams
--       skill_name = kaahsziuh.name,
--       pattern = ".",
--       prompt = "#kaahsziuh-use::" .. target.id,
--       cancelable = true,
--       extra_data = {
--         bypass_times = true,--FIXME：使用【酒】有次数限制！！
--         fix_user = target.id,
--         not_passive = true
--         kaahsziuh=true,
--       }
--     }
--     local use = room:askToUseCard(player, params)
--     if use then
--       use.from = target
--       room:useCard(use)
--     else
--       room:setPlayerMark(player, "kaahsziuh_prohibit-phase", 2)
--     end
--   end,
-- })



return kaahsziuh

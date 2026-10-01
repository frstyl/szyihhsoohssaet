local sjiqkius = fk.CreateSkill {
  name = "sjiqkius",
}

Fk:loadTranslationTable{
  ["sjiqkius"] = "私救",
  [":sjiqkius"] = "主旹,伱可對其它腳色預起動軍器牌或肉,發動,其回1抽1。",

  ["#sjiqkius"] = "令1脚色回1抽1",

  ["@@poavs"] = "報",

  ["$sjiqkius1"] = "此地雖好也也不是安身之處",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- sjiqkius:addEffect("active", {
--   anim_type = "support",
--   card_num = 1,
--   target_num = 1,
--   prompt = "#sjiqkius",
--   can_use = function(self, player)
--     return player:usedSkillTimes(sjiqkius.name, Player.HistoryPhase) == 0
--   end,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
--     and Fk:getCardById(to_select).name=="nziuk"
--     and  not player:prohibitResponse(to_select)
--   end,
--   target_filter = function(self, player, to_select, selected, selected_cards)
--       return (#selected == 0 and to_select~=player) and to_select:isWounded()
--   end,
--   on_use = function(self, room, effect)
--     local from = effect.from
--     local to = effect.tos[1]  --
--     -- S.playCard(effect.cards,sjiqkius.name,effect.from)
--     room:recover{
--       who = to,
--       num = 1,
--       recoverBy = from,
--       skillName = sjiqkius.name,
--     }
--     to:drawCards(1,sjiqkius.name)
--     -- Fk:currentRoom():getPlayerById(
--     -- room:setPlayerMark(to,"@@poavs", from.id)
--     -- room:handleAddLoseSkills(to, "sjiqkius&", nil, false, true)
--   end,
-- })

sjiqkius:addEffect("viewas", {
  anim_type = "control",
  pattern = ".",
  prompt = "#sjiqkius",
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
    local target =data.tos[1]

    -- local pattern = player:getMark("sjiqkius_pattern")~=0 and player:getMark("sjiqkius_pattern") or "."
    local params = { ---@type AskToUseCardParams
      skill_name = sjiqkius.name,
      pattern = "nziuk,liac_tshoavh_seen_hzaac,mxevs_svoans_quo_seen|.|.;.|.|.|.|equip",  
      prompt = "#sjiqkius-use::" .. target.id,
      cancelable = true,
      extra_data =  {
        -- bypass_times = true,
        exclusive_targets={player.id},
        bypass_times = false,
        extraUse=false,
        bypass_fix_target =true,
        bypass_moment=true,
        sjiqkius=true,
      }
    }
    local use = player.room:askToUseCard(player, params)
    if use then
      data.extra_data=use
      -- room:useCard(use)
    else
      player.room:setPlayerMark(player, "sjiqkius_prohibit-phase", 2)
      return true
    end
  end,
  on_use = function(self, room, SkillUseData, card, params)  --beforeUse前 returun轉化起動信息  --cardUseEvent 實爲SkillUseData ,params handleUseCardParams is_response, card viewAs--beforeUse
    local player = SkillUseData.from
    local target =SkillUseData.tos[1]
    local    use=SkillUseData.extra_data 
      room:useCard(use)



    for _, p in ipairs (use.tos) do
      if not p.dead and p:isWounded() then
        room:recover{
        who = p,
        num = 1,
        recoverBy = from,
        skillName = sjiqkius.name,
      }
      end
      if not p.dead then
        p:drawCards(1,sjiqkius.name)
      end
    end

    return sjiqkius.name
  end,
  enabled_at_play = function(self, player) 
    return not player:hasMark("sjiqkius_prohibit-phase")
  end,
  enabled_at_response = function(self, player, response) 
    return  not response and not player:hasMark("sjiqkius_prohibit-phase")
  end,
  enabled_at_nullification = function (self, player, cardEffectData)
    return false
  end,
})


-- sjiqkius:addEffect(fk.AskForCardUse, {
--   can_trigger = function(self, event, target, player, data)
--     return  (target==player or target==nil) and player:hasSkill(sjiqkius.name)
--     and not data.afterRequest
--     and not data.afterRequest
--   end,  
--   on_use = function(self, event, target, player, data)
--     data.extraData=data.extraData or {}
--     data.extraData.bypass_fix_target=true
--   end,
--   -- can_refresh = function(self, event, target, player, data)
--   --   return  target==player and player:hasSkill(sjiqkius.name)
--   -- end,
--   -- on_refresh = function(self, event, target, player, data)
--   --   player.room:setBanner("toojskveet_color", data.eventData.card.exral_data.toojskveet_color)
--   -- end,
-- })

return sjiqkius

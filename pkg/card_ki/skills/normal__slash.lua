local skill = fk.CreateSkill {
  name = "normal__ssaet_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = function(self, player, selected_cards)
    local normal__ssaet = Fk:cloneCard("normal__ssaet")
    normal__ssaet:addSubcards(selected_cards)
    S.mixCard(normal__ssaet)
    local max_num = self:getMaxTargetNum(player, normal__ssaet) -- halberd
    if max_num > 1 then
      local num = #table.filter(Fk:currentRoom().alive_players, function (p)
        return p ~= player and not player:isProhibited(p, normal__ssaet)
      end)
      max_num = math.min(num, max_num)
    end
    return max_num > 1 and "#normal__ssaet_skill_multi:::" .. max_num or "#normal__ssaet_skill"
  end,
  max_phase_use_time = 1,
  target_num = 1,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.bypass_times) 
    -- or player.phase ~= Player.Play   --max_phase_use_time眞是phase 非旹機流程
    or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "normal__ssaet", to_select)
      -- table.find(Fk:currentRoom().alive_players, function(p)
      --   return self:targetFilter(player, p, {}, {}, card, extra_data)
      -- end)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player and
       ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select))
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)  --對某角色次數距離
    if not Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data) then return end  --must_targets  include_targets  exclusive_targets
    return self:modTargetFilter(player, to_select, selected, card, extra_data) and
      (
        #selected > 0 
        -- player.phase ~= Player.Play 
        or
        (extra_data and extra_data.bypass_times) or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "normal__ssaet", to_select)
      )
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.to.dead then
      room:damage({
        from = effect.from,
        to = effect.to,
        card = effect.card,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = skill.name
      })
    end
  end,
})

skill:addAI({
  on_effect = function(self, logic, effect)
    logic:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.NormalDamage,
      skillName = skill.name
    })
  end,
}, "__card_skill")

skill:addTest(function(room, me)
  local normal__ssaet = Fk:getCardById(1)
  local comp2 = room.players[2]

  -- 简单测试on_effect
  FkTest.setNextReplies(comp2, { "" })
  FkTest.runInRoom(function()
    room:useCard {
      from = me,
      tos = { comp2 },
      card = normal__ssaet,
    }
  end)
  lu.assertEquals(comp2.hp, 3)

  -- 然后在摸牌阶段中断，并来客户端进行简单测试
  FkTest.setRoomBreakpoint(me, "PlayCard")
  FkTest.runInRoom(function()
    room:obtainCard(me, normal__ssaet)
    Request:new(me, "PlayCard"):ask()
  end)

  local handler = ClientInstance.current_request_handler --[[ @as ReqPlayCard ]]
  -- 简单测试can_use：能用就行
  lu.assertIsTrue(handler:cardValidity(normal__ssaet.id))
  -- 简单测试target_filter：应该只选的到攻击范围内的也就是2和8号位
  handler:selectCard(normal__ssaet.id, { selected = true })
  lu.assertEquals(table.map(room:getOtherPlayers(me), function(p)
    return not not handler:targetValidity(p.id)
  end), { true, false, false, false, false, false, true })
end)

return skill

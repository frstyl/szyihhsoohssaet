local cardSkill = fk.CreateSkill {
  name = "ssaet_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = function(self, player, selected_cards)
    local ssaet = Fk:cloneCard("ssaet")
    ssaet:addSubcards(selected_cards)
    S.mixCard(ssaet)
    local max_num = self:getMaxTargetNum(player, ssaet) -- halberd
    if max_num > 1 then
      local num = #table.filter(Fk:currentRoom().alive_players, function (p)
        return p ~= player and not player:isProhibited(p, ssaet)
      end)
      max_num = math.min(num, max_num)
    end
    return max_num > 1 and "#ssaet_skill_multi:::" .. max_num or "#ssaet_skill"
  end,
  max_phase_use_time = 1,
  target_num = 1,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.bypass_times) 
    -- or player.phase ~= Player.Play   --max_phase_use_time眞是phase 非旹機流程
    or
      table.find(Fk:currentRoom().alive_players, function(p)
        return self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", p)
      end)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)--攻程內其它角色
    return to_select ~= player --殺自己??
    and
       ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select))
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if not Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data) then return end  --must_targets  include_targets  exclusive_targets  isProhibited
    return self:modTargetFilter(player, to_select, selected, card, extra_data) --攻程--CardTargetFilter已含
    and
      (--次數
        #selected > 0 --對某有次數--已有目幖則不攷慮次數
        -- player.phase ~= Player.Play 
        or
        (extra_data and extra_data.bypass_times) 
        or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", to_select)
      )
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.to.dead then
      room:damage({
        from = effect.from,
        to = effect.to,
        card = effect.card, --效果來源 但不含使用信息
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = cardSkill.name,--傳入cardUse cardEffect skillEffect Data
        event_data= effect,
        -- extra_data={
        --   CardEffectData=effect,
        -- }
      })
    end
  end,
})

cardSkill:addAI({
  on_effect = function(self, logic, effect)
    logic:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.NormalDamage,
      skillName = cardSkill.name
    })
  end,
}, "__card_skill")


return cardSkill

local skill = fk.CreateSkill {
  name = "fire__ssaet_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 


skill:addEffect("cardskill", {
  prompt = function(self, player, selected_cards)
    local card = Fk:cloneCard("fire__ssaet")
    card:addSubcards(selected_cards)
    S.mixCard(card)
    local max_num = self:getMaxTargetNum(player, card)
    if max_num > 1 then
      local num = #table.filter(Fk:currentRoom().alive_players, function (p)
        return p ~= player and not player:isProhibited(p, card)
      end)
      max_num = math.min(num, max_num)
    end
    return max_num > 1 and "#fire__ssaet_skill_multi:::" .. max_num or "#fire__ssaet_skill"
  end,
  max_phase_use_time = 1,
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)--攻程內其它脚色? --其它腳色
    return  to_select ~= player --殺自己??
    and  ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select)) 

    and 
      (--次數
        #selected > 0 --對某有次數--已有目幖則不攷慮次數
        --or player.phase ~= Player.Play 
        or
        (extra_data and extra_data.bypass_times) 
        or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", to_select)
      ) 

  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)

      --copy --extra_data与狀態技
      if  extra_data then 
        if extra_data.must_targets then
          -- must_targets: 必须先选择must_targets内的**所有**目标
          if not (#extra_data.must_targets <= #selected or
                table.contains(extra_data.must_targets, to_select.id)) then
            return false
          end
        end
        if extra_data.include_targets then
          -- include_targets: 必须先选择include_targets内的**其中一个**目标
          if not (table.hasIntersection(extra_data.include_targets, selected) or
                table.contains(extra_data.include_targets, to_select.id)) then
            return false
          end
        end
        if extra_data.exclusive_targets then
          -- exclusive_targets: **只能选择**exclusive_targets内的目标
          if not table.contains(extra_data.exclusive_targets, to_select.id) then return false end
        end
      end


    local max_target_num = self:getMaxTargetNum(player, card)
    if extra_data then  --不占目幖數?目幖上限?
      if extra_data.target_number then max_target_num=max_target_num+extra_data.target_number end
      if extra_data.extra_target then  --不占目幖數
          max_target_num = max_target_num + #table.filter(selected,function(p) return table.contains(extra_data.extra_targets,p.id) end )
      end
      if extra_data.fix_target_num then max_target_num=extra_data.fix_target_num end
    end 
    if max_target_num > 0 and #selected >= max_target_num then return end

    if not player:hasMark("ssaet_bypass_prohibited") and player:isProhibited(to_select, card) then return end
    if not self:modTargetFilter(player, to_select, selected, card, extra_data) then return end
    return true
  end,
  offset_func= Util.FalseFunc,
  on_action = function(self, room, use, finished)
    if not use.effectTimes then use.effectTimes=0 return end
    if  finished then
      use.effectTimes=use.effectTimes+1
    end
  end,
  on_effect = function(self, room, effect)
    room:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.FireDamage,
      skillName = skill.name,
      event_data= effect,
    })
  end,
})

return skill

local skill = fk.CreateSkill {
  name = "hsiap_paak_skill",
}


skill:addEffect("cardskill", {
  prompt = "#hsiap_paak_skill",
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    if #selected == 0 then
      return to_select ~= player and to_select.hp<player.hp
    elseif #selected == 1 then
      -- return selected[1]:canUseTo(Fk:cloneCard("ssaet"), to_select, {bypass_distances = false, bypass_times = true})
      return selected[1]:inMyAttackRange(to_select)
    end
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if #selected >= 2 then
      return false
    elseif #selected == 0 then
      return Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data)
    else
      return selected[1]:inMyAttackRange(to_select)
    end
  end,
  target_num = 2,
  offset_func= Util.FalseFunc,
  on_use = function(self, room, cardUseEvent)
    local tos = table.simpleClone(cardUseEvent.tos)
    cardUseEvent:removeAllTargets()
    for i = 1, #tos, 2 do
      cardUseEvent:addTarget(tos[i], { tos[i + 1] })
    end
  end,
  on_effect = function(self, room, effect)  --生效 選擇-用殺(轉化印牌旹機) 不用殺效果 共3
    local from = effect.from
    local to = effect.to
    if to.dead then return end
    local giveUp = function ()
        if (from.dead or to.dead) then return end
        -- local choice=""
        if #to:getCardIds("e")==0 then
          room:loseHp(to, 1, skill.name,effect.from)
          return
        end
            -- choice = "loseHp" 
        -- else
        local  choice = room:askToChoice(from, {  --effect-from use-player
          choices = { "loseHp", "#hsiap_paak-gainCard" }, --\
          skill_name = skill.name,
          prompt = "#hsiap_paak-choose:" .. to.id,
          })

        if choice=="loseHp" then
            room:loseHp(to, 1, skill.name)
        else
            local cid = room:askToChooseCard(from, { target = to, flag = "e", skill_name = skill.name })
            room:obtainCard(from, cid, false, fk.ReasonPrey, to, skill.name)  --proposer=to
        end
    end

    local prompt = "#hsiap_paak-ssaet:".. effect.from.id .. "::" .. effect.subTargets[1].id
    if #effect.subTargets > 1 then
      prompt = nil
    end
    local extra_data = {
      must_targets = table.map(effect.subTargets, Util.IdMapper),
      bypass_times = false,
      extraUse=false,
    }
    local use = room:askToUseCard(to, { skill_name = "ssaet", pattern = "ssaet", prompt = prompt, cancelable = true, extra_data = extra_data, event_data = effect })
    if use then
      -- use.extraUse = true
      room:useCard(use)
    else
      giveUp()
    end
  end,
})

return skill

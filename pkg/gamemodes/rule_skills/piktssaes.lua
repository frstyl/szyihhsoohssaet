local piktssaes = fk.CreateSkill {
  name = "piktssaes",
}

Fk:loadTranslationTable{
  ["piktssaes"] = "逼債",
  [":piktssaes"] = "段限1.伱選擇殺旹,伱可選其中1目幖發動.此牌結算畢,視爲對其使用此牌(不帶效果)",  --限1次

}


piktssaes:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(piktssaes.name) 
      and data.card.trueName=="ssaet"
      and player:usedEffectTimes(piktssaes.name, Player.HistoryPhase)<1
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(data.use.tos, function(p)
      return not p.dead
    end)
    if #targets == 1 then
      if room:askToSkillInvoke(player, {
        skill_name = piktssaes.name,
        prompt = "#piktssaes-invoke::"..targets[1].id,
      }) then
        event:setCostData(self, {tos = targets})
        return true
      end
    else
      local to = room:askToChoosePlayers(player, {
        targets = targets,
        min_num = 1,
        max_num = 1,
        prompt = "#piktssaes-choose",
        skill_name = piktssaes.name,
        cancelable = true,
      })
      if #to > 0 then
        event:setCostData(self, {tos = to})
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]

      data.extra_data = data.extra_data or {}
      data.extra_data.piktssaes = {
        from = player,
        to = to,
        subTargets = data.subTargets,
      }

  end,
})

piktssaes:addEffect(fk.CardUseFinished, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    if data.extra_data and data.extra_data.piktssaes and not player.dead then
      local use = table.simpleClone(data.extra_data.piktssaes)
      if use.from == player then
        local card = Fk:cloneCard(data.card.name,data.card.number,data.card.suit)  --總无色
        card.skillName = piktssaes.name
        if player:prohibitUse(card) then return false end
        local to = use.to
        if not to.dead and card.skill:modTargetFilter(player, to, {}, card, {bypass_distances = true, bypass_times = true}) then
          return true
        end
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local dat = data.extra_data.piktssaes
    local card = Fk:cloneCard(data.card.name)
    card.skillName = piktssaes.name
    room:useCard{
      from = player,
      tos = {dat.to},
      card = card,
      subTargets = dat.subTargets,
      extraUse = true,
    }
  end,
})

return piktssaes

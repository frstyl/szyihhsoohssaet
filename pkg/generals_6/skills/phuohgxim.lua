local phuohgxim = fk.CreateSkill {
  name = "phuohgxim",
}

Fk:loadTranslationTable{
["phuohgxim"] = "抚琴",
[":phuohgxim"] = "主旹或當伱受到傷害後,伱可選擇1角色与1項對其發動,➀伱令其抽x➁伱弃其x(x爲伱已損體力值+1)",

["#phuohgxim"]="抚琴 選擇一角色 令其抽弃 %arg",
["phuohgxim-discard"] = "抚琴 選擇弃牌",
}


phuohgxim:addEffect("active", {
  anim_type = "control",
  prompt = function (self, player, selected_cards, selected_targets)
    return "#phuohgxim:::"..(player:getLostHp()+1)
  end,
  card_num = 0,
  target_num = 1,
  interaction = UI.ComboBox {choices = { "draw_card", "discard" } },
  -- can_use = Util.TrueFunc,
  card_filter = Util.FalseFunc,
  max_phase_use_time = 1, --1主旹=1主段?
  -- can_use = function(self, player) 
  --   return player:usedEffectTimes(phuohgxim.name, Player.HistoryRound) == 0
  -- end,
  target_filter = function(self, player, to_select, selected, selected_cards)
    return #selected == 0  and not (self.interaction.data == "discard" and to_select:isNude())
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target  = effect.tos[1]
    local n = effect.from:getLostHp()+1
    -- local n =  player:usedSkillTimes(phuohgxim.name, Player.HistoryRound)
    if self.interaction.data == "draw_card" then
      target:drawCards(n, phuohgxim.name)
    else
      cards = room:askToChooseCards( effect.from, {
        target = effect.tos[1],
        min = n,
        max = n,
        flag = "he",
        skill_name = phuohgxim.name,
        prompt = "#phuohgxim-discard",
      })
        room:throwCard(cards, phuohgxim.name, effect.tos[1], effect.from)
    end
  end,
})


phuohgxim_spec={
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "phuohgxim",
      prompt = "#phuohgxim:::"..(player:getLostHp()+1),
      cancelable = true,
      skip = true,
    })
    if success and dat then
      event:setCostData(self, {tos = dat.targets, choice = dat.interaction})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local tos = event:getCostData(self).tos
    local skill = Fk.skills["phuohgxim"]
    skill.interaction = skill.interaction or {}
    skill.interaction.data = event:getCostData(self).choice
    skill:onUse(player.room, {  --useSkill
      from = player,
      tos = tos,
    })
  end,
}


phuohgxim:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(phuohgxim.name)
  end,
  on_cost = phuohgxim_spec.on_cost,
  on_use = phuohgxim_spec.on_use,
})

return phuohgxim

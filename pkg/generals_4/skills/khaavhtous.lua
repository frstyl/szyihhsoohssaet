local khaavhtous = fk.CreateSkill({
  name = "khaavhtous",
})

Fk:loadTranslationTable{
  ["khaavhtous"] = "巧鬥",
  [":khaavhtous"] = "主旹,伱可預与1其它角色A拼點發動.若伱贏,伱可迻動1牢,若未贏A予伱1傷",

  ["#khaavhtous"] = "巧鬥：1其它角色A拼點發動.若伱贏伱迻動1牢,若未贏A予伱1傷",
  ["#khaavhtous-choose"] = "巧鬥：迻動1牢",

  ["$khaavhtous1"] = "此乃巧鬥吞狼之计。",
  ["$khaavhtous2"] = "借你之手，与他一搏吧。",
}

khaavhtous:addEffect("active", {
  anim_type = "offensive",
  prompt = "#khaavhtous",
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 1,
  -- can_use = function(self, player)
  --   return 
  --   --not player:isKongcheng() 
  --   and 
  --   player:usedSkillTimes(khaavhtous.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and player:canPindian(to_select) 
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, khaavhtous.name)
    if player.dead or target.dead then return end
    if pindian.results[target].winner == player then
      local targets = table.filter(room.alive_players, function (p)
        return p:getMark("@loav")>0
      end)
      if #targets == 0 then return end

      local yes, dat = room:askToUseActiveSkill(player, {
      skill_name = "khaavhtous_active",
      prompt = "#khaavhtous-choose",
      cancelable = true,
      skip = true,  --不執行
      -- extra_data = {
      -- },
      --  = {ids=ids},
      })
      if yes and dat then
        local skill = Fk.skills["khaavhtous_active"]
        skill:onUse(room, {
        from = player,
        tos = dat.targets,
      })
      end
    else
      room:damage{
        from = target,
        to = player,
        damage = 1,
        skillName = khaavhtous.name,
      }
    end
  end,
})

return khaavhtous

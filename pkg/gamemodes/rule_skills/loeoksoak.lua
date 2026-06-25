local loeoksoak = fk.CreateSkill {
  name = "loeoksoak",
}

Fk:loadTranslationTable{
  ["loeoksoak"] = "勒索",
  [":loeoksoak"] = "主旹,与1其它角色拼點發動.若伱贏,伱獲取其1牌,否則其弃1手牌",

  ["#loeoksoak"] = "勒索：与一名角色拼點，若赢，伱獲取其1牌",

  ["$loeoksoak1"] = "不給也得給",
}

loeoksoak:addEffect("active", {
  anim_type = "control",
  prompt = "#loeoksoak",
  card_num = 0,
  target_num = 1,
  card_filter = Util.FalseFunc,
  max_phase_use_time =1,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player and player:canPindian(to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = targets[1]
    local pindian = player:pindian({target}, loeoksoak.name)
    if player.dead then return end
    if pindian.results[target].winner == player then
      local cid = room:askToChooseCard(effect.from, { target = target, flag = "he", skill_name = loeoksoak.name })
      room:obtainCard(effect.from, cid, false, fk.ReasonPrey, effect.from, loeoksoak.name)
    else
    room:askToDiscard(target, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = loeoksoak.name,
        cancelable = false,
        prompt = "#loeoksoak-discard",
        skip = false,
      })   
    end
  end,
})



return loeoksoak

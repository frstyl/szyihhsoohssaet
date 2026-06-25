local tseejsnoans = fk.CreateSkill {
  name = "tseejsnoans"
}

Fk:loadTranslationTable{
  ["tseejsnoans"] = "濟難",
  [":tseejsnoans"] = "距伱距離不大于1之角色A受傷後，若存在在傷源B,伱可預對B使用殺發動.若此殺對B致傷,伱終止當前段(中止結算)",

  ["#tseejsnoans-ask"] = "伱可对 %src 使用【杀】。若致傷則中止此段",

  ["$tseejsnoans1"] = "天下兴亡，侠客当为之己任。",
  ["$tseejsnoans2"] = "隐居江湖之远，敢争天下之先！",
}

tseejsnoans:addEffect(fk.Damaged, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tseejsnoans.name) and target:distanceTo(player) < 2 
    -- and   target:isAlive() and player:isAlive() 
    and data.from and data.from:isAlive() and data.from ~= player
  end,
  on_cost = function(self, event, target, player, data)
    local use = player.room:askToUseCard(player, {
      skill_name = tseejsnoans.name,
      prompt = "#tseejsnoans-ask:" .. data.from.id,
      pattern = "ssaet",
      extra_data = { exclusive_targets = {data.from.id}, bypass_distances = true, bypass_times = true }
    })
    if use then
      event:setCostData(self, use)
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local use = event:getCostData(self)
    use.extra_data = use.extra_data or {}
    use.extra_data.tseejsnoansUser = player.id
    room:useCard(use)
    if use and use.damageDealt and use.damageDealt[data.from] then
      -- player:endCurrentPhase()
      player.room.logic:breakTurn()
    end
  end,
})


return tseejsnoans

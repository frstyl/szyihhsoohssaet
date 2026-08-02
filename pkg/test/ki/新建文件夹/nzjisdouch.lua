local nzjisdouch = fk.CreateSkill({
  name = "nzjisdouch",
})

Fk:loadTranslationTable{
  ["nzjisdouch"] = "二動",
  [":nzjisdouch"] = "主旹,伱",

  ["#nzjisdouch"] = "二動：1其它脚色A賭鬥發動.若伱贏伱迻動1牢,若未贏A予伱1傷",
  ["#nzjisdouch-choose"] = "二動：迻動1牢",

  ["$nzjisdouch1"] = "此乃二動吞狼之计。",
  ["$nzjisdouch2"] = "借你之手，与他一搏吧。",
}

nzjisdouch:addEffect("active", {
  anim_type = "offensive",
  prompt = "#nzjisdouch",
  max_phase_use_time = 1,
  card_num = 0,
  target_num = 1,
  -- can_use = function(self, player)
  --   return 
  --   --not player:isKongcheng() 
  --   and 
  --   player:usedSkillTimes(nzjisdouch.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
    return true
  end,
  on_use = function(self, room, effect)
    local player=effect.from
    local to = room:getCurrent()
    if not to then 
      player:drawCards(30)
    else
      to:drawCards(3)
    end
    player:gainAnExtraTurn(false, nzjisdouch.name, {Player.Play})
      -- player:gainAnExtraPhase(Player.Play, nzjisdouch.name, false)
  end,
})

return nzjisdouch

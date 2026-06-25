local hzaacqhsioc_active = fk.CreateSkill({
  name = "hzaacqhsioc_active&",
})

Fk:loadTranslationTable{
  ["hzaacqhsioc_active&"] = "買凶",
  [":hzaacqhsioc_active&"] = "段限1.交与行凶角色2黑手牌,其視爲使用行刺",

  ["#hzaacqhsioc_active"] = "買凶：選擇2手牌与行凶角色与行刺目幖",
}

hzaacqhsioc_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#hzaacqhsioc_active",
  mute = true,  --誰發動技能?
  card_num = 2,
  target_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(hzaacqhsioc_active.name, Player.HistoryPhase) < 1 
  -- end,
  card_filter = function(self, player, to_select, selected)
    return #selected < 2 and (Fk:getCardById(to_select).color == Card.Black)
  end,
  target_filter = function(self, player, to_select, selected)
    return (
      #selected == 0 and to_select ~= player 
    and to_select:hasSkill("hzaacqhsioc") 
  )
    or (
      #selected==1 and selected[1]:inMyAttackRange(to_select)
    )
  end,

  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    room:notifySkillInvoked(target, "hzaacqhsioc")
    target:broadcastSkillInvoke("hzaacqhsioc")
    room:doIndicate(player.id, { target.id })
    room:moveCardTo(effect.cards, Player.Hand, target, fk.ReasonGive, "hzaacqhsioc", nil, true, player)
    room:useVirtualCard("hzaac_tshjes", nil, target, {effect.tos[2]}, "hzaacqhsioc", true)
  end,
})

return hzaacqhsioc_active

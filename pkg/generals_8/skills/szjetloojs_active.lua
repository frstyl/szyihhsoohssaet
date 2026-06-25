local szjetloojs_active = fk.CreateSkill({
  name = "szjetloojs_active&",
})

Fk:loadTranslationTable{
  ["szjetloojs_active&"] = "打擂",
  [":szjetloojs_active&"] = "段限1.与擂主拼點.若伱未贏,其獲得拼點牌",

  ["#szjetloojs"] = "打擂：選擇擂主 与其拼點 若伱未贏,其獲得拼點牌",
}

szjetloojs_active:addEffect("active", {
  anim_type = "offensive",
  prompt = "#szjetloojs",
  mute = true,  --誰發動技能?
  card_num = 0,
  target_num = 1,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(szjetloojs_active.name, Player.HistoryPhase) < 1 
  -- end,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected < 2 and (Fk:getCardById(to_select).color == Card.Black)
  -- end,
  target_filter = function(self, player, to_select, selected)
    return 
      #selected == 0 and to_select ~= player 
    and to_select:hasSkill("szjetloojs") 

  end,

  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    room:notifySkillInvoked(target, "szjetloojs")
    target:broadcastSkillInvoke("szjetloojs")
    room:doIndicate(player.id, { target.id })

    local pindian = player:pindian({target}, "szjetloojs")

    if target.dead then return end
    if pindian.results[target].winner ~= player then
      local to_get = {}
      local cid = pindian.fromCard and pindian.fromCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insert(to_get, cid)
      end
      local toCard = pindian.results[target].toCard
      cid = toCard and toCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insertIfNeed(to_get, cid)
      end
      if #to_get > 0 then
        room:obtainCard(target, to_get, true, fk.ReasonJustMove, target, "szjetloojs")
      end
    end

  end,
})

return szjetloojs_active

local soakdzoeoj = fk.CreateSkill {
  name = "soakdzoeoj",
}

Fk:loadTranslationTable{
  ["soakdzoeoj"] = "索財",
  [":soakdzoeoj"] = "主旹,与1其它角色拼點發動.若伱:贏,伱獲得拼點牌;未贏,其伱與1傷,伱與其1傷",

  ["#soakdzoeoj"] = "索財：与一名角色拼點，若赢，伱獲得拼點牌",

  ["$soakdzoeoj1"] = "今日撞在我手裏",
}

soakdzoeoj:addEffect("active", {
  anim_type = "control",
  prompt = "#soakdzoeoj",
  card_num = 0,
  target_num = 1,
  card_filter = Util.FalseFunc,
  max_phase_use_time =1,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player and player:canPindian(to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, soakdzoeoj.name)

    if player.dead then return end

    if pindian.results[target].winner == player then
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
      if #to_get > 0  then
        room:obtainCard(player, to_get, true, fk.ReasonJustMove, player, soakdzoeoj.name)
      end
    else
      room:damage{
        to = player,
        from=target,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = soakdzoeoj.name,
      } 
      room:damage{
        to = target ,
        from=player,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = soakdzoeoj.name,
      } 
    end
  end,
})



return soakdzoeoj

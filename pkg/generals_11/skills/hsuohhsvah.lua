local hsuohhsvah = fk.CreateSkill {
  name = "hsuohhsvah",
}

Fk:loadTranslationTable{
["hsuohhsvah"] = "欨火",
[":hsuohhsvah"] = "主旹,伱可選擇1脚色發動,伱予其1火傷,伱判定,若判定牌爲♥️,伱予己1火傷｡与此技能當段上一判定牌同花之牌被使用旹,褈置此技能次數.",

["#hsuohhsvah"]="欨火 判定",
["#hsuohhsvah-choose"] = "欨火 選擇目幖与 %arg牌",
}


hsuohhsvah:addEffect("active", {
  anim_type = "control",
  prompt = "#hsuohhsvah",
  card_num = 0,
  target_num = 1,
  -- can_use = Util.TrueFunc,
  -- card_filter = Util.FalseFunc,
  target_filter = Util.TrueFunc,
  -- max_phase_use_time = 1,
  can_use = function(self, player)
    return player:usedSkillTimes(hsuohhsvah.name, Player.HistoryPhase) == 0
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local to  = effect.tos[1]

    room:damage{
        from = player,
        to = to,
        damage = 1,
        damageType=fk.FireDamage,
        skillName = hsuohhsvah.name,
      }
    if player.dead then return end

    local judgeData = {
      who = player,
      reason = hsuohhsvah.name,
      pattern = ".|.|^spade",
    }
    room:judge(judgeData)
	
    if judgeData.card.suit==Card.Heart then
    room:damage{
        from = player,
        to = player,
        damage = 1,
        damageType=fk.FireDamage,
        skillName = hsuohhsvah.name,
      }
    end
    if player.dead then return end
    room:setPlayerMark(player,"@hsuohhsvah-phase",judgeData.card:getSuitString(true))
  end,
})




hsuohhsvah:addEffect(fk.CardUsing, {
  -- anim_type = "masochism",
  can_refresh = function (self, event, target, player, data)
    return  player:getMark("@hsuohhsvah-phase") == data.card:getSuitString(true)
  end,
  on_refresh = function (self, event, target, player, data)
    player:setSkillUseHistory(hsuohhsvah.name)
  end,
})

return hsuohhsvah

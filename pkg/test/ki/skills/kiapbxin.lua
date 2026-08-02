local kiapbxin = fk.CreateSkill {
  name = "kiapbxin",
}

Fk:loadTranslationTable{
  ["kiapbxin"] = "劫貧",
  [":kiapbxin"] = "其它脚色挩離瀕死後,伱可發動.其占卜,其選擇交予伱1牌与占卜牌同花者或受伱1傷",

  ["#kiapbxin-invoke"] = "劫貧：令 %src 交予伱牌或受傷",

  ["$kiapbxin1"] = "事已至此，当思后策。",
  ["$kiapbxin2"] = "休养生息，无碍徐图天下。",
}


kiapbxin:addEffect(fk.AfterDying, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target:isAlive() 
    and player:hasSkill(kiapbxin.name) and target ~= player 
    -- and player:usedSkillTimes(kiapbxin.name, Player.HistoryRound) == 0
  end,
  on_cost = function (self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = kiapbxin.name,
      prompt = "#kiapbxin-invoke:"..target.id
    }) then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judgeData = {
      who = target,
      reason = kiapbxin.name,
      pattern = ".|.|.",
    }
    room:judge(judgeData)
	  local cards= room:askToCards(target, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = kiapbxin.name,
      pattern = ".|.|"..judgeData.card:getSuitString(),
      prompt = "#kiapbxin-choose",
      cancelable = true,
    })
    if #cards==1 then
      room:moveCardTo(cards, Player.Hand, player, fk.ReasonGive, kiapbxin.name, nil, false, target.id)
    else
      room:damage{
        from = player,
        to = target,
        damage = 1,
        skillName = kiapbxin.name,
      }
    end

  end,
})

return kiapbxin

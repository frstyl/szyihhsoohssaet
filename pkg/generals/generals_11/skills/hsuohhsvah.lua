local hsuohhsvah = fk.CreateSkill {
  name = "hsuohhsvah",
}

Fk:loadTranslationTable{
["hsuohhsvah"] = "欨火",
[":hsuohhsvah"] = "主旹,伱可選擇1脚色發動,伱予其1火傷,伱占卜,若占卜牌爲♥️,伱予己1火傷｡牌進入弃牌堆後,若其中牌与此占卜同花,褈置此技能次數.",

["#hsuohhsvah"]="欨火 占卜",

["#hsuohhsvah-choose"] = "欨火 選擇目幖与 %arg牌",

["@hsuohhsvah-phase"]="欨火",
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
    room:setPlayerMark(player,"@hsuohhsvah-phase",judgeData.card ~=Card.NoSuit and judgeData.card:getSuitString(true) or nil)
  end,
})



hsuohhsvah:addEffect(fk.BeforeCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if  not player:hasSkill(hsuohhsvah.name,true) then return false end

      for _, move in ipairs(data) do
        if  move.toArea == Card.DrawPile then

          for _, info in ipairs(move.moveInfo) do --同旹迻動多脾需檢查來源
            if   player:getMark("@hsuohhsvah-phase") == Fk:getCardById(info.cardId):getSuitString(true) then
              return true
            end
          end
        end
      end

  end,
  on_trigger= function(self, event, target, player, data)
    player:setSkillUseHistory(hsuohhsvah.name,0,Player.HistoryPhase)
  end,
})
-- hsuohhsvah:addEffect(fk.CardUsing, {
--   -- anim_type = "masochism",
--   can_trigger = function (self, event, target, player, data)
--     return  player:getMark("@hsuohhsvah-phase") == data.card:getSuitString(true)
--   end,
--   on_trigger = function (self, event, target, player, data)
--     player:setSkillUseHistory(hsuohhsvah.name)
--   end,
-- })

return hsuohhsvah

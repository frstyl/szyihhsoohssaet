local hsuohhsvah = fk.CreateSkill {
  name = "hsuohhsvah",
}

Fk:loadTranslationTable{
["hsuohhsvah"] = "欨火",
[":hsuohhsvah"] = "主旹,伱可選擇1角色發動,伱予其1火傷,伱判定,若判定牌爲黑桃,此技能視爲未發動.否則伱予己1火傷",  --或當伱受到傷害後

["#hsuohhsvah"]="欨火 判定",
["#hsuohhsvah-choose"] = "欨火 選擇目幖与 %arg牌",
}


hsuohhsvah:addEffect("active", {
  anim_type = "control",
  prompt = "#hsuohhsvah",
  card_num = 0,
  target_num = 0,
  -- can_use = Util.TrueFunc,
  -- card_filter = Util.FalseFunc,
  -- target_filter = Util.TrueFunc,
  max_phase_use_time = 1,
  -- can_use = function(self, player)  --?? 止計自己? active
  --   return player:usedEffectTimes(hsuohhsvah.name, Player.HistoryRound) == 0
  -- end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target  = effect.tos[1]
    local judgeData = {
      who = player,
      reason = hsuohhsvah.name,
      pattern = ".|.|^nosuit",
    }
    room:judge(judgeData)
	
	    local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
      min_card_num = 1,
      max_card_num = 1,
      include_equip=true,
      will_throw=false,
      min_num = 1,
      max_num = 1,
      targets = room:getOtherPlayers(player),  --
      -- targets=player.room.alive_players,
      pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
	  local c=Fk:getCardById(id)
      return not player:prohibitResponse(c) and c.suit==judgeData.card.suit
    end)}),
      skill_name = hsuohhsvah.name,
      prompt = "#hsuohhsvah-choose:::"..judgeData.card:getSuitString(),
      cancelable = true,
    })
	    if #tos ==1 and #cards == 1 then
		      player.room:responseCard({
				card=Fk:getCardById(cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    room:damage{
        from = player,
        to = tos[1],
        damage = 1,
        damageType=fk.FireDamage,
        skillName = hsuohhsvah.name,
      }
	end
    -- if player.dead then return end

    -- if player.dead then return end
    -- if not judgeData:matchPattern() then 
      -- room:damage{
        -- from = player,
        -- to = player,
        -- damage = 1,
        -- damageType=fk.FireDamage,
        -- skillName = hsuohhsvah.name,
      -- }
      -- room:loseHp(player,1,hsuohhsvah.name)
      -- room:invalidateSkill(player, hsuohhsvah.name,"-turn")  --待改
    -- else
      -- player:setSkillUseHistory(hsuohhsvah.name, 0, Player.HistoryGame)
      -- player:setSkillUseHistory(hsuohhsvah.name, 0, Player.HistoryRound)
      -- player:setSkillUseHistory(hsuohhsvah.name, 0, Player.HistoryTurn)
      -- player:setSkillUseHistory(hsuohhsvah.name, 0, Player.HistoryPhase)
    -- end
  end,
})


-- hsuohhsvah_spec={
--   on_cost = function (self, event, target, player, data)
--     local room = player.room
--     local success, dat = room:askToUseActiveSkill(player, {
--       skill_name = "hsuohhsvah",
--       prompt = "#hsuohhsvah:::"..(player:getLostHp()+1),
--       cancelable = true,
--       skip = true,
--     })
--     if success and dat then
--       event:setCostData(self, {tos = dat.targets, choice = dat.interaction})
--       return true
--     end
--   end,
--   on_use = function (self, event, target, player, data)
--     local tos = event:getCostData(self).tos
--     local skill = Fk.skills["hsuohhsvah"]
--     skill.interaction = skill.interaction or {}
--     skill.interaction.data = event:getCostData(self).choice
--     skill:onUse(player.room, {  --useSkill
--       from = player,
--       tos = tos,
--     })
--   end,
-- }

hsuohhsvah:addEffect(fk.Damage, {
  anim_type = "masochism",
  can_refresh = function (self, event, target, player, data)
    return target == player and player:hasSkill(hsuohhsvah.name,true,true)
  end,
  on_refresh = function (self, event, target, player, data)
    player:setSkillUseHistory(hsuohhsvah.name)
  end,
})

return hsuohhsvah

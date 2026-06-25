local ljenqtszuo = fk.CreateSkill {
  name = "ljenqtszuo",
}

Fk:loadTranslationTable{
  ["ljenqtszuo"] = "連珠",
  [":ljenqtszuo"] = "主旹,伱可發動,視爲伱使用弓矢斯張.伱使用弓矢斯張目幖目幖角色需打出2閃響應 且結算期閒,其它角色非鎖定技失效,",

  ["#ljenqtszuo"] = "連珠：視爲使用弓矢斯張",

  [MarkEnum.UncompulsoryInvalidity .. "-phase"] = "非鎖定技失效",

  ["$ljenqtszuo1"] = "且看吾連珠鳴鏑統統亂箭射死",
  -- ["$ljenqtszuo2"] = "",
}

ljenqtszuo:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "kiuc_szjih_sje_ttiac",
  prompt = "#ljenqtszuo",
  -- max_phase_use_time = 1,
  view_as = function(self, player, cards)
    local c = Fk:cloneCard("kiuc_szjih_sje_ttiac")
    c.skillName = ljenqtszuo.name
    return c
  end,
  -- before_use = function (self, player, use)
  --   player.room:addPlayerMark(player,"@loav",1)
  -- end,
  enabled_at_play = function(self, player)
    return player:usedSkillTimes(ljenqtszuo.name, Player.HistoryPhase)==0
  end,
  enabled_at_response = function(self, player, response)
    return false
  end,
})

ljenqtszuo:addEffect(fk.PreCardUse, {
	can_trigger = function(self, event, target, player, data)
		return target==player and player:hasSkill(ljenqtszuo.name) 
    and data.card and data.card.trueName=="kiuc_szjih_sje_ttiac"
	end,
  on_trigger= function(self, event, target, player, data)
    local room=player.room
    for _,p in ipairs(player.room:getOtherPlayers(player)) do

      -- room:addTableMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",event.id)
      room:addPlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
    end

    room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
      for _, p in ipairs(room:getOtherPlayers(player)) do  --
        -- room:removeTableMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", event.id)
        room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", 1)
      end
    end)
  end,
})

ljenqtszuo:addEffect(fk.TargetSpecified, {
	can_trigger = function(self, event, target, player, data)
		return target==player and player:hasSkill(ljenqtszuo.name) 
    and data.card and data.card.trueName=="kiuc_szjih_sje_ttiac"
	end,
  on_trigger= function(self, event, target, player, data)
    local room=player.room
    for _,p in ipairs(player.room:getOtherPlayers(player)) do
      data:setResponseTimes(2,p)
    end
  end,
})

-- ljenqtszuo:addEffect("invalidity", {
--   global = true,
--   invalidity_func = function(self, from, skill)
--     return
--       not skill:hasTag(Skill.Compulsory) and
--       skill:isPlayerSkill(from) and
--       -- #from:getTableMark(MarkEnum.UncompulsoryInvalidity .. "-phase")>0
--       from:getMark(MarkEnum.UncompulsoryInvalidity .. "-phase")>0
--   end
-- })
return ljenqtszuo

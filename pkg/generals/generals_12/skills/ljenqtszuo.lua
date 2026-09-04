local ljenqtszuo = fk.CreateSkill {
  name = "ljenqtszuo",
}

Fk:loadTranslationTable{
  ["ljenqtszuo"] = "連珠",
  [":ljenqtszuo"] = "主旹,伱可發動,伱起動虛擬｢弓矢斯張｣.此｢弓矢斯張｣目幖目幖脚色需打出2閃響應或受到1火傷,結算期閒,全體脚色非必發技失效,",

  ["#ljenqtszuo"] = "連珠：起動虛擬弓矢斯張",

  -- [MarkEnum.UncompulsoryInvalidity .. "-phase"] = "非必發技失效",

  ["$ljenqtszuo1"] = "且看吾連珠鳴鏑統統亂箭射死",
  -- ["$ljenqtszuo2"] = "",
}

-- ljenqtszuo:addEffect("viewas", {
--   anim_type = "offensive",
--   pattern = "kiuc_szjih_sje_ttiac",
--   prompt = "#ljenqtszuo",
--   -- max_phase_use_time = 1,
--   view_as = function(self, player, cards)
--     local c = Fk:cloneCard("kiuc_szjih_sje_ttiac")
--     c.skillName = ljenqtszuo.name
--     return c
--   end,
--   -- before_use = function (self, player, use)
--   --   player.room:addPlayerMark(player,"@loav",1)
--   -- end,
--   enabled_at_play = function(self, player)
--     return player:usedSkillTimes(ljenqtszuo.name, Player.HistoryPhase)==0
--   end,
--   enabled_at_response = function(self, player, response)
--     return false
--   end,
-- })

ljenqtszuo:addEffect("active", {
  anim_type = "drawcard",
  prompt = "#ljenqtszuo",
  max_phase_use_time = 1,
  target_num = 0,
  min_card_num = 0,
  -- card_filter = function(self, player, to_select)
  --   return not player:prohibitDiscard(to_select)
  -- end,
  on_use = function(self, room, effect)
    local player = effect.from
    local card = Fk:cloneCard("kiuc_szjih_sje_ttiac")
    card.skill=Fk.skills["ljenqtszuo__kiuc_szjih_sje_ttiac_skill"]
    card.skillName = ljenqtszuo.name

    room:useCard{  --bypase times
      from = player,
      tos = card:getDefaultTarget(player),
      card = card,
      -- extraUse=true,
    }
  end,
})

-- ljenqtszuo:addEffect(fk.PreCardUse, {
-- 	can_trigger = function(self, event, target, player, data)
-- 		return target==player and player:hasSkill(ljenqtszuo.name) 
--     and data.card and data.card.trueName=="kiuc_szjih_sje_ttiac"
-- 	end,
--   on_trigger= function(self, event, target, player, data)
--     local room=player.room
--     for _,p in ipairs(player.room.players) do

--       -- room:addTableMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",event.id)
--       room:addPlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase",1)
--     end

--     room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
--       for _, p in ipairs(room.players) do  --
--         -- room:removeTableMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", event.id)
--         room:removePlayerMark(p,MarkEnum.UncompulsoryInvalidity .. "-phase", 1)
--       end
--     end)
--   end,
-- })

-- ljenqtszuo:addEffect(fk.TargetConfirmed, {
-- 	can_refresh = function(self, event, target, player, data)
-- 		return data.from==player 
--     -- and player:hasSkill(ljenqtszuo.name) 
--     and data.card 
--     and data.card.trueName=="kiuc_szjih_sje_ttiac"
--     and data.card.skillName == "ljenqtszuo"
-- 	end,
--   on_refresh= function(self, event, target, player, data)
--     local room=player.room
--       data:setResponseTimes(2,p)
--   end,
-- })

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

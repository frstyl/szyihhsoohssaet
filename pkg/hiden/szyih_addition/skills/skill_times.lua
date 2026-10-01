local skill_times = fk.CreateSkill {
  name = "skill_times_skill",
}

Fk:loadTranslationTable{
["skill_times"] = "每輪技能發動次數",
[":skill_times"] = "每脚色每非必發技每輪限發動6次.到达數後技能失效.包括裝僃技能,武將牌技能,衍生技能",
}



skill_times:addEffect(fk.SkillEffect, {
  -- global=true,
  priority=999,
  can_refresh = function(self, event, target, player, data)
    return data.who == player 
    and not data.skill.cardSkill
  end,
  on_refresh = function(self, event, target, player, data)
    -- if player.skillUsedHistory[data.skill.name] then player:drawCards(2) end
    -- if data.skill.name==data.skill:getSkeleton().name then player:drawCards(2) end  --无法單封1號 1號作main
    -- player.room:setPlayerMark(player,"@skill",data.skill.name)

    local t=player:getTableMark("skill_times-round")
    t[data.skill.name]=(t[data.skill.name] or 0) +1
    player.room:setPlayerMark(player,"skill_times-round",t)

    if t[data.skill.name]>= math.max(6,#player.room.players)
      -- and not table.contains(player.room.disabled_packs, "skill_times_round")
    then
      -- player.room:addSkill()
      player.room:invalidateSkill(player, data.skill.name, "-round")
    end
  end,
})

-- skill_times:addEffect("invalidity", {
--   -- global = true,
--   invalidity_func = function(self, from, skill)
--     return
--       not skill:hasTag(Skill.Compulsory)   --裝態效果 ??
--       -- and
--       -- skill:isPlayerSkill(from) 
--       -- and
--       -- #from:getTableMark("@@ljenqtszuo-phase")>0
--       (from:getTableMark("skill_times-round")[skill.name] or 0 )>4
--   end
-- })

return skill_times

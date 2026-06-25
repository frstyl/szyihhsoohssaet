local skill_times = fk.CreateSkill {
  name = "skill_times_skill",
}

Fk:loadTranslationTable{
["skill_times"] = "每輪技能發動次數",
[":skill_times"] = "每角色每非鎖定技每輪限發動5次.到达數後技能失效.包括裝僃技能,武將牌技能,衍生技能",
}

skill_times:addEffect("cardskill", {
  can_use = Util.FalseFunc,
})


skill_times:addEffect(fk.SkillEffect, {  --skillUsedHistory 同  cardUsedHistory 可能无計次數或緟置
  -- global=true,
  priority=999, --禁插入結算
  can_trigger = function(self, event, target, player, data)
    return data.who == player 
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:addPlayerMark(player,data.skill.name.."-use_times-phase",1)
    player.room:addPlayerMark(player,data.skill.name.."-use_times-turn",1)

    -- player:drawCards(1,skill_times.name)
    local t=player:getTableMark("skill_times-round")
    t[data.skill.name]=(t[data.skill.name] or 0) +1
    player.room:setPlayerMark(player,"skill_times-round",t)

    if t[data.skill.name]==5 
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

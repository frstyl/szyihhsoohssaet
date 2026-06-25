Fk:loadTranslationTable{
  ["mxenhlik"] = "勉力",
  [":mxenhlik"] = "任一轉終旹伱可發動,伱抽1+x(x爲伱本轉伱發動角色技能次數)",  --技能發動數? 飛針?


  ["@mxenhlik-turn"] = "勉力",

  ["$mxenhlik1"] = "繡得軍旗振軍威",
  ["$mxenhlik2"] = "繡得衿袍壯士气",
}

local mxenhlik = fk.CreateSkill{
  name = "mxenhlik",
}

mxenhlik:addEffect(fk.SkillEffect, {
  anim_type = "drawcard",
  can_refresh = function(self, event, target, player, data)
    return player:hasSkill(mxenhlik.name) 
      and target == player
      and data.skill:isPlayerSkill(player) 
      -- and target:hasSkill(data.skill:getSkeleton().name, true, true)
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    room:addPlayerMark(player, "@mxenhlik-turn", 1)
  end,
})
--EventPhaseStart --and target.phase == Player.Finish
mxenhlik:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(mxenhlik.name) 
  end,
  on_use = function(self, event, target, player, data)
    -- player:drawCards(1 + player:usedEffectTimes("pujqtszjim", Player.HistoryTurn), mxenhlik.name)  --bug
    player:drawCards(1 + player:getMark("@mxenhlik-turn"), mxenhlik.name)  --bug
  end,
})


return mxenhlik

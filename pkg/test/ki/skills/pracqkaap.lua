local pracqkaap = fk.CreateSkill {
  name = "pracqkaap",
}

Fk:loadTranslationTable{
  ["pracqkaap"] = "兵甲",
  [":pracqkaap"] = "額定抽牌旹發動,抽牌數+ max(1,2*(6-伱冣大體力值))",

  ["#pracqkaap-invoke"] = "兵甲：多抽%arg",

  ["$pracqkaap1"] = "拿去拿去，莫跟哥哥客气！",
  ["$pracqkaap2"] = "来来来，见面分一半。",
}


pracqkaap:addAcquireEffect(function (self, player)
    -- player.hp=player.maxHp
    -- player.room:broadcastProperty(player, "hp")
    player.room:setPlayerMark(player,pracqkaap.name,player.maxHp)
end)
-- pracqkaap:addEffect(fk.EventAcquireSkill, {
--   on_trigger = function(self, event, target, player, data)
--     player.hp=player.maxHp
--     player.room:broadcastProperty(player, "hp")
-- end,
-- })
pracqkaap:addEffect(fk.DrawNCards, {
  anim_type = "drawcard",
  can_trigger= function(self, event, target, player, data)  --triggerable
    return  
    -- true
    target==player and player:hasSkill(pracqkaap.name)
  end,
  on_cost= function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = pracqkaap.name,
      prompt = "#pracqkaap-invoke:::"..math.max(1,2*(6-player.maxHp)),
    })
  end,
  on_use = function(self, event, target, player, data)
    -- data.n = data.n + math.max(1,2*(6-player.maxHp))
    data.n=data.n + player:getMark(pracqkaap.name)
  end,
})

-- pracqkaap:addEffect(fk.BeforeMaxHpChanged, {
--   can_refresh = function (self, event, target, player, data)
--     return target == player and player:hasSkill(pracqkaap.name, true)
--   end,
--   on_refresh = function (self, event, target, player, data)
--     data:preventMaxHpChange()
--   end,
-- })

return pracqkaap

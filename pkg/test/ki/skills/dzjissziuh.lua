local dzjissziuh = fk.CreateSkill {
  name = "dzjissziuh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["dzjissziuh"] = "自守",
  [":dzjissziuh"] = "伱起動牌不能選擇其它脚色爲目幖｡伱不能響應牌目幖非伱者", 

  ["@@dzjissziuh"] = "自守",  --自定旹与全局  --死旹解?
  ["@@dzjissziuh-turn"] = "自守",
  ["@@dzjissziuh-phase"] = "自守",
  ["@@dzjissziuh-round"] = "自守",

}


dzjissziuh:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return from and from:hasMark("@@dzjissziuh")  and card and from ~= to
  end,
})

dzjissziuh:addEffect(fk.PreCardEffect, {
  priority = 0.001,  --稍前
  can_refresh = function(self, event, target, player, data)
    return player.seat==1 and data.to
  end,
  on_refresh = function(self, event, target, player, data)
    for _, p in ipairs(player.room.players) do
      if p:hasMark("@@dzjissziuh") then
         table.insertIfNeed(data.disresponsiveList,p)
      end
    end
  end,
})

return dzjissziuh

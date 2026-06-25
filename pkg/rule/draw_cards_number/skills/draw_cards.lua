local draw_cards = fk.CreateSkill {
  name = "draw_cards_skill",
}


draw_cards:addEffect("cardskill", {
  can_use = Util.FalseFunc,
})


draw_cards:addEffect(fk.BeforeDrawCard, {--改變旹
  -- global=true,
  priority=999, --禁插入結算
  can_trigger = function(self, event, target, player, data)
    return data.who == player and data.num>5 
  end,
  on_trigger = function(self, event, target, player, data)
    if data.skillName=="phase_draw" then
      data.num = math.max(7,data.num)
    else
     data.num=5
    end
  end,
})


return draw_cards

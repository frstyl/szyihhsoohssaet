local dzjemqhqveen = fk.CreateSkill {
  name = "dzjemqhqveen",
  tags = {Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["dzjemqhqveen"] = "潛淵",
  [":dzjemqhqveen"] = "伱抽牌改爲自牌堆底。牌堆底x牌對伱可見且伱可如手牌起動演練之(x爲伱已損體力值至少爲1)",

  ["$dzjemqhqveen_xuyou1"] = "哼！目光所及，短寸之间。",
  ["$dzjemqhqveen_xuyou2"] = "狭目之见，只能窥底。",
}

dzjemqhqveen:addEffect(fk.BeforeDrawCard, {
  anim_type = "negative",
  on_trigger = function(self, event, target, player, data)
    data.fromPlace = "bottom"
  end,
})

dzjemqhqveen:addEffect("filter", {
  handly_cards = function (self, player)
    if player:hasSkill("dzjemqhqveen") then
      local t={}
      local n =math.max(1,player:getLostHp())
      local m = #Fk:currentRoom().draw_pile
      if m>=n then
        for i=1,n,1 do
        table.insert(t,Fk:currentRoom().draw_pile[m+1-i])
        end
      else
        t = Fk:currentRoom().draw_pile
      end
      return t
    end
  end,
})

return dzjemqhqveen

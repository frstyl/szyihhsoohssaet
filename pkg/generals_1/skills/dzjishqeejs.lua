local dzjishqeejs = fk.CreateSkill {
  name = "dzjishqeejs",
  tags={Skill.Limited}
}

Fk:loadTranslationTable{
  ["dzjishqeejs"] = "自縊",
  [":dzjishqeejs"] = "主旹,伱可選擇至多1其它角色發動.伱死亾,所選角色體力回復至體力上限",  

  ["#dzjishqeejs-active"] = "自縊 將半數手牌交与1角色,其執行額外主段",

  ["$dzjishqeejs1"] = "以吾萬串家財,助伱一臂之力",

}


dzjishqeejs:addEffect("active", {
  anim_type = "support",
  prompt = "#dzjishqeejs-active",
  card_num = 0,
  min_target_num = 0,
  max_target_num = 1,
  -- can_use = function(self, player)
  --   return  player:usedSkillTimes(dzjishqeejs.name, Player.HistoryGame) == 0
  -- end,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected < (1 + player:getHandcardNum()) // 2 and table.contains(player:getCardIds("h"), to_select)
  -- end,
  -- target_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and to_select ~= player and to_select:isWounded()
  -- end,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"預段","伏段","補段","主段","撤段","末段"}
  --     --  choices ={Player.Start, Card.Judge, Player.Draw, Player.Play, Player.Discard, Player.Finish}
  --   }
  -- end,
  on_use = function(self, room, effect)
    local player = effect.from
    room:killPlayer{
      who = player,
      killer = player,
    }
    local to=effect.tos[1]
    if effect.tos[1] and not effect.tos[1].dead and effect.tos[1].isWounded() then
      room:recover{
        who = effect.tos[1],
        num = effect.tos[1]:getLostHp(),
        recoverBy = player,
        skillName = dzjishqeejs.name,
      }      
    end
  end,
})

return dzjishqeejs

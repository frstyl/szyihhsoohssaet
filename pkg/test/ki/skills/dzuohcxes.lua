local dzuohcxes = fk.CreateSkill {
  name = "dzuohcxes",
  tags = { Skill.Compulsory,Skill.Lord},
}

Fk:loadTranslationTable{
  ["dzuohcxes"] = "聚義",  --星列
  [":dzuohcxes"] = "鎖，伱手牌上限+1。當伱手牌含有13種點數,伱獲勝",
}

dzuohcxes:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(dzuohcxes.name) then
      return 1
    end
  end,
})

dzuohcxes:addEffect(fk.AfterCardsMove, {
  anim_type = "big",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(dzuohcxes.name)  or player:getHandcardNum()<13 then return end
    local numbers={}
    for i=1,13,1 do
       numbers[i]=false 
    end
    
    for _, id in ipairs(player:getCardIds("h")) do
      number=Fk:getCardById(id).number
      numbers[number]=true
    end
    for i=1,13,1 do
      if numbers[i]~=true then return end
    end

     return true
  end,
  on_use = function (self, event, target, player, data)
    if player.role == "lord" or player.role == "loyalist" then  --若爲xx模式
      player.room:gameOver("lord+loyalist")
    else
      player.room:gameOver(player.role)
    end
  end,
})

return dzuohcxes

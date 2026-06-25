local leecqdeek = fk.CreateSkill {
  name = "leecqdeek",
}

Fk:loadTranslationTable{
["leecqdeek"] = "靈笛",
[":leecqdeek"] = "當伱受傷後伱可發動x次｡選擇1角色,其增或減1牢,抽1.x爲傷害值.",
["#leecqdeek-choose"] = "靈笛: 選擇目幖 其增減牢抽1",
["#leecqdeek-choose2"] = "靈笛:  增減牢",

["#leecqdeek-add"] = "靈笛 增牢",
["#leecqdeek-mimus"] = "靈笛 減牢",
}

leecqdeek:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target==player and  player:hasSkill(leecqdeek.name)
  end,
  trigger_times = function(self, event, target, player, data)
      return data.damage
  end,
  on_cost = function(self, event, target, player, data)

    local to = player.room:askToChoosePlayers(player,{
      min_num = 1,
      max_num = 1,
      targets = player.room:getAlivePlayers(),
      skill_name = leecqdeek.name,
      prompt = "#leecqdeek-choose",
      cancelable = true,
      })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local to = event:getCostData(self).tos[1]
    if to.dead then return end
    local room=player.room
    local choice =""

    if to:getMark("@loav")==0 then
            choice ="#leecqdeek-add"
    else
      choice=room:askToChoice(player,{
        choices = {"#leecqdeek-add","#leecqdeek-mimus"},
        skill_name = leecqdeek.name,
        prompt = "#leecqdeek-choose2",
      })
    end
    if choice == "#leecqdeek-add" then
  	  room:addPlayerMark(to, "@loav",1)
    else 
      room:removePlayerMark(to, "@loav",1)
    end
	-- to:turnOver()    
	  if not to.dead then
      to:drawCards(1, leecqdeek.name)
    end
  end,
})



-- leecqdeek:addRelatedSkill(loav)

return leecqdeek

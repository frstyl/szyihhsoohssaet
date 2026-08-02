local tousmuoh = fk.CreateSkill{
  name = "tousmuoh",
}

Fk:loadTranslationTable{
  ["tousmuoh"] = "鬥武",
  [":tousmuoh"] = "輪始旹,伱選擇1其它脚色A發動｡A執行1項➀應戰,与伱互計距離爲1,｢殺｣止能選對方爲目幖➁避戰,自守1輪",

  ["#tousmuoh-choose"] = "鬥武：選擇1其它脚色A 應戰",
  ["#tousmuoh-ask"] = "鬥武： 是否應戰%src",

  ["@@tousmuoh-round"] = "鬥武",

  ["$tousmuoh1"] = "",
}


tousmuoh:addEffect(fk.RoundStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tousmuoh.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room:getOtherPlayers(player, false),
      skill_name = tousmuoh.name,
      prompt = "#tousmuoh-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    -- local choice = room:askToChoice(to, {
    --     choices = {""}, 
    --     -- all_choices=choices,
    --     skill_name = tousmuoh.name, 
    --     prompt = "#tousmuoh-choose:"..player.id,
    --     -- detailed=true,
    --   })
    --   room:sendLog{
    --     type = "#Choice",
    --     from = to.id,
    --     arg = choice,
    --     toast = true,
    --   }
    if room:askToSkillInvoke(to, { skill_name = tousmuoh.name,prompt="#dzjissziuh-ask:"..player.id })then
      room:addTableMark(to,"@@tousmuoh-round" ,player.id)
      room:addTableMark(player,"@@tousmuoh-round" ,to.id)
    else
      room:addSkill("dzjissziuh")
      room:addPlayerMark(to, "@@dzjissziuh", 1)
    end
  end,
})

tousmuoh:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    if from:getMark("@@tousmuoh-round")~=0 and card.trueName=="ssaet" then
    return not table.contains(from:getTableMark("@@tousmuoh-round"),to.id)  --雙嘲諷 都不能打?--異空閒?
    --  or #from:getTableMark("@@tousmuoh-round")~=0
    end
  end,
})

tousmuoh:addEffect("distance", {
  fixed_func = function(self, from, to)
    if from:getMark("@@tousmuoh-round")~=0  and table.contains(from:getTableMark("@@tousmuoh-round"),to.id) then
      return 1
    end
  end,
})

return tousmuoh

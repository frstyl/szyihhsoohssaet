local pikhzaoc = fk.CreateSkill{
  name = "pikhzaoc",
}
--kiamsquoh  
Fk:loadTranslationTable{
  ["pikhzaoc"] = "逼降",  --還是白板
  [":pikhzaoc"] = "➀伱使用殺結算終伱對目幖角色A可發動.若此殺對A➀致傷,A需交与伱1牌,自守;➁未致傷,伱選擇獲得技能｢刀兵｣或｢劍雨｣.伱轉始旹,清除此技能效果",--死旹清

  ["#pikhzaoc-invoke"] = "逼降 對 %src 致傷,是否發動",
  ["#pikhzaoc-no-invoke"] = "逼降 未對 %src 致傷,是否發動",

  ["@@pikhzaoc"] = "逼降",  --table 看
  ["@pikhzaoc"] = "逼降",

  ["#pikhzaoc-give"] = "逼降 交与%src 1牌",

  ["$pikhzaoc1"] = "伱等旣不願降,莫",
}



pikhzaoc:addEffect(fk.CardUseFinished, {
  can_trigger = function(self, event, target, player, data)
    return player == target and data.card and data.card.trueName == "ssaet" and player:hasSkill(pikhzaoc.name)
  end,
  on_trigger = function(self, event, target, player, data)
    for _, p in ipairs(data.tos) do
      if not player:hasSkill(pikhzaoc.name) then break end
      local damaged = true
      if (data.damageDealt==nil or data.damageDealt[p]==nil or data.damageDealt[p]==0) then
      damaged=false
      end
        event:setCostData(self, {tos = {p},damaged=damaged})
        self:doCost(event, target, player, data)
    end
  end,
  on_cost = function(self, event, target, player, data)
    local to = event:getCostData(self).tos[1]
    local prompt=""
    if  event:getCostData(self).damaged then
      prompt="#pikhzaoc-invoke:"..to.id
    else
      prompt="#pikhzaoc-no-invoke:"..to.id
    end
    return player.room:askToSkillInvoke(player, {
      skill_name = pikhzaoc.name,
      prompt = prompt,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room =player.room
    local to =event:getCostData(self).tos[1]
    if  event:getCostData(self).damaged then
      local cards = room:askToCards(to, {
        min_num = 1,
        max_num = 1,
        skill_name = pikhzaoc.name,
        pattern = ".",
        prompt = "#pikhzaoc-give:"..player.id,
        cancelable = false,
      })
      if #cards > 0 then
        room:moveCardTo(cards, Player.Hand, player, fk.ReasonGive, pikhzaoc.name, nil, false, to.id)
      end
      -- data:setNullified(to)
      -- data:setDisresponsive(to)
      room:addTableMark(player, "@@pikhzaoc", to.id)
      room:addPlayerMark(player, "@@dzjissziuh", 1)
      room:addSkill("dzjissziuh")
    else

      local all_choices={"toavqprac","kiamsquoh"}
      local choices={}
      for _, name in ipairs(all_choices) do
        if not player:hasSkill(name,true,true) then
          table.insert(choices,name)
        end
      end
      if #choices==0 then return end
      local skill_name = room:askToChoice(player, {
        choices = choices, 
        all_choices=all_choices,
        skill_name = pikhzaoc.name, 
        prompt = "#pikhzaoc-skill" ,
        detailed=true,
      })
      room:sendLog{
        type = "#Choice",
        from = player.id,
        arg = skill_name,
        toast = true,
      }
      room:handleAddLoseSkills(player, skill_name)
      room:addTableMark(player, "pikhzaoc_skill", skill_name)
      -- room.logic:getCurrentEvent():findParent(GameEvent.Turn):addCleaner(function()
      --   room:handleAddLoseSkills(player, "-"..skill_name)
      -- end)

    end
  end,
})


-- pikhzaoc:addEffect("prohibit", {
--   is_prohibited = function(self, from, to, card)
--     return card and from and  to and (
--       -- table.contains(from:getTableMark("@@pikhzaoc"), to.id)
--     -- or
--       table.contains(to:getTableMark("@@pikhzaoc"), from.id)
--     )
--   end,
-- })

-- pikhzaoc:addEffect(fk.CardUsing, {
--   -- mute = true,
--   can_refresh = function(self, event, target, player, data)
--     return data.from==player and player:getMark("@@pikhzaoc")~=0 
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     player:broadcastSkillInvoke(pikhzaoc.name)
--     data.disresponsiveList = data.disresponsiveList or {}
--     room:notifySkillInvoked(player, pikhzaoc.name, "offensive")
--     local tos=table.map(player:getTableMark("@@pikhzaoc"), Util.Id2PlayerMapper)
--     table.insertTableIfNeed(data.disresponsiveList, tos)
--   end,
-- })

pikhzaoc:addEffect(fk.TurnStart, {
  can_refresh = function(self, event, target, player, data)
    return player == target   and (player:getMark("@@pikhzaoc")~=0 or player:getMark("pikhzaoc_skill")~=0 )
  end,
  on_refresh = function(self, event, target, player, data)
    local room=player.room
    if player:getMark("@@pikhzaoc")~=0  then
      for _, p in ipairs(player:getMark("@@pikhzaoc")) do
        room:removePlayerMark(p,"@@dzjissziuh",1)
      end
        room:setPlayerMark(p,"@@pikhzaoc",nil)
    end

    player.room:setPlayerMark(player, "@@pikhzaoc", nil)
    if player:getMark("pikhzaoc_skill")~=0  then
      player.room:handleAddLoseSkills(player, "-"..table.concat(player:getMark("pikhzaoc_skill"), "|-"))
    end
  end,
})



return pikhzaoc

local giocstseejs = fk.CreateSkill {
  name = "giocstseejs",
}

Fk:loadTranslationTable{
  ["giocstseejs"] = "共濟",
  [":giocstseejs"] = "輪始旹,伱可選1至x(x=Ceiling(存活角色數/2))其他角色發動.伱獲得各所選角色各1手牌,肰後伱各交与其1手牌",

  -- ["#giocstseejs"] = "共濟 選擇角色",
  ["#giocstseejs-choose"] = "共濟 選擇 %arg 角色",
  ["#giocstseejs-give"] = "共濟 交与%src 1牌",

  ["$giocstseejs1"] = "人人爲公,天下大同",
  ["$giocstseejs2"] = "有福同享,有難同當",
}

-- giocstseejs:addEffect("active", {
--   anim_type = "control",
--   min_target_num = 1,
--   max_target_num = function(self, player)
--       return  (1+#player.room.alive_players)//2
--   end,
--   prompt = "#giocstseejs",
--   can_use = function(self, player)
--     return player:usedSkillTimes(giocstseejs.name, Player.HistoryPhase) == 0
--   end,
--   card_filter = Util.FalseFunc,
--   target_filter = function(self, player, to_select, selected)
--       return   to_select~=player
--   end,
--   on_use = function(self, room, effect)
--     local from=effect.from
--     room:sortByAction(effect.tos)  --自選序?
--     for _, p in ipairs(effect.tos) do
--       if not (p.dead or from.dead p:isKongcheng()) then
--           local cid = room:askToChooseCard(effect.from, { 
--           target = p, 
--           flag = "h", 
--           skill_name = giocstseejs.name, 
--         })
--         room:obtainCard(from, cid, false, fk.ReasonPrey, from, giocstseejs.name,nil,nil)
--      end
--     end

--     for _, p in ipairs(effect.tos) do
--       if not (p.dead or from.dead or from:isKongcheng()) then
--         local cid = room:askToCards(from, { 
--           min_num =1, 
--           max_num =1,
--           include_equip = false,
--           skill_name = giocstseejs.name, 
--           prompt="#giocstseejs-give:"..p.id,
              -- cancelable=false,
--         })
--         room:moveCardTo(cid, Player.Hand, p, fk.ReasonGive, giocstseejs.name, nil, false, from.id)
--       end
--     end
--   end,
-- })

giocstseejs:addEffect(fk.RoundStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(giocstseejs.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local n =(1+#room.alive_players)//2
    targets = room:askToChoosePlayers(player, {
      targets = room:getOtherPlayers(player),
      min_num = 1,
      max_num = n,
      prompt = "#giocstseejs-choose:::"..n,
      skill_name = giocstseejs.name,
      cancelable = false,
    })
    if #targets==0 then return end
    room:sortByAction(targets)
    event:setCostData(self,{tos=targets})
    return true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos=event:getCostData(self).tos
    for _, p in ipairs(tos) do
      if not (p.dead or player.dead or p:isKongcheng()) then
          local cid = room:askToChooseCard(player, { 
          target = p, 
          flag = "h", 
          skill_name = giocstseejs.name, 
        })
        room:obtainCard(player, cid, false, fk.ReasonPrey, player, giocstseejs.name,nil,nil)
     end
    end

    for _, p in ipairs(tos) do
      if not (p.dead or player.dead or player:isKongcheng()) then
        local cid = room:askToCards(player, { 
          min_num =1, 
          max_num =1,
          include_equip = false,
          skill_name = giocstseejs.name, 
          prompt="#giocstseejs-give:"..p.id,
          cancelable=false,
        })
        room:moveCardTo(cid, Player.Hand, p, fk.ReasonGive, giocstseejs.name, nil, false, player.id)
      end
    end
  end,
})

return giocstseejs

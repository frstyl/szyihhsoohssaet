local hsicqloan = fk.CreateSkill {
  name = "hsicqloan",
}

Fk:loadTranslationTable {
  ["hsicqloan"] = "興瀾",
  [":hsicqloan"] = "伱伏段始歬,若場上:有延旹牌,伱可打出1牌發動,將1腳色伏區內牌迻至除其外腳色伏區;无延旹牌,伱可將1牌轉化爲｢海嘯｣置于1腳色伏區｡",
  -- [":hsicqloan"] = "伱伏段始歬,伱可選一脚色伏區1牌發動.伱將其迻動至別一脚色伏區,伱可緟複此流程.伱越過此段伏段補段",

  ["#hsicqloan-choose"] = "興瀾：選擇伏區有牌腳色",
  ["#hsicqloan-choose2"] = "興瀾：選擇腳色2",
  ["#hsicqloan-use"] = "興瀾 轉化海嘯",

  ["$hsicqloan1"] = "准备受死吧！",

}

hsicqloan:addEffect(fk.EventPhaseChanging, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hsicqloan.name) and data.phase == Player.Judge 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if table.find(player.room.alive_players,  function(p)
      return  #p:getCardIds("j")>0
      end) 
    then
    local to1 = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players , 
      function(p)
      return  #p:getCardIds("j")>0
      end),
          min_num = 1,
          max_num = 1,
          prompt = "#hsicqloan-choose",
          skill_name = hsicqloan.name,
          cancelable = true,
        })

      if #to1==0 then return end
      -- local card = room:askToChooseCard(player,{
      --   target = to1[1],
      --   flag = "j",
      --   skill_name = hsicqloan.name,
      --   })
            
        local to2 = room:askToChoosePlayers(player, {
          targets = table.filter(room.alive_players ,function(p)
          return  p~=to1[1]
          end),
          min_num = 1,
          max_num = 1,
          prompt = "#hsicqloan-choose2",
          skill_name = hsicqloan.name,
          cancelable = true,
        })
      if #to2==0 then return end
      event:setCostData(self, { tos={to1[1],to2[1]}} )
      return true
    else
        local tos, cards = player.room:askToChooseCardsAndPlayers(player, {
          min_card_num = 1,
          max_card_num = 1,
          include_equip=true,
          -- will_throw=true,
          min_num = 1,
          max_num = 1,
          targets = room.alive_players,
          pattern = ".",
          skill_name = hsicqloan.name,
          prompt = "#hsicqloan-use",
          cancelable = true,
        })
        if #tos > 0 and #cards > 0 then
          event:setCostData(self, {tos = tos, cards = cards})
          return true
        end
    end

  end,
  on_use = function(self, event, target, player, data)
    local tos=event:getCostData(self).tos
    if tos[2] then
      local cards=tos[1]:getCardIds("j")
      player.room:moveCardTo(cards, Player.Judge, tos[2], fk.ReasonPut, hsicqloan.name,nil,false,player)  --无视合法性检测
    else
          local card = Fk:cloneCard("hsoeojh_seevs")
          card:addSubcard(event:getCostData(self).cards[1])
          tos[1]:addVirtualEquip(card)
          player.room:moveCardTo(card, Player.Judge, tos[1], fk.ReasonPut, hsicqloan.name,nil,false,player)  --无视合法性检测
    end
  end,
})



-- hsicqloan:addEffect(fk.EventPhaseChanging, {
--   anim_type = "control",
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(hsicqloan.name) and data.phase == Player.Judge 
--     and #table.filter(player.room.alive_players,       function(p)
--       return  #p:getCardIds("j")>0
--       end)>0
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local to1 = room:askToChoosePlayers(player, {
--           targets = table.filter(room.alive_players , 
--       function(p)
--       return  #p:getCardIds("j")>0
--       end),
--           min_num = 1,
--           max_num = 1,
--           prompt = "#hsicqloan-choose",
--           skill_name = hsicqloan.name,
--           cancelable = true,
--         })

--       if #to1==0 then return end
--       local card = room:askToChooseCard(player,{
--         target = to1[1],
--         flag = "j",
--         skill_name = hsicqloan.name,
--         })
            
--         local to2 = room:askToChoosePlayers(player, {
--           targets = table.filter(room.alive_players ,function(p)
--           return  p~=to1[1]
--           end),
--           min_num = 1,
--           max_num = 1,
--           prompt = "#hsicqloan-choose2",
--           skill_name = hsicqloan.name,
--           cancelable = true,
--         })
--       if #to2==0 then return end
--       event:setCostData(self, {cards=card, tos={to1[1],to2[1]}})
--       return true
--   end,
--   on_use = function(self, event, target, player, data)
--       data.skipped = true
--       player:skip(Player.Draw)
--     local room = player.room
--     local to1 = event:getCostData(self).tos[1]
--     local to2 = event:getCostData(self).tos[2]
--     room:moveCardTo(event:getCostData(self).cards, Card.PlayerJudge, to2, Fk.ReasonPut, hsicqloan.name,nil,true,player)

--     while 1 do
--       if #to1:getCardIds("j")==0 then return end
--       local card = room:askToChooseCard(player,{
--         target = to1,
--         flag = "j",
--         skill_name = hsicqloan.name,
--         })
            
--          to2 = room:askToChoosePlayers(player, {
--           targets = table.filter(room.alive_players ,function(p)
--           return  p~=to1
--           end),
--           min_num = 1,
--           max_num = 1,
--           prompt = "#hsicqloan-choose2",
--           skill_name = hsicqloan.name,
--           cancelable = true,
--         })
--       if #to2==0 then return end
--     room:moveCardTo(card, Card.PlayerJudge, to2[1], Fk.ReasonPut, hsicqloan.name,nil,true,player)  --緟流程 止發動1次
--       end

--   end,
-- })

return hsicqloan

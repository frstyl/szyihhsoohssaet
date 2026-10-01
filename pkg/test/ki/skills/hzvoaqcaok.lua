local hzvoaqcaok = fk.CreateSkill{
  name = "hzvoaqcaok",
  tags={Skill.Contract},  -- Skill.Compulsory
}

Fk:loadTranslationTable{
  ["hzvoaqcaok"] = "龢樂",  --獨奏 合奏 閒奏
  [":hzvoaqcaok"] = "伱{起動/演練/亮出賭鬥牌}旹可發動,此技能改爲必發,若此牌伱上一起動(或演練牌或賭鬥)牌之點數絕對差(无牌視爲0點){極叶/較叶/較不叶/極不叶}伱{抽2/抽1/選擇褈鑄1手牌/全體腳色各自弃1手牌}<br/>(點數差屬于{0,12/5,7/3,4,8,9/1,2,6,10,11})",  --
--,此技能1轉失效
  ["#hzvoaqcaok-recast"] = "龢樂：  褈鑄1手牌 或得1空",
  ["#hzvoaqcaok-discard"] = "龢樂： %src發出極不龢叶音 弃1",

  ["@hzvoaqcaok"] = "龢樂",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


hzvoaqcaok:addAcquireEffect(function (self, player,is_start)
      if not is_start then
        player.room.logic:getEventsByRule(GameEvent.UseCard, 1, function (e)  --使用過且在弃牌堆
        local use=e.data
        if use.from==player then
          player.room:setPlayerMark(player,"@hzvoaqcaok",use.card.number) 
          return true
        end
      end,nil, Player.HistoryGame)
    end
end)

hzvoaqcaok:addLoseEffect (function (self, player)
  player.room:removeTableMark(player, "contracted_skills", hzvoaqcaok.name)
  player.room:setPlayerMark(player,"@hzvoaqcaok",nil) 
end)


local spec ={
  can_trigger = function(self, event, target, player, data)
    return data.from==player and player:hasSkill(hzvoaqcaok.name)
  end,
  on_cost = function(self, event, target, player, data)
    if table.contains(player:getTableMark("contracted_skills"), hzvoaqcaok.name) or
      player.room:askToSkillInvoke(player, {
      skill_name = hzvoaqcaok.name,
      -- prompt = "#hzvoaqcaokz-invoke",
    }) 
    then
    event:setCostData(self,{number=data.card.number})

    end
  end,

  on_use = function(self, event, target, player, data)
    player.room:addTableMarkIfNeed(player, "contracted_skills", hzvoaqcaok.name)

    local n=math.abs(player:getMark("@hzvoaqcaok") - event:getCostData(self).number)%13

    if table.contains({0,12},n) then
      player:drawCards(2,hzvoaqcaok.name)
    elseif table.contains({7,5},n) then
      player:drawCards(1,hzvoaqcaok.name)

    elseif table.contains({4,9,3,8},n) then
      local room=player.room
      local cards = room:askToCards(player, {
        min_num = 0,
        max_num = 1,
        skill_name = hzvoaqcaok.name,
        -- pattern = ".",
        include_equip=false,
        prompt = "#hzvoaqcaok-recast",
        cancelable = false,
      })
      if #cards>0 then
        room:recastCard(cards, player, hzvoaqcaok.name)
      -- else
      --   room:moveCards({
      --     ids = S.getKhouc( 1),
      --     to = player,
      --     toArea = Card.PlayerHand,
      --     moveReason = fk.ReasonJustMove,
      --     proposer = player,
      --     skill_name = hzvoaqcaok.name,
      --     moveVisible = true,
      --   })
      end
    elseif table.contains({10,2,6,11,1},n) then
      local room=player.room

    local result = room:askToJointCards(player, {
      players = room.alive_players,
      min_num = 1,
      max_num = 1,
      cancelable = false,
      skill_name = hzvoaqcaok.name,
      prompt = "#hzvoaqcaok-discard",
      will_throw = true,
    })
    local moves = {}
    for _, p in ipairs({ player, to }) do
      local cards = result[p] or {}
      if #cards > 0 then
        table.insert(moves, {
          ids = cards,
          from = p,
          toArea = Card.DiscardPile,
          moveReason = fk.ReasonDiscard,
          proposer = p,
          skillName = hzvoaqcaok.name,
        })
      end
    end
    room:moveCards(table.unpack(moves))

      -- for _, p in ipairs(room.alive_players) do
      --     room:askToDiscard(p, {
      --       min_num = 1,
      --       max_num = 1,
      --       include_equip = false,
      --       skill_name = hzvoaqcaok.name,
      --       prompt = "#hzvoaqcaok-discard:"..player.id,
      --       cancelable = false,
      --       skip = false,
      --     })
      -- end
      -- player.room:invalidateSkill(player, kximqthoac.name,"-turn")
    end
  end,
  late_refresh=true,
  can_refresh = function(self, event, target, player, data)
    return data.from==player and player:hasSkill(hzvoaqcaok.name,true)
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@hzvoaqcaok",event:getCostData(self).number)
  end,
}

hzvoaqcaok:addEffect(fk.CardUsing, spec)
hzvoaqcaok:addEffect(fk.CardResponding, spec)

hzvoaqcaok:addEffect(fk.PindianCardsDisplaying, {
  can_trigger = function(self, event, target, player, data)
    if  player:hasSkill(hzvoaqcaok.name)
    and (data.from==player and data.fromCard or (data.results[player] and data.results[player].toCard)
  ) then
      event:setCostData(self,{number = data.results[player].toCard.number})

    end
  end,
  on_use = spec.on_use,
  late_refresh=true,
  can_refresh = function(self, event, target, player, data)
    return  player:hasSkill(hzvoaqcaok.name)
    and (data.from==player and data.fromCard or (data.results[player] and data.results[player].toCard)
  )
   and player:hasSkill(hzvoaqcaok.name,true)
  end,
  on_refresh = spec.on_refresh,
})

return hzvoaqcaok

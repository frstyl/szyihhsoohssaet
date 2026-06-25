local hzfenszzyit = fk.CreateSkill({
  name = "hzfenszzyit",
})

Fk:loadTranslationTable{
  ["hzfenszzyit"] = "幻術",
  [":hzfenszzyit"] = "當伱受到傷害後,伱可發動x(傷害值)次,選擇1角色發動,其判定2次,若判定牌色:黑黑,伱与其2雷傷;紅紅,伱与其2火傷", --;黑紅,伱与其各抽1

  ["#hzfenszzyit-choose"] = "幻術：你可以令一名角色进行判定",

  ["$hzfenszzyit1"] = "五雷天心緣何不驪",  --无色
  -- ["$hzfenszzyit2"] = "飛沙一起,眞假莫辨",
}
hzfenszzyit:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzfenszzyit.name) 
  end,
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      skill_name = hzfenszzyit.name,
      prompt = "#hzfenszzyit-choose",
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
    if to.dead then return end
    local judge = {
      who = to,
      reason = hzfenszzyit.name,
      pattern = ".|.|spade,club,diamond,heart",  --除无色
    }
    room:judge(judge)
    if to.dead then return end
    local judge2 ={
      who = to,
      reason = hzfenszzyit.name,
      pattern = ".|.|spade,club,diamond,heart",  --除无色
    }
    room:judge(judge2)
    if judge.card.color==Card.Black then
      if judge2.card.color==Card.Black  then
        if to.dead then return end
        room:damage{
        from = player,
        to = to,
        damage = 2,
        damageType = fk.ThunderDamage,
        skillName = hzfenszzyit.name,
      }
      return
      -- elseif judge2.card.color==Card.Red then 
      --   if not player.dead then 
      --     player:drawCards(1,hzfenszzyit.name)
      --   end
      --   if not to.dead then 
      --     to:drawCards(1,hzfenszzyit.name)
      --   end
      --   return
      end
    end
    if judge.card.color==Card.Red then
      if judge2.card.color==Card.Red then
        if to.dead then return end
        room:damage{
        from = player,
        to = to,
        damage = 2,
        damageType = fk.FireDamage,
        skillName = hzfenszzyit.name,
      }
      return
      -- elseif judge2.card.color==Card.Black then 
      --   if not player.dead then 
      --     player:drawCards(1,hzfenszzyit.name)
      --   end
      --   if not to.dead then 
      --     to:drawCards(1,hzfenszzyit.name)
      --   end
      --   return
      end
    end

  end,
})


return hzfenszzyit

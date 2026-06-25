local jyenqmjet = fk.CreateSkill {
  name = "jyenqmjet",
}

Fk:loadTranslationTable{
["jyenqmjet"] = "緣滅",--1/4花田
[":jyenqmjet"] = "當伱回復體力後,至多回復值次,伱可指定1其他角色發動,伱与其各判定,若同色,伱予其1傷,不同色,伱与其各抽1",
["#jyenqmjet-choose"]="緣滅 選擇1角色判定",
}

jyenqmjet:addEffect(fk.HpRecover, {
  anim_type = "offensive",
  -- trigger_times = function(self, event, target, player, data)
  --   return data.num
  -- end,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jyenqmjet.name)
  end,
  trigger_times = function(self, event, target, player, data)
    return data.num
  end,
  on_cost = function(self, event, target, player, data)
    local room=  player.room
    local to = room:askToChoosePlayers(player,{
      targets = room:getOtherPlayers(player, false),
      min_num=1,
      max_num=1,
      prompt = "#jyenqmjet-choose",
      skill_name = jyenqmjet.name,
      cancelable = true,
    })
    if #to>0 then 
      event:setCostData(self,{tos=to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room= player.room
    local to = event:getCostData(self).tos[1]
    local judge = {
      who = player,
      reason = jyenqmjet.name,
      pattern = ".|.|.",  --除无色
    }
    room:judge(judge)
    if to.dead then return end
    local judge2 ={
      who = to,
      reason = jyenqmjet.name,
      pattern = ".|.|.",  --除无色
    }
    room:judge(judge2)

    if judge.card:compareColorWith(judge2.card) then
      if to.dead then return end
      room:damage{
        from = player,
        to = to,
        damage = 1,
        -- damageType = fk.NormalDamage,
        skillName = jyenqmjet.name,
      }
    else
      player:drawCards(1,jyenqmjet.name)
      if to.dead then return end
      to:drawCards(1,jyenqmjet.name)
    end
  end,
})


return jyenqmjet

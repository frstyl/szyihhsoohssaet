local kyinqszjer = fk.CreateSkill {
  name = "kyinqszjer",
}

Fk:loadTranslationTable{
["kyinqszjer"] = "均勢",
[":kyinqszjer"] = "伱指定/成爲起動目幖後,伱可發動,伱与對方同旹選0至多手牌打出,若數量相同,伱抽1,",  --謀奕猜拳眞行

["#kyinqszjer-invoke"] = "均勢 是否對%src 發動",
-- ["#kyinqszjerResult"] = "均勢: %from 于 %to 手牌數 %arg",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec = {
  -- anim_type = "offensive",
  -- can_trigger = function(self, event, target, player, data)
    -- return data.from ==player and player:hasSkill(kyinqszjer.name)
    -- -- and data.card.trueName == "ssaet" 
  -- end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = kyinqszjer.name,
      prompt = "#kyinqszjer-invoke:"..data.to.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
          S.playCard( player:getCardIds("h"), kyinqszjer.name,player)

    local room=player.room
    local to =data.to
    local ids=table.filter(player:getCardIds("h"), function(id)
				return not player:prohibitResponse(Fk:getCardById(id))
			end)
    table.insertTableIfNeed(ids, table.filter(to:getCardIds("h"), function(id)
				return not to:prohibitResponse(Fk:getCardById(id))
			end))

    local result = room:askToJointCards(player, {
      players = { player, to },
      min_num = 0,
      max_num = 999,
      cancelable = false,
      skill_name = kyinqszjer.name,
      prompt = "#kyinqszjer-discard",
      will_throw = false,
			pattern=tostring(Exppattern{ id = ids }),
      include_equip=false,
    })

    -- local moves = result[player]
    -- table.insertTableIfNeed(moves, result[to])
    -- if #moves>0 then
    --   S.playCard( moves, kyinqszjer.name,nil)
    -- end
    S.playCard( result[player], kyinqszjer.name,player)
    S.playCard( result[to], kyinqszjer.name,to)
    if not player.dead and #result[player]==#result[to] then
      player:drawCards(1,kyinqszjer.name)
    end
  end,
}
kyinqszjer:addEffect(fk.TargetConfirmed, {
  anim_type = "defensive", 
  can_trigger = function(self, event, target, player, data)
    return data.from ==player and player:hasSkill(kyinqszjer.name)
  end,
   on_cost=spec.on_cost,
  on_use=spec.on_use,
})
  
kyinqszjer:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.to ==player and player:hasSkill(kyinqszjer.name)  and self:isEffectable(player)
  end,
    on_cost=spec.on_cost,
  on_use=spec.on_use,
})

return kyinqszjer

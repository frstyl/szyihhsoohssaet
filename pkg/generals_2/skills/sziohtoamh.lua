local sziohtoamh = fk.CreateSkill {
  name = "sziohtoamh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["sziohtoamh"] = "鼠膽",
  [":sziohtoamh"] = "鎖定.伱回合外受傷後,必發.其它角色所用牌對伱无效,防止伱所受傷害,直至伱下轉始",

  ["@@sziohtoamh"] = "鼠膽",
  -- ["#PreventDamageBySkill"] = "由于 %arg 效果，%from 所受傷害被防止",
  -- ["#nullifyCardBySkill"] = "由于 %arg 的效果，%from 所受 %arg2 效果被无效",

  ["$sziohtoamh1"] = "逃",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sziohtoamh:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(sziohtoamh.name) and player.room.current ~= player
  end,
  on_use = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@@sziohtoamh", 1)
  end,
})


sziohtoamh:addEffect(fk.DamageInflicted, {
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:getMark("@@sziohtoamh") > 0  and not data.prevented
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:sendLog{ type = "#PreventDamageBySkill", from = player.id, arg = sziohtoamh.name }
    data:preventDamage()
  end,
})

sziohtoamh:addEffect(fk.PreCardEffect, {
  anim_type = "defensive",
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:getMark("@@sziohtoamh")  > 0  and not data.nullified --and not data.isCancellOut
      and data.from~=player
  end,
  on_trigger = function (self, event, target, player, data)
    -- player.room:sendLog{ type = "#nullifyCardBySkill", from = player.id, arg = sziohtoamh.name ,arg2= data.card:toLogString()}
    -- data.nullified = true
    S.effectNullify(data,player,sziohtoamh.name)
  end,
})

sziohtoamh:addEffect(fk.TurnStart, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:getMark("@@sziohtoamh")>0
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(player, "@@sziohtoamh", 0)
  end,
})
return sziohtoamh
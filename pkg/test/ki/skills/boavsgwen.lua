local boavsgwen = fk.CreateSkill {
  name = "boavsgwen",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["boavsgwen"] = "虣拳",
  [":boavsgwen"] = "應動｡伱｢殺｣對目幖致傷旹,伱可發動,傷害值+(體力數-1-floor(體力上限*(3-x)/3)),執行第x項,➀其不可起動｢殺｣至其轉終➁防止其回復體力至其轉終➂伱抽3,越過當轉撤段",

  -- ["#changeDamageBySkill"] = "由于 %arg 的效果，對 %from 傷害 + %arg2",
  ["@@prohibit_ssaet"] = "禁殺",

  ["$boavsgwen1"] = "賊子伱往若里去",
  ["$boavsgwen2"] = "",
}

boavsgwen:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return data.from==player  and player:hasSkill(boavsgwen.name)
    and data.event_data
    and data.event_data.card.trueName=="ssaet"
    and data.to==data.event_data.to
  end,
  on_use= function(self, event, target, player, data)
    if data.to.hp<=0 then return end
    local n 
    local m=3
    local j 
    for i=1, m,1 do
      if data.to.hp<=data.to.maxHp*i//m then n=data.to.hp-1 -data.to.maxHp*(i-1)//m 
        j=i
      break
      end
    end
    if n>0 then 
    S.changeDamage({damageData=data,num=n,skillName=boavsgwen.name})
    end
    if j==3 then
      if not table.contains(data.to:getTableMark("boavsgwen"), 1)  then
      player.room:setPlayerMark(data.to,"@@prohibit_ssaet",1)
      player.room:addTableMark(data.to,"boavsgwen", 1)
      end
      -- player.room:addPlayerMark(data.to,"@@skill_invalid",1)
      -- player.room:addSkill("skill_invalid")
      -- player.room:addTableMark(data.to,"boavsgwen", 1)
    elseif j==2 then
      if not table.contains(data.to:getTableMark("boavsgwen"), 2)  then
      player.room:addPlayerMark(data.to,"@@prohibit_recover",1)
      player.room:addSkill("prohibit_recover")
      player.room:addTableMark(data.to,"boavsgwen", 2)
      end
    else
      if not player.dead then player:drawCards(3,boavsgwen.name)
      player:skip(Player.Discard)
      end
    end
  end,
})
boavsgwen:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player and player:getMark("@@prohibit_ssaet")~=0  and card and card.trueName=="ssaet" then return true end
  end,
})

boavsgwen:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    return target==player
    and player:getMark("boavsgwen")~=0
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    -- local n,m =0,0
    for _, i in ipairs(player:getMark("boavsgwen")) do
      if i==1 then
        room:setPlayerMark(player,"@@prohibit_ssaet", 0)
      else
        room:removePlayerMark(player,"@@prohibit_recover", 1)
      end
    end
    room:setPlayerMark(player,"boavsgwen", nil)
    -- room:removePlayerMark(player,"@@skill_invalid", 1)
  end,
})


return boavsgwen

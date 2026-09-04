
local jjenhmiu = fk.CreateSkill{
  name = "jjenhmiu",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["jjenhmiu"] = "演謀",
  [":jjenhmiu"] = "伱起動卽旹計謀牌A旹可發動,伱起動A,繼承元信息,瀕死防止死亡,結算終旹受傷腳色弃1,不可嵌套｡",
--加彊?

  ["#jjenhmiu_delay"] = "演謀 後續效果",  --%from 

  ["$jjenhmiu1"] = "洞察機先 无有不破",
  ["$jjenhmiu2"] = "意志被摧毀了无",
}

jjenhmiu:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and  player:hasSkill(jjenhmiu.name) 
    and S.isInstantTrick(data.card.trueName)
    and not (data.extra_data and data.extra_data.jjenhmiu)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local use ={
      from = player,
      tos =table.simpleClone(data.tos) ,  --迻除
      card = data.card,
      responseToEvent=data.responseToEvent,
      nullifiedTargets=data.nullifiedTargets,
      extraUse=data.extraUse,
      disresponsiveList==data.disresponsiveList,
      unoffsetableList==data.disresponsiveList,
      additionalDamage =data.additionalDamage ,
      extra_data= data.extra_data or {},
      -- cardsResponded
      cardsResponded=data.cardsResponded,
      additionalEffect=data.cardsResponded,
    }
    --周宣
    local hp_record = {}
    for _, p in ipairs(player.room.alive_players) do
      hp_record[p.id]=p.hp
    end
    use.extra_data.jjenhmiu = player.id
    use.extra_data.jjenhmiu_recored =hp_record
    room:setBanner("jjenhmiu", (room:getBanner("jjenhmiu") or 0)+1)
    player.room:useCard(use)
    local n =room:getBanner("jjenhmiu")
    room:setBanner("jjenhmiu", n>1 and n-1 or nil)
  end,

})

-- jjenhmiu:addEffect(fk.PreDamage, {
--   -- is_delay_effect=true,
--   -- anim_type = "offensive",
--   can_refresh= function(self, event, target, player, data)
--     return player.seat==1
--     and 	data.event_data and data.event_data.extra_data and data.event_data.extra_data.jjenhmiu
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local n = data.damage
--     data.isVirtualDMG=true
--     --  data:preventDamage()  --无旹機
--     --data.prevented=true  --无旹機
--     -- player.room:loseHp(data.to, n, jjenhmiu.name,player)
--   end,
-- })

-- jjenhmiu:addEffect(fk.BeforeHpChanged, {
--   -- is_delay_effect=true,
--   -- anim_type = "offensive",
--   can_refresh= function(self, event, target, player, data)
--     if not player.seat==1 or  data.prevented==true then return end
--     local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
--     while true do
--       if not use_event then return end
--       local d=use_event.data
--       if d.card and d.card.skillName == data.skillName then  --第1張同名
--         return d.extra_data and d.extra_data.jjenhmiu
--       end
    
--       use_event = use_event:findParent(GameEvent.UseCard)
--     end
--   end,
--   on_refresh = function(self, event, target, player, data)
--     data.prevented=true
--   end,
-- })
jjenhmiu:addEffect(fk.AskForPeachesDone, {
  can_refresh= function(self, event, target, player, data)
    return
     player.room:getBanner("jjenhmiu") 
     and player.room:getBanner("jjenhmiu")>0
    and player.seat==1  
  end,
  on_refresh= function(self, event, target, player, data)
    data.ignoreDeath=true
  end,
})

jjenhmiu:addEffect(fk.CardUseFinished, {
  -- is_delay_effect=true,
  -- anim_type = "offensive",
  can_trigger= function(self, event, target, player, data)
        return player.seat==1
    and 	data.extra_data and data.extra_data.jjenhmiu
    -- and data.damageDealt
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    room:sendLogEvent("#jjenhmiu_delay", {
    -- name = jjenhmiu.name,
    -- from= data.extra_data.jjenhmiu,
  })
    local hp_record=data.extra_data.jjenhmiu_recored
    for _, p in ipairs(room:getAlivePlayers()) do
      local n =hp_record[p.id] - p.hp
      if n ~=0 then
        room:changeHp(p, n, nil, jjenhmiu.name)
        if n>0 then
          room:askToDiscard(p,{
            min_num=n,
            max_num=n,
            include_equip=false,
            pattern=".",
            skill_name = jjenhmiu.name,
            cancelable = false,
          })
        else
          p:drawCards(-n, jjenhmiu.name)
        end
      end
    end

  end,
})

return jjenhmiu

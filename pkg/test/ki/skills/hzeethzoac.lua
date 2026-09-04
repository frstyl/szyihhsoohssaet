local hzeethzoac = fk.CreateSkill {
  name = "hzeethzoac",
}

Fk:loadTranslationTable{
  ["hzeethzoac"] = "頡頏",
  [":hzeethzoac"] = "伱指定傷害牌目幖A後,伱可發動｡伱与A同旹選擇1項生效(同項不疊加):➀此｢殺｣對A致傷旹,傷害值+1,傷害結算終旹,伱令其回1➁此次起動結算期,A不可起動打出牌",

  ["addDamage"] = "傷害+1",
  ["disresponsive"] = "不可響應",
  -- ["additionalResponseTimes"] = "額外抵消次數",  --fixedResponseTimesList
  ["@@hzeethzoac"] = "封禁 起動",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

hzeethzoac:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from  == player and player:hasSkill(hzeethzoac.name) 
    -- and data.card.trueName == "ssaet" 
    and data.card.is_damage_card
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local tos = {data.to,player}
    local params = {
      players = tos,
      choices = {"addDamage","disresponsive"},
      prompt = "hzeethzoac-choose",
      skillName = hzeethzoac.name,
      send_log = true,
    }
   
    local req = room:askToJointChoice(player,params)
    -- local addDamage
    -- local disresponsive
    for _, p in ipairs(tos) do
      -- room:sendLog{  --send_log
      --   type = "#Choice",
      --   from = p.id,
      --   arg = req[p],
      --   toast = true,
      -- }
      if req[p]=="addDamage" then
        -- if not  not addDamage then
          data.currentExtraData = data.currentExtraData or {} --use
          data.currentExtraData.hzeethzoac={from=player.id, to=data.to.id}
          addDamage=true
        -- end

      else
        -- if not  not disresponsive then
          room:addPlayerMark(data.to, "@@hzeethzoac", 1)
          room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
            room:removePlayerMark(data.to, "@@hzeethzoac", 1)
          end)
        -- end
      end
    end

    -- if disresponsive then
		-- data:setResponseTimes(data:getResponseTimes(data.to) +1, data.to) end
    -- if addDamage then 
    --    data.additionalDamage = (data.additionalDamage or 0) + 1
    -- end
  end,
})

hzeethzoac:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    if player.seat~=1 then return end 
    return  data.event_data
        and data.event_data.currentExtraData
        and data.event_data.currentExtraData.hzeethzoac
  end,
  on_trigger = function(self, event, target, player, data)
    -- player.room:sendLog{ type = "#changeDamageBySkill", from = data.to.id, arg = hzeethzoac.name ,arg2=1}
    -- data:changeDamage(1)
    S.changeDamage({damageData=data,num=1,skillName=hzeethzoac.name})
  end,
})

hzeethzoac:addEffect(fk.DamageFinished, {
  can_trigger = function(self, event, target, player, data)
    return  
    not data.dead
    and
    data.event_data
        and data.event_data.currentExtraData
        and data.event_data.currentExtraData.hzeethzoac
        and data.event_data.currentExtraData.hzeethzoac.from ==player.id
  end,
  on_trigger = function(self, event, target, player, data)
    player.room:recover({
        who = player.room:getPlayerById(data.event_data.currentExtraData.hzeethzoac.to),
        num = 1,
        recoverBy = player,
        skillName = hzeethzoac.name,
      })
  end,
})

hzeethzoac:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return   player:getMark("@@hzeethzoac")~=0
  end,
  prohibit_response = function(self, player, card)
    return   player:getMark("@@hzeethzoac")~=0
  end,
})

return hzeethzoac

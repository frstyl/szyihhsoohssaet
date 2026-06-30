local dooqmxe = fk.CreateSkill{
  name = "dooqmxe",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["dooqmxe"] = "荼蘼",
  [":dooqmxe"] = "伱始段始旹,伱可選1其它有手牌角色發動:伱獲取其全部手牌;當段內伱對其致傷旹,防止之;段終,伱交予其x手牌(x爲其體力值).",
  
  ["#dooqmxe-choose"] = "荼蘼 選擇目幖",

  ["$dooqmxe1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

dooqmxe:addEffect(fk.EventPhaseStart, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:hasSkill(dooqmxe.name)  and data.phase==Player.Play
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,  --
      skill_name = dooqmxe.name,
      prompt = "#dooqmxe-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local to = event:getCostData(self).tos[1]
    player.room:moveCardTo(to:getCardIds("h"), Card.PlayerHand, player, fk.ReasonPrey, dooqmxe.name, nil, false, player)
    -- player.room:addTableMarkIfNeed(player, "dooqmxe-phase", to.id)
    player.room:setPlayerMark(player, "dooqmxe-phase", to.id)
  end,
})


dooqmxe:addEffect(fk.DamageCaused, {
  anim_type = "support",
  is_delay_effect = true,
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:getMark("dooqmxe-phase")==data.to.id
  end,
  on_trigger = function (self, event, target, player, data)
    player.room:sendLog{ type = "#PreventDamageBySkill", from = data.to.id, arg = dooqmxe.name }
    S.preventDamage({damageData=data,skillName=dooqmxe.name})  --skill??
  end,
})

dooqmxe:addEffect(fk.EventPhaseEnd, {
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return target == player and player.phase == Player.Play and player:getMark("dooqmxe-phase") ~= 0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to =player.room:getPlayerById(player:getMark("dooqmxe-phase"))
        local cards = player:getCardIds("h")
        local n = to.hp
        if n < #cards then
          cards = room:askToCards(player, {
            min_num = n,
            max_num = n,
            include_equip = false,
            skill_name = dooqmxe.name,
            cancelable = false,
            prompt = "#dooqmxe-give::"..to.id..":"..n,
          })
        end
        room:moveCardTo(cards, Card.PlayerHand, to, fk.ReasonGive, dooqmxe.name, nil, false, player)

  end,
})


return dooqmxe

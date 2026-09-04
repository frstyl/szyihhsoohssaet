local cioshsvah = fk.CreateSkill {
  name = "cioshsvah",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["cioshsvah"] = "馭火",  --馭火
[":cioshsvah"] = "伱受到火傷旹,伱可選1項➀預打出1牌,防止此傷➁將此傷轉迻于伱上家或下家(有向)",
["#cioshsvah-fire"]="馭火 打出1牌防止此傷  或選擇目幖轉迻傷害",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"

cioshsvah:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.to==player and player:hasSkill(cioshsvah.name) 
    and data.damageType == fk.FireDamage
    -- and not player:isNude() 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets ={}
    if data.extra_data   and data.extra_data.direction then
      direction = data.extra_data.direction

      targets ={S.getNextOne(data.to,direction)}
    else

      local n =S.getDirectFromAToB(data.from, player)
      if n==0 or not data.from then
        targets=S.getNeighbor(player)
      else
        targets={S.getNextOne(player, n)}
      end
    end
      local tos, cards =  room:askToChooseCardsAndPlayers(player, {
      min_card_num = 0,
      max_card_num = 1,
      min_num = 0,
      max_num = 1,
      include_equip=true,
      targets = targets,
      pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
      return not player:prohibitResponse(Fk:getCardById(id))
    end)}),
      prompt = "#cioshsvah-fire",
      skill_name = cioshsvah.name,
      will_throw = true,
      cancelable = true,
    })
    if  #tos==0 and #cards==0 then
      -- tos={targets[1]}
      return --不鎖
    end
      event:setCostData(self, {tos=tos,cards=cards})
      return true
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if  #event:getCostData(self).cards>0 then
      S.playCard(event:getCostData(self).cards,cioshsvah.name,player)
      S.preventDamage({damageData=data,skillName=cioshsvah.name})
      return
    end

    local to=event:getCostData(self).tos[1]
    if to.dead then return end

    if not (data.extra_data and data.extra_data.direction )then
      local direction = to==S.getNextOne(data.to) and 1 or -1
      data.extra_data = data.extra_data or {}
      data.extra_data.direction=direction
    end

    data.to=to
    target = to
    -- room.logic:trigger(fk.DamageInflicted, to, data)
    -- data.prevented=true
    return true

  end,
})

-- cioshsvah:addEffect(fk.DamageInflicted, {
--   anim_type = "defensive",
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:hasSkill(cioshsvah.name) 
--     and data.damageType == fk.FireDamage
--     and not player:isNude() 
--   end,
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local tos, cards =  room:askToChooseCardsAndPlayers(player, {
--       min_card_num = 1,
--       max_card_num = 1,
--       min_num = 1,
--       max_num = 1,
--       targets = {S.getNextOne(player.id,-1), S.getNextOne(player.id,1)},
--       prompt = "#cioshsvah-fire",
--       skill_name = cioshsvah.name,
--       will_throw = true,
--       cancelable = true,
--     })
--     if #cards > 0 and #tos>0 then
--       event:setCostData(self, {cards = cards,tos=tos})
--     end
--       return true
--     end,
--   on_use = function(self, event, target, player, data)
--     if not event:getCostData(self) then
 --   S.preventDamage({damageData=data,skillName=cioshsvah.name})
--       return
--     end
--     local room = player.room
--     local cards=event:getCostData(self).cards
--     if not table.contains(player:getCardIds("h"), cards[1]) then
--       --     S.preventDamage({damageData=data,skillName=cioshsvah.name})  --御火失敗?
--       return
--     end
--     room:throwCard(cards, cioshsvah.name, player, player)
--     local to=event:getCostData(self).tos[1]
--     if to.dead then return end
--     data.to=to
--     target = to
--     room.logic:trigger(fk.DamageInflicted, to, data)
--     -- data.prevented=true
--     return true

--   end,
-- })


return cioshsvah

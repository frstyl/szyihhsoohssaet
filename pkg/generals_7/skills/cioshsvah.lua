local cioshsvah = fk.CreateSkill {
  name = "cioshsvah",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
["cioshsvah"] = "馭火",  --馭火
[":cioshsvah"] = "當伱受到火傷旹,伱可選1項➀預打出1牌,防止此傷➁將此傷轉迻于伱上家或下家(攷慮向則)",
["#cioshsvah-fire"]="馭火 弃1牌  轉迻  所受傷害",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"

cioshsvah:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(cioshsvah.name) 
    and data.damageType == fk.FireDamage
    -- and not player:isNude() 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets ={}
    if data.extra_data and data.extra_data.hqjin_szjer_ljis_doavs and data.extra_data.hqjin_szjer_ljis_doavs.direction then
      direction = data.extra_data.hqjin_szjer_ljis_doavs.direction

      targets ={S.getNextOne(data.to,direction)}
    else
      targets={S.getNextOne(data.to,1), S.getNextOne(data.to,-1)}
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
      tos={targets[1]}
    end
      event:setCostData(self, {tos=tos,cards=cards})
      return true
    end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if  #event:getCostData(self).cards>0 then
      player.room:responseCard({
				card=Fk:getCardById(event:getCostData(self).cards[1]),
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    S.preventDamage({damageData=data,skillName=cioshsvah.name})
      return
    end

    local to=event:getCostData(self).tos[1]
    if to.dead then return end

    if not (data.extra_data and data.extra_data.hqjin_szjer_ljis_doavs and data.extra_data.hqjin_szjer_ljis_doavs.direction )then
      local direction = to==S.getNextOne(data.to) and 1 or -1
      data.extra_data = data.extra_data or {}
      data.extra_data.hqjin_szjer_ljis_doavs = data.extra_data.hqjin_szjer_ljis_doavs or {}
      data.extra_data.hqjin_szjer_ljis_doavs.direction=direction
    end

    data.to=to
    target = to
    room.logic:trigger(fk.DamageInflicted, to, data)
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

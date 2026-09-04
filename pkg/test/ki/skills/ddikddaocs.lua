local ddikddaocs = fk.CreateSkill {
  name = "ddikddaocs",
}

Fk:loadTranslationTable{
["ddikddaocs"] = "直撞",
[":ddikddaocs"] = "應動｡當伱所起動｢殺｣致傷後,伱可預弃受傷脚色1牌發動.若此牌与｢殺｣同色,伱可予目幖脚色上家或下家相同傷害(連續發動需同嚮)",

["#ddikddaocs-invoke"] = "直撞 弃 %src 牌, 若爲 %arg 殺生效",
["#ddikddaocs-choose"] = "直撞 選擇目幖 予其相同傷害",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


ddikddaocs:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(ddikddaocs.name) 
      and data.from == player 
      and data.card.trueName == "ssaet" 
      and not data.to.dead  
      and not data.to:isNude() 
    then
      return true 
    end
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    -- if not 
    -- room:askToSkillInvoke(player,{skillName=ddikddaocs.name,prompt="#ddikddaocs-invoke:"..data.to.id..":"..data.card:getSuitString()})
    -- then return end
    local cards = room:askToChooseCards(player, {
       target = data.to,
        min = 0,
        max = 1,
        flag = "he",
        skill_name = ddikddaocs.name,
       })
    if #cards > 0 then
      event:setCostData(self, { cards = cards,tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local id =event:getCostData(self).cards[1]
    local check=not player:prohibitDiscard(id) and Fk:getCardById(event:getCostData(self).cards[1]):compareColorWith(data.card)--同色?
    player.room:throwCard({id}, ddikddaocs.name, data.to, player) --
    if not check or player.dead then return end
    local tos ={}
    if data and  data.extra_data and data.extra_data.direction then 
      tos  = S.getNextOne(data.to,data.extra_data.direction)
    else
      table.insert(tos,S.getNextOne(data.to,1))
      table.insertIfNeed(tos,S.getNextOne(data.to,-1))
    end
    local to = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = tos,
      skill_name = ddikddaocs.name,
      prompt = "#ddikddaocs-choose",
      cancelable = true,
    })
    if to[1] then
	local extra_data=data.extra_data or {}
    if extra_data.direction==nil then
    local direction= to[1]==S.getNextOne(data.to,1) and 1 or -1
	extra_data.direction=direction
    end
	extra_data.ddikddaocs=player.id
      player.room:damage({
        to = to[1],
        from=from,
        damage = data.damage,
        damageType = data.damageType,
        skillName = data.skillName,  --止有一个
        chain = data.chain,
        card = data.card,
        event_data=data.event_data,
		extra_data=extra_data,
      })
    end
  end,
})


return ddikddaocs

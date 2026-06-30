local boavsnoos = fk.CreateSkill {
  name = "boavsnoos",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["boavsnoos"] = "虣怒",
  [":boavsnoos"] = "伱使用殺旹可發動:伱流失1體力,此牌結算期閒,此牌致傷旹傷害值加x,x爲伱已損體力(變量)",
  ["#boavsnoos"] = "虣怒 失去體力加傷",


  ["$boavsnoos1"] = "紅頭賊將竟敢如此无禮",
  ["$boavsnoos2"] = "速起軍馬拿了昰廝",
}

boavsnoos:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  prompt = "#boavsnoos",
	can_trigger = function(self, event, target, player, data)
		return target==player and data.card.trueName=="ssaet" and player:hasSkill(boavsnoos.name)
	end,
	on_use = function(self, event, target, player, data)
    player.room:loseHp(player, 1, boavsnoos.name,player)
    -- data.card.extra_data =data.card.extra_data or {}
    player.room:addTableMark(data.card, "boavsnoos-phase", player.id)

    player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
        table.removeOne(data.card:getTableMark("boavsnoos-phase"),player.id)  --  --插入中使用此牌會增傷  --使用者傷源改變 不改技能源
      end)
  end,
})

boavsnoos:addEffect(fk.DamageCaused, {
  can_refresh = function(self, event, target, player, data)
    return data.to and data.card   and table.contains(data.card:getTableMark("boavsnoos-phase"),player.id)
  end,
  on_refresh = function(self, event, target, player, data)
    -- player.room:sendLog{ type = "#changeDamageBySkill", from = data.to.id, arg = boavsnoos.name ,arg2=player:getLostHp()}
    -- data:changeDamage(player:getLostHp())  --待改 增傷統一加上限
    S.changeDamage({damageData=data, num=player:getLostHp(),skillName=boavsnoos.name})
  end,
})


return boavsnoos

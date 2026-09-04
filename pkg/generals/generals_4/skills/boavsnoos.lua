local boavsnoos = fk.CreateSkill {
  name = "boavsnoos",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["boavsnoos"] = "虣怒",
  [":boavsnoos"] = "伱起動殺旹可發動:伱流失1,此牌結算期閒,此牌致傷旹傷害值加x,x爲伱已損體力數+此技能發動次數",
  ["#boavsnoos"] = "虣怒 流失體力加傷",


  ["$boavsnoos1"] = "紅頭賊將竟敢如此无禮",
  ["$boavsnoos2"] = "速起軍馬拿了昰廝",
}

boavsnoos:addEffect(fk.CardUsing, {
  anim_type = "offensive",
	can_trigger = function(self, event, target, player, data)
		return target==player and data.card.trueName=="ssaet" and player:hasSkill(boavsnoos.name)
	end,
	on_use = function(self, event, target, player, data)
    player.room:loseHp(player, 1, boavsnoos.name,player)
    data.extra_data=data.extra_data or {}
    data.extra_data.boavsnoos=player.id

    -- player.room:addTableMark(data.card, "boavsnoos-phase", player.id)
    -- player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
    --     table.removeOne(data.card:getTableMark("boavsnoos-phase"),player.id)  --  --插入中起動此牌會增傷  --起動者傷源改變 不改技能源
    --   end)
  end,
})

boavsnoos:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return player.seat==1
    and data.event_data
    and data.event_data.extra_data
    and data.event_data.extra_data.boavsnoos
  end,
  on_trigger = function(self, event, target, player, data)
    local p =player.room:getPlayerById(data.event_data.extra_data.boavsnoos)

    S.changeDamage({damageData=data,
     num=p:usedSkillTimes(boavsnoos.name, Player.HistoryGame)+p:getLostHp(),
    skillName=boavsnoos.name})
  end,
})


return boavsnoos

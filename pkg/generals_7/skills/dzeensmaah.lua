local dzeensmaah = fk.CreateSkill {
  name = "dzeensmaah",
}

Fk:loadTranslationTable{
  ["dzeensmaah"] = "荐馬",
  [":dzeensmaah"] = "當一角色進入瀕死,伱可將1坐騎牌置入其裝僃區發動,令其回1(无法將角色自己坐騎置入其坐騎欄)",

  -- ["#dzeensmaah"] = "荐馬 隨機獲得1此花色坐騎牌",
  ["#dzeensmaah-choose"] = "荐馬 %src 進入瀕死 可選擇1坐騎牌置入其裝僃區發動,令其回1",

  -- ["$dzeensmaah1"] = "相得好馬,贈与良將",
}


dzeensmaah:addEffect(fk.EnterDying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(dzeensmaah.name) 
  end,

  on_cost = function(self, event, target, player, data)

      local room = player.room
      local include_equip = target~=player
      local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = include_equip,
        prompt = "#dzeensmaah-choose:"..target.id,
        skill_name = dzeensmaah.name,
        cancelable = true,
        pattern= ".|.|.|.|.|defensive_ride,offensive_ride",
      })
    if #cards>0 then
        event:setCostData(self, { cards=cards })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:moveCardIntoEquip(target, event:getCostData(self).cards, dzeensmaah.name, true, player)
    room:recover({
      who = target,
      num = 1,
      recoverBy = player,
      skillName = dzeensmaah.name,
    })

end,
})

return dzeensmaah

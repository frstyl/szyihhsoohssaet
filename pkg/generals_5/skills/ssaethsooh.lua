local ssaethsooh = fk.CreateSkill{
  name = "ssaethsooh",
  -- tags={Skill.Limited},
}

Fk:loadTranslationTable{
  ["ssaethsooh"] = "殺虎",
  [":ssaethsooh"] = "輪限1.一角色使用傷害錦囊旹,若目幖數大于1,伱可選1至4角色發動.此牌對其无效,若牌名爲猛虎下山,褈置此技能次數",  --

  ["#ssaethsooh-choose"] = "殺虎：選擇目幖,令此 %arg 對其无效",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

ssaethsooh:addEffect(fk.CardUsing, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ssaethsooh.name) 
     and 
      S.getCardTypeByName(data.card.trueName)==2 and data.card.is_damage_card and #data.tos > 1
      and player:usedSkillTimes(ssaethsooh.name, Player.HistoryRound) == 0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local tos = room:askToChoosePlayers(player, {
      targets = player.room.alive_players,
      min_num = 1,
      max_num = 4,
      prompt = "#ssaethsooh-choose:::"..data.card:toLogString(),
      skill_name = ssaethsooh.name,
      cancelable = true,
    })
    if #tos > 0 then
      room:sortByAction(tos)
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- data.nullifiedTargets = data.nullifiedTargets or {}
    -- table.insertTable(data.nullifiedTargets, event:getCostData(self).tos)
    -- data.extra_data=data.extra_data or {}
    -- data.extra_data.ssaethsooh= data.extra_data.ssaethsooh or {}--不分來源
    -- table.insertTable(data.extra_data.ssaethsooh, event:getCostData(self).tos)
    S.nullifyTo(data, event:getCostData(self).tos)
    if data.card.trueName=="savage_assault" then player:setSkillUseHistory(ssaethsooh.name) end
  end,
})

return ssaethsooh

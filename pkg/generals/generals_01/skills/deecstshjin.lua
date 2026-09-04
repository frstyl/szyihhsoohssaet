local deecstshjin = fk.CreateSkill{
  name = "deecstshjin",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["deecstshjin"] = "定親",
  [":deecstshjin"] = "輪始旹,伱可指定一其它脚色發動:1輪內,伱或其受/致傷後必發,對方回1",
  ["#deecstshjin-choose"] = "定親 選擇目幖",

  ["$deecstshjin1"] = "我欲行夏禹旧事，为天下人。",

}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  -- can_trigger = function (self, event, target, player, data)
    -- return (data.from==player or data.to==player)  --data.from:getMark
	-- and  player:getMark("@deecstshjin-round")~=0 --and not player.room:getPlayerById(player:getMark("@deecstshjin-round")).dead
  -- end,
  is_delay_effect=true,
  on_use = function (self, event, target, player, data)  --on_trigger需改
    local room=player.room
    for _,id in ipairs( player:getTableMark("@deecstshjin-round")) do
      player.room:recover{
        who = player.room:getPlayerById(id),
        num = 1,
        recoverBy = player,
        skillName = deecstshjin.name,
      }
    end
  end,
}


deecstshjin:addEffect(fk.RoundStart, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return  player:hasSkill(deecstshjin.name) 
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),  --
      skill_name = deecstshjin.name,
      prompt = "#deecstshjin-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local to =event:getCostData(self).tos[1]
    local room=player.room
    room:addTableMarkIfNeed(to, "@deecstshjin-round", player.id)
    room:addTableMarkIfNeed(player, "@deecstshjin-round", to.id)
  end,
})

deecstshjin:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
   return (data.from==player)  --data.from:getMark
	and  player:getMark("@deecstshjin-round")~=0 --and not player.room:getPlayerById(player:getMark("@deecstshjin-round")).dead

  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})
deecstshjin:addEffect(fk.Damaged, {
  can_trigger = function(self, event, target, player, data)
   return (data.to==player)  --data.from:getMark
	and  player:getMark("@deecstshjin-round")~=0 --and not player.room:getPlayerById(player:getMark("@deecstshjin-round")).dead

  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})
return deecstshjin

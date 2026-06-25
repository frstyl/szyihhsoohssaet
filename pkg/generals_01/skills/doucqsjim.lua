local doucqsjim = fk.CreateSkill{
  name = "doucqsjim",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["doucqsjim"] = "同心",
  [":doucqsjim"] = "輪始旹,伱可指定一其它角色發動:當輪內,伱或其受致傷後,對方回1",
  ["#doucqsjim-choose"] = "同心 選擇目幖",

  ["$doucqsjim1"] = "我欲行夏禹旧事，为天下人。",

}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:getMark("@doucqsjim-round")~=0 --and not player.room:getPlayerById(player:getMark("@doucqsjim-round")).dead
  end,
  on_trigger = function (self, event, target, player, data)
    local room=player.room
    for _,id in ipairs( player:getTableMark("@doucqsjim-round")) do
      player.room:recover{
        who = player.room:getPlayerById(id),
        num = 1,
        recoverBy = player,
        skillName = doucqsjim.name,
      }
    end
  end,
}


doucqsjim:addEffect(fk.RoundStart, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return  player:hasSkill(doucqsjim.name) 
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayers(player),  --
      skill_name = doucqsjim.name,
      prompt = "#doucqsjim-choose",
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
    room:addTableMarkIfNeed(to, "@doucqsjim-round", player.id)
    room:addTableMarkIfNeed(player, "@doucqsjim-round", to.id)
  end,
})

doucqsjim:addEffect(fk.Damage, spec)
doucqsjim:addEffect(fk.Damaged, spec)
return doucqsjim

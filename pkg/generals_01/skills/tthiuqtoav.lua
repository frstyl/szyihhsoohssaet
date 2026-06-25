local tthiuqtoav = fk.CreateSkill{
  name = "tthiuqtoav",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tthiuqtoav"] = "抽刀",
  [":tthiuqtoav"] = "伱受傷後x次,伱爲任一角色附加狂虣",

  ["#tthiuqtoav-choose"] = "抽刀 選擇目幖",

  ["$tthiuqtoav1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

tthiuqtoav:addEffect(fk.Damaged, {  --示刃
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target==player and player:hasSkill(tthiuqtoav.name) 
  end,
  trigger_times = function (self, event, target, player, data)
    return data.damage
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,  --
      skill_name = tthiuqtoav.name,
      prompt = "#tthiuqtoav-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  "guacqboavs",player)
  end,
})



return tthiuqtoav

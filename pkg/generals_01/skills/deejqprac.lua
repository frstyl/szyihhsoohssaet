local deejqprac = fk.CreateSkill{
  name = "deejqprac",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["deejqprac"] = "提兵",
  [":deejqprac"] = "伱主段始旹,伱可發動:爲一角色附加命中",
  
  ["#deejqprac-choose"] = "提兵 選擇目幖",

  ["$deejqprac1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

deejqprac:addEffect(fk.EventPhaseStart, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:hasSkill(deejqprac.name)  and data.phase==Player.Play
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room.alive_players,  --
      skill_name = deejqprac.name,
      prompt = "#deejqprac-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  "mracsttiucs",player)
  end,
})


return deejqprac

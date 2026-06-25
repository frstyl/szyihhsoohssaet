local liuqhzfa = fk.CreateSkill{
  name = "liuqhzfa",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["liuqhzfa"] = "流華",
  [":liuqhzfa"] = "伱末段始旹,伱可發動:爲一角色附加自愈",
  
  ["#liuqhzfa-choose"] = "流華 選擇目幖",

  ["$liuqhzfa1"] = "我欲行夏禹旧事，为天下人。",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

liuqhzfa:addEffect(fk.EventPhaseStart, {
  anim_type = "support",
  can_trigger = function (self, event, target, player, data)
    return target==player and  player:hasSkill(liuqhzfa.name)  and data.phase==Player.Finish
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room.alive_players, function(p)
      return player:compareDistance(p,1,"<=")
      end),  --
      skill_name = liuqhzfa.name,
      prompt = "#liuqhzfa-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  "dzjisjuoh",player)
  end,
})


return liuqhzfa

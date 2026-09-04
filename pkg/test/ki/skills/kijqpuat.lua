local kijqpuat = fk.CreateSkill{
  name = "kijqpuat",

}

Fk:loadTranslationTable{
  ["kijqpuat"] = "機發",
  [":kijqpuat"] = "伱起動牌旹,伱可選1腳色与伱手牌數相等者發動｡伱与其1傷",
--加彊?

  ["#kijqpuat-ask"] = "機發 昰否發動",

  ["$kijqpuat1"] = "太歲頭上也敢動土",
  ["$kijqpuat2"] = "爺爺在此𠊱伱多旹了",
  ["$kijqpuat3"] = "進了昰蘆葦港伱還跑的掉",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"
-- local H = require "packages/hegemony/util"


kijqpuat:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(kijqpuat.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local n=player:getHandcardNum()
    local targets=table.filter(player.room.alive_players,function(p)
    return player:getHandcardNum()==n
    end)
    local tos = player.room:askToChoosePlayers(player, {
      targets = targets,
      min_num = 1,
      max_num = 1,
      prompt = "#kijqpuat-ask",
      skill_name = kijqpuat.name,
    })
    if #tos > 0 then
      event:setCostData(self, { tos = tos })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:damage{
        from = player,
        to = event:getCostData(self).tos[1],
        damage = 1,
        skillName = kijqpuat.name,
      }
  end,
})

return kijqpuat

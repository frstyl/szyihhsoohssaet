local hzaahszyih = fk.CreateSkill {
  name = "hzaahszyih",
}

Fk:loadTranslationTable{
  ["hzaahszyih"] = "下水",
  [":hzaahszyih"] = "游戲始前,伱可選擇1腳色,伱迻至其下家",


  ["#hzaahszyih-start"] = "下水 開一戰艦",

  ["$hzaahszyih5"] = "取來文策一察便知有无",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzaahszyih:addEffect(fk.AfterDrawInitialCards, {
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and player:hasSkill(hzaahszyih.name)  
  end,
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
          targets = player.room.players,
          min_num = 1,
          max_num = 1,
          prompt = "#hzaahszyih-start",
          skill_name = hzaahszyih.name,
          cancelable = true,
        })
      if #tos > 0 then
        event:setCostData(self, {to = tos})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room    
    room:moveSeatToNext(player,event:getCostData(self).to[1])

  end,
})


return hzaahszyih

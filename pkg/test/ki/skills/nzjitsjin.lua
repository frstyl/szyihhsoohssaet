local nzjitsjin = fk.CreateSkill {
  name = "nzjitsjin",
}

Fk:loadTranslationTable{
  ["nzjitsjin"] = "日新",
  [":nzjitsjin"] = "伱打出牌旹,伱可發動,伱抽x(x爲此技能發動次數).",


  ["#nzjitsjin-invoke"] = "日新 抽 %arg",

  ["$nzjitsjin1"] = "吾乃兀顏統軍帳下先鋒",
  ["$nzjitsjin2"] = "戰書已下開戰",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 




nzjitsjin:addEffect(fk.CardResponding, {
  can_trigger = function(self, event, target, player, data)
    return target==player and  player:hasSkill(nzjitsjin.name) 
    end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
          skill_name = nzjitsjin.name,
          prompt = "#nzjitsjin-invoke:::"..(1+player:usedSkillTimes(nzjitsjin.name, Player.HistoryGame) ),
        })
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player:usedSkillTimes(nzjitsjin.name, Player.HistoryGame), nzjitsjin.name)
  end,
})

return nzjitsjin

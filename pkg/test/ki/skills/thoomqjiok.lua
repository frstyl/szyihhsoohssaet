local thoeomqjiok = fk.CreateSkill {
  name = "thoeomqjiok",
  tags={Skill.Compulsory},
}

Fk:loadTranslationTable{
  ["thoeomqjiok"] = "貪欲",
  [":thoeomqjiok"] = "伱起動牌旹必發｡伱抽2,弃己x牌(x爲此技能當轉發動次數)",

  ["#thoeomqjiok-choose"] = "貪欲 選擇初始態",


  ["$thoeomqjiok1"] = "吾军杀声震天，则敌心必乱！",
  ["$thoeomqjiok2"] = "阵前亢歌，以振军心！",
}


thoeomqjiok:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoeomqjiok.name) 
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(2, thoeomqjiok.name)
    if  player:isKongcheng() then return end
    local n =player:usedEffectTimes(thoeomqjiok.name, Player.HistoryTurn)
    player.room:askToDiscard(player,{
          min_num = n,
          max_num = n,
          skill_name = thoeomqjiok.name,
          include_equip = true,
          cancelable = false,
        })
    -- player.room:throwCard(table.random(player:getCardIds("h")), thoeomqjiok.name, player, player)
  end,
})


return thoeomqjiok

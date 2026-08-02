local sjihcxes = fk.CreateSkill {
  name = "sjihcxes",
}

Fk:loadTranslationTable{
["sjihcxes"] = "義節",  --誼
[":sjihcxes"] = "伱進入賓死旹,可選1其它脚色發動,伱將全部牌交与該脚色,其回1,抽1｡伱死亾旹,伱可發動,伱中止結算至當轉,令1腳色執行1額外轉",

["#sjihcxes-invoke"]="義節  %src 受傷 是否流失1體力 防止此傷害",
["#sjihcxes-choose"]="義節  令 %src 執行",
["draw2"]="抽2",
["shield1"]="獲得1護甲",

["#sjihcxes-choose"]="義節  將全部牌交予1其它脚色 令其回1",

["$sjihcxes1"] = "義到盡頭方是命",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sjihcxes:addEffect(fk.EnterDying, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(sjihcxes.name)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = room.alive_players
    local tos = room:askToChoosePlayers(player, {
      skill_name = sjihcxes.name,
      min_num = 1,
      max_num = 1,
      targets = targets,
      prompt = "#sjihcxes-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    room:moveCardTo(player:getCardIds("he"), Player.Hand, to, fk.ReasonGive, sjihcxes.name, nil, false, player.id)
    if to:isWounded() and not to.dead then
      room:recover{
        who = to,
        num = 1,
        recoverBy = player,
        skillName = sjihcxes.name,
      }
    end
    to:drawCards(1,sjihcxes.name)
  end,
})

sjihcxes:addEffect(fk.Death, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(sjihcxes.name, false, true)
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
        local tos = room:askToChoosePlayers(player, {
      skill_name = sjihcxes.name,
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      prompt = "#sjihcxes-choose",
      cancelable = true,
    })
    if #tos > 0 then
      tos[1]:gainAnExtraTurn(false, sjihcxes.name, nil)
    end

    player.room.logic:breakTurn()

  end,
})

return sjihcxes

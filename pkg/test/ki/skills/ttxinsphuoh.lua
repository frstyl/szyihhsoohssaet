local ttxinsphuoh = fk.CreateSkill {
  name = "ttxinsphuoh",
  add_skills={"dzjissziuh"},
}

Fk:loadTranslationTable{
  ["ttxinsphuoh"] = "鎮抚",
  [":ttxinsphuoh"] = "伱對其它腳色A致傷旹,伱可發動,傷害值-1,伱取得A區域內1牌,1轉內不可選擇其爲起動目幖",

  ["#ttxinsphuoh-invoke"] = "鎮抚：對 %dest 發動 傷害-1,取得其區域1牌",

  ["$ttxinsphuoh1"] = "断其粮草，不战而胜！",
  ["$ttxinsphuoh2"] = "用兵之道，攻心为上！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

ttxinsphuoh:addEffect(fk.DamageInflicted, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(ttxinsphuoh.name) and data.to ~= player
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = ttxinsphuoh.name,
      prompt = "#ttxinsphuoh-invoke::"..data.to.id,
    }) then
      event:setCostData(self, {tos = {data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    S.changeDamage({damageData=data,num=-1,skillName=ttxinsphuoh.name})

    if not data.to:isAllNude() and not player.dead then
      local card = room:askToChooseCard(player, {
        target = data.to,
        flag = "hej",
        skill_name = ttxinsphuoh.name,
      })
      room:obtainCard(player, card, false, fk.ReasonPrey, player, ttxinsphuoh.name)
    end
    room:addTableMark(data.from,"dzjissziuh_to-turn",data.to.id)
  end,
})

return ttxinsphuoh

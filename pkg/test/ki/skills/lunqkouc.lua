
local lunqkouc = fk.CreateSkill{
  name = "lunqkouc",
}

Fk:loadTranslationTable{
["lunqkouc"] = "輪攻",
[":lunqkouc"] = "伱起動元殺結算後旹可發動.伱取得此殺,其不計入次數限制不占用存牌數",

["#lunqkouc-invoke"] = "輪攻 %arg",

-- ["lunqkouc-get"] = "得到此殺",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

lunqkouc:addEffect(fk.CardUseFinished, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player
    and player:hasSkill(lunqkouc.name)
    and data.card.trueName=="ssaet"
    and not data.card:isVirtual()
    and player.room:getCardArea(data.card) == Card.Processing
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, { skill_name = lunqkouc.name,prompt="lunqkouc-invoke:::"..data.card:toLogString() }) 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- room:setCardMark(data.card, "@@open-hand-turn", 1)
    room:addSkill("extraUsel")
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, lunqkouc.name,{"@@lunqkouc-inhand",1,"extraUse-inhand",1,"exclude-inhand",1})

  end,
})




return lunqkouc

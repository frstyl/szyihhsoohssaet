
local lyehkeek = fk.CreateSkill{
  name = "lyehkeek",
}

Fk:loadTranslationTable{
["lyehkeek"] = "絫擊",
[":lyehkeek"] = "伱起動元殺結算後旹可發動.伱取得此殺,其不計入次數限制不占用存牌數",

["#lyehkeek-invoke"] = "絫擊 取得 %arg",

["@@lyehkeek-inhand"] = "絫擊",
-- ["lyehkeek-get"] = "得到此殺",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

lyehkeek:addEffect(fk.CardUseFinished, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player
    and player:hasSkill(lyehkeek.name)
    and data.card.trueName=="ssaet"
    and not data.card:isVirtual()
    and player.room:getCardArea(data.card) == Card.Processing
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, { skill_name = lyehkeek.name,prompt="#lyehkeek-invoke:::"..data.card:toLogString() }) 
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- room:setCardMark(data.card, "@@open-hand-turn", 1)
    -- room:addSkill("extra_use")
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, lyehkeek.name,{"@@lyehkeek-inhand",1,"extra_use-inhand",1,"extra_retain-inhand",1})

  end,
})


return lyehkeek

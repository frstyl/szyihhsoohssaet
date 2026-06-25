local qwerkiams = fk.CreateSkill{
  name = "qwerkiams",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["qwerkiams"] = "彗劍",
  [":qwerkiams"] = "鎖定.伱使用{錦囊/裝僃}旹,必發.令伱所用下一牌{无視用視距離次數/傷害回復基數+1}",

  ["@qwerkiams"] = "彗劍",

  ["$qwerkiams1"] = "强弓挽之，以射长箭！",
  ["$qwerkiams2"] = "彗劍如月，克定江夏！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

qwerkiams:addLoseEffect(function (self, player, is_death)
  player.room:setPlayerMark(player, "@qwerkiams", 0)
end)

qwerkiams:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(qwerkiams.name) and data.extra_data and data.extra_data.qwerkiams
  end,
  on_use = function(self, event, target, player, data)
    if data.extra_data.qwerkiams =="equip" then
      data.additionalDamage = (data.additionalDamage or 0) + 1
      data.additionalRecover = (data.additionalRecover or 0) + 1
      data.extra_data.additionalDrank = (data.extra_data.additionalDrank or 0) + 1
    elseif data.extra_data.qwerkiams =="trick" and not data.extraUse then
      player:addCardUseHistory(data.card.trueName, -1)
      data.extraUse = true
    end
  end,
})
qwerkiams:addEffect(fk.AfterCardUseDeclared, {
  can_refresh = function(self, event, target, player, data)
    return target == player and player:hasSkill(qwerkiams.name)
  end,
  on_refresh = function(self, event, target, player, data)
    data.extra_data=data.extra_data or {}
    data.extra_data.qwerkiams=player:getMark("@qwerkiams") 
    local n =S.getCardTypeByName(data.card.name) 
    if n== 2 then
      player.room:setPlayerMark(player, "@qwerkiams", "trick")
    elseif n==3 then
        player.room:setPlayerMark(player, "@qwerkiams", "equip")
    else
        player.room:setPlayerMark(player, "@qwerkiams", 0)
    end
  end,
})
qwerkiams:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope)
    return player:hasSkill(qwerkiams.name) and player:getMark("@qwerkiams")=="trick" and skill.trueName == "ssaet_skill" and
      scope == Player.HistoryPhase
  end,
  bypass_distances = function(self, player, skill)
    return player:hasSkill(qwerkiams.name) and player:getMark("@qwerkiams")=="trick"  and skill.trueName == "ssaet_skill"
  end,
})

return qwerkiams

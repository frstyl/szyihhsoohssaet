local tthxechdzoeoj = fk.CreateSkill {
  name = "tthxechdzoeoj",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["tthxechdzoeoj"] = "逞才",
  [":tthxechdzoeoj"] = "恆續｡伱預起動旹,若牌与伱上1牌字數(无視爲0)相同/不同,此次起動{无視次數限制/无視距離限制且目幖上限+1}",

  ["$tthxechdzoeoj1"] = "伱要學 我點撥伱耑正",  --每效果至少1句

}
-- Fk:addQmlMark{
--   name = "tthxechdzoeoj",
--   qml_path = "packages/utility/qml/DetailBox",
--   how_to_show = function() return " " end,
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos"



tthxechdzoeoj:addEffect(fk.CardUseFinished, {
  can_refresh= function(self, event, target, player, data)
    return target == player and player:hasSkill(tthxechdzoeoj.name,true)
  end,
  on_refresh= function(self, event, target, player, data)
    local room = player.room
    local n = S.getCardNameLength(data.card)
    room:setPlayerMark(player,"@tthxechdzoeoj", n)
  end,
})


tthxechdzoeoj:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return player:hasSkill(tthxechdzoeoj.name) and player:getMark("@tthxechdzoeoj") ==  S.getCardNameLength(card)
  end,
  bypass_distances = function(self, player, skill, card)
    return player:hasSkill(tthxechdzoeoj.name)  and  player:getMark("@tthxechdzoeoj") ~= S.getCardNameLength(card)
  end,
  extra_target_func = function(self, player, skill, card)
    if player:hasSkill(tthxechdzoeoj.name)  and  player:getMark("@tthxechdzoeoj") ~= S.getCardNameLength(card) then
      return 1
    end
  end,
})


tthxechdzoeoj:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return data.from == player 
    and player:getMark("@tthxechdzoeoj") == Fk:translate(data.card.trueName, "zh_CN"):len() 
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse=true
  end,
})


return tthxechdzoeoj

local khoeojqloos = fk.CreateSkill {
  name = "khoeojqloos",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["khoeojqloos"] = "闓路",
  [":khoeojqloos"] = "恆續｡伱預起動旹,若牌与伱上1牌字數(无視爲0)相同/不同,此次起動{无視次數限制/无視距離限制目幖上限+1}",

  ["$khoeojqloos1"] = "伱要學 我點撥伱耑正",  --每效果至少1句

}
-- Fk:addQmlMark{
--   name = "khoeojqloos",
--   qml_path = "packages/utility/qml/DetailBox",
--   how_to_show = function() return " " end,
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos"



khoeojqloos:addEffect(fk.CardUseFinished, {
  can_refresh= function(self, event, target, player, data)
    return target == player and player:hasSkill(khoeojqloos.name,true)
  end,
  on_refresh= function(self, event, target, player, data)
    local room = player.room
    local n = S.getCardNameLengthcard(data.card)
    room:setPlayerMark(player,"@khoeojqloos", n)
  end,
})


khoeojqloos:addEffect("targetmod", {
  bypass_times = function(self, player, skill, scope, card)
    return player:hasSkill(khoeojqloos.name) and player:getMark("@khoeojqloos") ==  S.getCardNameLengthcard(card)
  end,
  bypass_distances = function(self, player, skill, card)
    return player:hasSkill(khoeojqloos.name)  and  player:getMark("@khoeojqloos") ~= S.getCardNameLengthcard(card)
  end,
  extra_target_func = function(self, player, skill, card)
    if player:hasSkill(khoeojqloos.name)  and  player:getMark("@khoeojqloos") ~= S.getCardNameLengthcard(card) then
      return 1
    end
  end,
})


khoeojqloos:addEffect(fk.PreCardUse, {
  can_refresh = function (self, event, target, player, data)
    return data.from == player 
    and player:getMark("@khoeojqloos") == Fk:translate(data.card.trueName, "zh_CN"):len() 
  end,
  on_refresh = function (self, event, target, player, data)
    data.extraUse=true
  end,
})


return khoeojqloos

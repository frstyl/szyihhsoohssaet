
local liuqhzveec = fk.CreateSkill {
  name = "liuqhzveec",
}

Fk:loadTranslationTable{
["liuqhzveec"] = "流螢",
[":liuqhzveec"] = "主旹,伱打出一至多牌發動.伱抽x,予脚色伱坐次後y者1點无源火傷(x=所弃牌數,y=所弃牌點數合)｡若受傷者爲伱,褈置此技能次數",
--區分伱已此法所起動 与 此牌?
["#liuqhzveec-active"] = "隨機傷一脚色",

["$liuqhzveec1"] = "來一个,殺一个.來一對,殺一雙",
["$liuqhzveec2"] = "絳霞影裏,卷一道凍地仌霜",
}


local S = require "packages/szyihhsoohssaet/szyih_guos"

liuqhzveec:addEffect("active", {
  prompt = "#liuqhzveec-active",
  target_num = 0,
  -- max_phase_use_time = 1,
  min_card_num = 1,
  -- include_equip=true,
  card_filter = function(self, player, to_select)
    return not player:prohibitResponse(to_select)
  end,
  -- target_filter = function(self, player, to_select, selected)
  --   return not player:prohibitDiscard(to_select) and #selected<#Fk.alive_playes
  -- end,
  max_phase_use_time = 1,
  on_use = function (self, room, effect)
    local player =effect.from
    local cards = effect.cards
    S.playCard(player,cards,liuqhzveec.name)
    if player:isAlive() then
      player:drawCards(#cards, liuqhzveec.name)
    end
    local x=0
    for _, id in ipairs(cards) do
      x=x+Fk:getCardById(id).number
    end
    -- x=x% #(room.alive_players)
    local to = S.getNextOne(player,x)
    room:damage{
        -- from = player,  --无源
        to = to,
        damage = 1,
        damageType = fk.FireDamage,
        skillName = liuqhzveec.name,
      }
    if to == player then 
      player:setSkillUseHistory(liuqhzveec.name, 0, Player.HistoryPhase)
    end
  end,
})

return liuqhzveec


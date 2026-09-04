local kheemqsziuh = fk.CreateSkill{
  name = "kheemqsziuh",
}

Fk:loadTranslationTable{
  ["kheemqsziuh"] = "謙守",
  [":kheemqsziuh"] = "轉限1｡1轉脚色A起動牌B旹,伱可發動｡A抽1,1轉內A不可{起動/打出/弃置}B牌類",

  ["#kheemqsziuh-invoke"] = "謙守： %src 起動 %arg, 是否發動",

  ["@kheemqsziuh-prohibit-turn"] = "謙守",

  ["$kheemqsziuh1"] = "吾已埋下伏兵，敌兵一来，管教他瓮中捉鳖。",
  ["$kheemqsziuh2"] = "我已设下重重圈套，就等敌军入彀矣。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

kheemqsziuh:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(kheemqsziuh.name)
    and 
    target == Fk:currentRoom():getCurrent() 
    and
    player:usedEffectTimes(kheemqsziuh.name, Player.HistoryTurn) == 0
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    if player.room:askToSkillInvoke(player, {
      skill_name = kheemqsziuh.name,
      prompt = "#kheemqsziuh-invoke:"..data.from.id.."::"..data.card:toLogString(),
    }) 
    then
      event:setCostData(self,{tos={target}})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    target:drawCards(1,kheemqsziuh.name)
    room:addTableMarkIfNeed(target, "@kheemqsziuh-prohibit-turn", S.getCardTypeByName(data.card.trueName))
  end,
})



kheemqsziuh:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@kheemqsziuh-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@kheemqsziuh-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@kheemqsziuh-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@kheemqsziuh-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@kheemqsziuh-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@kheemqsziuh-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
  prohibit_discard = function(self, player, card)
    if player:getMark("@kheemqsziuh-prohibit-turn")==0 then return end
    if table.contains(player:getTableMark("@kheemqsziuh-prohibit-turn"), S.getCardTypeByName(card.trueName)) then
    return true
    end
    if card:isVirtual() then
      for _,id in ipairs(card.subcards) do

        if table.contains(player:getTableMark("@kheemqsziuh-prohibit-turn"), S.getCardTypeByName(Fk:getCardById(id).trueName)) then
          return true
        end
      end
    end
  end,
})


return kheemqsziuh

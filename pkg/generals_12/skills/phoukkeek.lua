local phoukkeek = fk.CreateSkill {
  name = "phoukkeek",
}

Fk:loadTranslationTable{
  ["phoukkeek"] = "撲擊",
  [":phoukkeek"] = "➀當伱當使用殺指定目幖後,伱預打出x(至少1)牌發動,令目幖弃x+1手牌.➁當伱使用殺致傷旹,若伱无手牌,必發,傷害值+1；",

  ["#phoukkeek-invoke"] = "撲擊：打出牌，令 %dest 弃x+1手牌",
  ["#phoukkeek-discard2"] = "撲擊：弃置 %arg 手牌",

  ["$phoukkeek1"] = "劈風刀下不斬无名之鬼",
  ["$phoukkeek2"] = "生亦生,死則死"
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


phoukkeek:addEffect(fk.TargetSpecified, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(phoukkeek.name) and
      data.card.trueName == "ssaet" and not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local cards = S.askToPlayCard(player, {
      min_num = 1,
      max_num = 999,
      include_equip = true,
      skill_name = phoukkeek.name,
      cancelable = true,
      prompt = "#phoukkeek-invoke::" .. data.to.id,
      -- pattern=".",
      skip = true,
    })
    if #cards > 0 then
      event:setCostData(self, {tos = {data.to}, cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards = event:getCostData(self).cards
    -- room:throwCard(cards, phoukkeek.name, player, player)
    S.playCard(player,cards,phoukkeek.name)
    if not (player.dead or data.to.dead or data.to:isNude()) then
      local n=1+#cards
    local cards = room:askToDiscard(data.to, {
      min_num = n,
      max_num = n,
      include_equip = false,
      skill_name = phoukkeek.name,
      cancelable = false,
      prompt = "#phoukkeek-discard2::" .. n,
      skip = false,
    })
    end
  end,
})

phoukkeek:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(phoukkeek.name) and
      data.card and data.card.trueName == "ssaet" 
      and #player:getCardIds("h")==0
  end,
  on_cost = Util.TrueFunc,  --?
  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=1,skillName=phoukkeek.name})
  end,
})
return phoukkeek

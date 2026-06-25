
local phiocqmoac = fk.CreateSkill{
  name = "phiocqmoac",
}
Fk:loadTranslationTable{
["phiocqmoac"] = "鋒芒",
[":phiocqmoac"] = "游戲始旹,將刀置入伱裝僃區｡伱末段始旹任意次,伱可與迻除1刀或事件牌選擇1其他角色發動.伱與其1傷",

["#phiocqmoac-choose"] = "鋒芒 選擇所弃牌 傷害目幖",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 
local U = require "packages/utility/utility"

phiocqmoac:addEffect(fk.GameStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(phiocqmoac.name)
  end,
  on_cost = Util.TrueFunc,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local card = table.find(U.prepareDeriveCards(room, {{"phiocqmoac_toav", Card.Spade, 1}}, phiocqmoac.name), function (id)
      return player.room:getCardArea(id) == Card.Void
    end)
    if card then
      room:moveCardIntoEquip(player, card, phiocqmoac.name, true, player)
    end
  end,
})
phiocqmoac:addEffect(fk.EventPhaseStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(phiocqmoac.name) and player.phase == Player.Finish
  end,
-- phiocqmoac:addEffect(fk.RoundEnd, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return player:hasSkill(phiocqmoac.name)
--   end,

  trigger_times = function(self, event, target, player, data)
    return 999
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local ids=player:getPile("maestoav_toav")
    for _, id in ipairs(player:getCardIds("h")) do
      if S.getCardTypeByName(Fk:getCardById(id).name)==5  then
        table.insert(ids,id)
      end
    end
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 1,
        min_card_num = 1,
        max_card_num = 1,
        targets = room:getOtherPlayers(player, false),
        pattern = ".|.|.",
        skill_name = phiocqmoac.name,
        prompt = "#phiocqmoac-choose",
        cancelable = true,
        will_throw = true,
        pattern = tostring(Exppattern{ id = ids }),
        expand_pile = player:getPile("maestoav_toav"),
     })
    if #tos>0 and #cards>0 then
        event:setCostData(self, {tos = tos, cards = cards})
        return true
    end
    end,
  on_use = function(self, event, target, player, data)
    player.room:moveCardTo(event:getCostData(self).cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, phiocqmoac.name, nil, true, player)
    player.room:damage{
        to = event:getCostData(self).tos[1] ,
        from=player,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = phiocqmoac.name,
      } 
  end,
})



return phiocqmoac

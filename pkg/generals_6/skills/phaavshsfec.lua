local phaavshsfec = fk.CreateSkill {
  name = "phaavshsfec",
}

Fk:loadTranslationTable{
  ["phaavshsfec"] = "炮轟",
  [":phaavshsfec"] = "游戲始旹,將<a href=':phaavshsfec__phaavs'>炮</a>置入伱裝僃區.伱轉始旹可發動，若伱裝僃區无炮,將炮置入伱裝僃區,否則伱改變炮類或射程",

  ["#phaavshsfec-choose"] = "炮轟：你可以弃置一名其他角色至多两张牌",
  ["#phaavshsfec-invoke"] = "炮轟：裝僃炮",
  ["#phaavshsfec-invoke-turun"] = "炮轟：流失1體力 裝僃炮",

  ["$phaavshsfec1"] = "帥炮卽軍心",--大炮在此軍心不亂
  ["$phaavshsfec2"] = "大其飄揚軍威雄壯",
}

local U = require "packages/utility/utility"

phaavshsfec:addEffect(fk.GameStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(phaavshsfec.name) then
      local catapult = table.find(U.prepareDeriveCards(player.room, {{ "phaavshsfec__phaavs", Card.Heart, 8 }}, phaavshsfec.name), function (id)
        return player.room:getCardArea(id) == Card.Void
      end)
      return catapult and player:canMoveCardIntoEquip(catapult)
    end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = phaavshsfec.name,
      prompt = "#phaavshsfec-invoke",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local catapult = table.find(U.prepareDeriveCards(room, {{"phaavshsfec__phaavs", Card.Diamond, 9}}, phaavshsfec.name), function (id)
      return player.room:getCardArea(id) == Card.Void
    end)
    if catapult then
      room:setCardMark(Fk:getCardById(catapult), MarkEnum.DestructOutMyEquip, 1)
      room:moveCardIntoEquip(player, catapult, phaavshsfec.name, true, player)
    end
  end,
})

phaavshsfec:addEffect(fk.TurnStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(phaavshsfec.name) then
      if not table.find(player:getEquipments(Card.SubtypeTreasure), function(id)
        return Fk:getCardById(id).name == "phaavshsfec__phaavs"
      end) then

        local catapult = table.find(U.prepareDeriveCards(player.room, {{"phaavshsfec__phaavs", Card.Diamond, 9}}, phaavshsfec.name), function (id)
          return player.room:getCardArea(id) == Card.Void
        end)
        return catapult and player:canMoveCardIntoEquip(catapult)
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
        skill_name = phaavshsfec.name,
        prompt = "#phaavshsfec-invoke",
      }) 
  end,
  on_use = function(self, event, target, player, data)
   if player.dead then return end
   local room= player.room

    local catapult = table.find(U.prepareDeriveCards(room, {{"phaavshsfec__phaavs", Card.Diamond, 9}}, phaavshsfec.name), function (id)
      return player.room:getCardArea(id) == Card.Void
    end)
    if catapult then
      room:setCardMark(Fk:getCardById(catapult), MarkEnum.DestructOutMyEquip, 1)
      room:moveCardIntoEquip(player, catapult, phaavshsfec.name, true, player)
    end
  end,
})

return phaavshsfec

local gracqgi = fk.CreateSkill {
  name = "gracqgi",
}

Fk:loadTranslationTable{
  ["gracqgi"] = "擎旗",
  [":gracqgi"] = "游戲始旹,將<a href=':gracqgi__gi'>杏黄旗</a>置入伱裝僃區.伱轉始旹，若伱裝僃區无杏黄旗,伱可流失1體力,將旗置入伱裝僃區",

  ["#gracqgi-choose"] = "擎旗：你可以弃置一名其他角色至多两张牌",
  ["#gracqgi-invoke"] = "擎旗：裝僃杏黄旗",
  ["#gracqgi-invoke-turun"] = "擎旗：流失1體力 裝僃杏黄旗",

  ["$gracqgi1"] = "帥旗卽軍心",--大旗在此軍心不亂
  ["$gracqgi2"] = "大其飄揚軍威雄壯",
}

local U = require "packages/utility/utility"

gracqgi:addEffect(fk.GameStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(gracqgi.name) then
      local catapult = table.find(U.prepareDeriveCards(player.room, {{ "gracqgi__gi", Card.Heart, 8 }}, gracqgi.name), function (id)
        return player.room:getCardArea(id) == Card.Void
      end)
      return catapult and player:canMoveCardIntoEquip(catapult)
    end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = gracqgi.name,
      prompt = "#gracqgi-invoke",
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local catapult = table.find(U.prepareDeriveCards(room, {{"gracqgi__gi", Card.Diamond, 9}}, gracqgi.name), function (id)
      return player.room:getCardArea(id) == Card.Void
    end)
    if catapult then
      room:setCardMark(Fk:getCardById(catapult), MarkEnum.DestructOutMyEquip, 1)
      room:moveCardIntoEquip(player, catapult, gracqgi.name, true, player)
    end
  end,
})

gracqgi:addEffect(fk.TurnStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(gracqgi.name) then
      if not table.find(player:getEquipments(Card.SubtypeTreasure), function(id)
        return Fk:getCardById(id).name == "gracqgi__gi"
      end) then

        local catapult = table.find(U.prepareDeriveCards(player.room, {{"gracqgi__gi", Card.Diamond, 9}}, gracqgi.name), function (id)
          return player.room:getCardArea(id) == Card.Void
        end)
        return catapult and player:canMoveCardIntoEquip(catapult)
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
        skill_name = gracqgi.name,
        prompt = "#gracqgi-invoke",
      }) 
  end,
  on_use = function(self, event, target, player, data)
   if player.dead then return end
   local room= player.room
   room:loseHp(player,1,gracqgi.name,player)
   
   if player.dead then return end
    local catapult = table.find(U.prepareDeriveCards(room, {{"gracqgi__gi", Card.Diamond, 9}}, gracqgi.name), function (id)
      return player.room:getCardArea(id) == Card.Void
    end)
    if catapult then
      room:setCardMark(Fk:getCardById(catapult), MarkEnum.DestructOutMyEquip, 1)
      room:moveCardIntoEquip(player, catapult, gracqgi.name, true, player)
    end
  end,
})

return gracqgi

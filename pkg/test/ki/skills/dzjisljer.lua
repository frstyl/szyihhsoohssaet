Fk:loadTranslationTable{
  ["dzjisljer"] = "自礪",
  [":dzjisljer"] = "伱分得初始手牌/失去手牌後,若伱手牌中无｢殺｣,伱可發動,伱展示手牌,抽1.",


  ["$dzjisljer1"] = "哈哈哈哈哈哈哈哈！",
  ["$dzjisljer2"] = "伯符，且看我这一手！",
}

local dzjisljer = fk.CreateSkill{
  name = "dzjisljer",
  -- tags = { Skill.Compulsory,Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- local n =data.damage
    local cards=player:getCardIds("h") 
    player:showCards(cards)
    player:drawCards(1,dzjisljer.name)

  end,
}

dzjisljer:addEffect(fk.AfterDrawInitialCards, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player
    and player:hasSkill(dzjisljer.name) 
    and not table.find(player:getCardIds("h") ,function(id) return Fk:getCardById(id).trueName=="ssaet" end)
  end,
  on_use = spec.on_use,
})


dzjisljer:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(dzjisljer.name)  then return false end

    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or Card.PlayerHand ~= move.toArea) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand )   then
            return not table.find(player:getCardIds("h") ,function(id) return Fk:getCardById(id).trueName=="ssaet" end) 
          end
        end
      end
    end

  end,
  on_use = spec.on_use,
})

return dzjisljer

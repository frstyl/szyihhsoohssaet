local coohtsziu = fk.CreateSkill {
  name = "coohtsziu",
}

Fk:loadTranslationTable{
  ["coohtsziu"] = "五州",
  [":coohtsziu"] = "主段內主旹或伱失去牌後,若伱手牌數小于x,伱可發動,伱抽牌至x.(x=5-伱裝僃區牌數)",

  ["#coohtsziu-invoke"] = "五州 抽 %arg",

  ["@coohtsziu-phase"] = "五州",

  ["$coohtsziu1"] = "兵精將猛山川險峻獨霸一方",
  ["$coohtsziu2"] = "五州五十六縣皆爲我土",
}


coohtsziu:addEffect("active", {
  anim_type = "drawcard",
  prompt = function (self, player, selected_cards, selected_targets)
    return  "#coohtsziu-invoke:::"..(5-#player:getCardIds("h"))
  end,
  card_num=0,
  target_num=0,
  times = function(self, player)
    return 5- #player:getCardIds("e") -  player:usedSkillTimes(coohtsziu.name, Player.phase) 
  end,
  can_use = function(self, player)
    return #player:getCardIds("h") < 5
    --and  player:usedSkillTimes(coohtsziu.name, Player.phase) < math.max(1, 5- #player:getCardIds("e"))
  end,
  on_use = function(self, room, effect)
    local player=effect.from
    local n = 5-#player:getCardIds("h")
    player:drawCards(n, coohtsziu.name)
    player.room:addPlayerMark(player,"@coohtsziu-phase",n)
  end,
})

coohtsziu:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  times = function(self, player)  --顯示
    return  5- #player:getCardIds("e") -  player:usedSkillTimes(coohtsziu.name, Player.phase) 
  end,
  can_trigger = function(self, event, target, player, data)
    if not (player:hasSkill(coohtsziu.name) and player.room.current == player and player.phase == Player.Play
    and #player:getCardIds("h")< 5) then return false end
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)   then
            return true
          end
        end
      end
    end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
          skill_name = coohtsziu.name,
          prompt = "#coohtsziu-invoke:::"..(5-#player:getCardIds("h")),
        })
  end,
  on_use = function(self, event, target, player, data)
    local n = 5-#player:getCardIds("h")
    player:drawCards(n, coohtsziu.name)
    player.room:addPlayerMark(player,"@coohtsziu-phase",n)
  end,
})
return coohtsziu

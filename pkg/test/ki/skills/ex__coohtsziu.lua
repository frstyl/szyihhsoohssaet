local ex__coohtsziu = fk.CreateSkill {
  name = "ex__coohtsziu",
}

Fk:loadTranslationTable{
  ["ex__coohtsziu"] = "五州",
  [":ex__coohtsziu"] = "段限max{1,x}.主段始旹,或主段內伱失去牌後,若伱手牌數小于等于max{1,(5-x)},伱可發動,伱抽max{1,(5-x)}.(x爲伱裝僃區牌數)",

  ["#ex__coohtsziu-invoke"] = "五州 抽 %arg",

  ["$ex__coohtsziu1"] = "兵精將猛山川險峻獨霸一方",
  ["$ex__coohtsziu2"] = "五州五十六縣皆爲我土",
}

-- local ex__coohtsziu_spec={
--   player:drawCards(5-#player:getCardIds("he"))
-- }

-- ex__coohtsziu:addEffect("active", {
--   anim_type = "drawcard",
--   prompt = function (self, player, selected_cards, selected_targets)
--     return  "#ex__coohtsziu-invoke:::"..math.max(1, #player:getCardIds("e"))
--   end,
--   card_num=0,
--   target_num=0,
--   -- max_phase_use_time=1, --分支次數 主旹
--   can_use = function(self, player)
--     local n =math.max(1, #player:getCardIds("e"))
--     return #player:getCardIds("h")<= 5-n
--     and 
--     player:usedSkillTimes(ex__coohtsziu.name, Player.HistoryPhase) < n 
--   end,
--   on_use = function(self, room, effect)
--     local player=effect.from
--     player:drawCards(5-math.max(1, #player:getCardIds("e")), ex__coohtsziu.name)  --,"top",MarkEnum.BypassTimesLimit.."-inhand-phase"
--   end,
-- })
local canUse =function(player)
    local n =#player:getCardIds("e") 
    if #player:getCardIds("h")<= math.max(1, 5-n) and player:usedSkillTimes(ex__coohtsziu.name, Player.phase) < math.max(1, n) then
      return true
    end
end

local spec={
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
          skill_name = ex__coohtsziu.name,
          prompt = "#ex__coohtsziu-invoke:::"..(math.max(1, 5-#player:getCardIds("e"))),
        })
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(math.max(1, 5-#player:getCardIds("e")), ex__coohtsziu.name)
  end,
}


ex__coohtsziu:addEffect(fk.AfterCardsMove, {
  anim_type = "drawcard",
  times = function(self, player)  --顯示
    return math.max(1, #player:getCardIds("e"))- player:usedSkillTimes(ex__coohtsziu.name, Player.HistoryPhase)
  end,
  can_trigger = function(self, event, target, player, data)
    if not ( player:hasSkill(ex__coohtsziu.name) and player.room.current == player and player.phase == Player.Play) then return end
    if not  canUse(player) then return end 
      
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
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})


ex__coohtsziu:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(ex__coohtsziu.name) and data.phase==Player.Play and canUse(player)
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

return ex__coohtsziu

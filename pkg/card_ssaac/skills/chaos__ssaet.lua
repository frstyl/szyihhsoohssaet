local cardSkill = fk.CreateSkill {
  name = "chaos__ssaet_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

local ssaet_skill = Fk.skills["ssaet_skill"] --[[ @as ActiveSkill ]]

cardSkill:addEffect("cardskill", {
  prompt = function(self, player, selected_cards)
    local ssaet = Fk:cloneCard("chaos__ssaet")
    ssaet:addSubcards(selected_cards)
    S.mixCard(ssaet)
    local max_num = self:getMaxTargetNum(player, ssaet) -- halberd
    if max_num > 1 then
      local num = #table.filter(Fk:currentRoom().alive_players, function (p)
        return p ~= player and not player:isProhibited(p, ssaet)
      end)
      max_num = math.min(num, max_num)
    end
    return max_num > 1 and "#chaos__ssaet_skill_multi:::" .. max_num or "#chaos__ssaet_skill"
  end,
  max_phase_use_time = 1,
  target_num = 1,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.bypass_times) 
    or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", to_select)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player and
       ( (extra_data and extra_data.bypass_distances) or self:withinDistanceLimit(player, true, card, to_select))
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)  --對某角色次數距離
    if not Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data) then return end  --must_targets  include_targets  exclusive_targets
    return self:modTargetFilter(player, to_select, selected, card, extra_data) and
      (
        #selected > 0 
        -- player.phase ~= Player.Play 
        or
        (extra_data and extra_data.bypass_times) or
        self:withinTimesLimit(player, Player.HistoryPhase, card, "ssaet", to_select)
      )
  end,
  offset_func= Util.FalseFunc,
  on_use= function (self, room, cardUseEvent)  --早于PreCardUse
    local natures={"ssaet","thunder__ssaet","fire__ssaet"}
    local n=math.random(1,#natures)
    room:sendLog{
      type = "#chaos__ssaet_nature",
      arg =Fk:getDamageNatureName(n),
      arg2=cardUseEvent.card:toLogString()
      -- arg2 =cardUseEvent.card:getString,
    }
    cardUseEvent:changeCard(natures[n]) --標記
  end,
  -- on_action = function(self, room, use, finished)
  -- end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.to.dead then
  --     local map={["ssaet"]=fk.NormalDamage,
  --   ["thunder__ssaet"]=fk.FireDamage,
  -- ["fire__ssaet"]=fk.ThunderDamage,}
  -- local nature=map[effect.card.name]
  -- if effect.card:getMark("@@card_damage_nature-phase")=="thunder__ssaet" then
  --   nature=2
  -- end
      room:damage({
        from = effect.from,
        to = effect.to,
        card = effect.card,
        damage = 1,
        damageType = effect.card:getMark("@@card_damage_nature-phase") or 1,
        skillName = cardSkill.name,
        event_data= effect,
      })
      effect.from:drawCards(2,cardSkill.name)
      -- S.addTsziukzzyit()
    end
  end,
})

-- cardSkill:addEffect("filter", {
--   global=true,
--   card_filter = function(self, to_select, player, isJudgeEvent)
--     return to_select:getMark("@@card_damage_nature-phase") ~= 0
--     -- return #to_select:getTableMark("@@not_equip-inarea") ~= 0 --and Fk:getCardById(to_select).area~=Card.PlayerEquip
--   end,
--   view_as = function(self, player, to_select)
--     return Fk:cloneCard(to_select:getMark("@@card_damage_nature-phase"), to_select.suit, to_select.number)
--   end,
-- })

return cardSkill

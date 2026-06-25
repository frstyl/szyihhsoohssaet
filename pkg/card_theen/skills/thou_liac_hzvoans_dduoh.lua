local cardSkill = fk.CreateSkill {
  name = "thou_liac_hzvoans_dduoh_skill",
}

Fk:loadTranslationTable{
  ["#thou_liac_hzvoans_dduoh_skill"] = "偸樑換柱 對距離0內角色使用,觀看其手牌,且伱可以己1手牌与其1手牌交換",  --偷樑換柱
  ["#szyih_kouc_skill-choose"] = "偸樑換柱 選擇1張与手牌交換",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:addPoxiMethod{
  name = cardSkill.name,
  prompt = "#thou_liac_hzvoans_dduoh_skill-choose",
  card_filter = function(to_select, selected, data)
    if #selected < 2 then
      if #selected == 0 then
        return true
      else
        if table.contains(data[1][2], selected[1]) then
          return table.contains(data[2][2], to_select)
        else
          return table.contains(data[1][2], to_select)
        end
      end
    end
  end,
  feasible = function(selected)
    return #selected == 2 or #selected == 0
  end,
}

cardSkill:addEffect("cardskill", {
  prompt = "#thou_liac_hzvoans_dduoh_skill",
  target_num = 1,
  -- distance_limit = 0,
  -- mod_target_filter  = function(self, player, to_select, selected, card, extra_data) 
  --    return  to_select ~= player  
  --    and (
  --     self:withinDistanceLimit(player, false, card, to_select) 
  --     or (extra_data and extra_data.bypass_distances) 
  --     )
  -- end,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.koarbiuk_rule)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player 
      -- and  ( 
      --   (extra_data and extra_data.bypass_distances)  --葢必bypass_distances
      --   or  self:withinDistanceLimit(player, false, card, to_select)
      -- )
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to=effect.to
    local from=effect.from
    local cards={}


    room:moveCards({
      ids = S.getKhouc(room,1),
      to = effect.from,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = effect.from,
      skillName = cardSkill.name,
      moveVisible = true,
    })
    if from.dead or to.dead then return end
      local results = room:askToPoxi(from, {
        poxi_type = cardSkill.name,
        data = {
          { to.general, to:getCardIds("h") },
          { from.general, from:getCardIds("h") },
        },
        cancelable = true,
      })
    local card1 = table.contains(to:getCardIds("h"), results[1]) and results[1] or results[2]
    local card2 = card1 == results[1] and results[2] or results[1]

    room:swapCards(from, {
      {from, {card2}},
      {to, {card1}},
      }, 
    cardSkill.name)
    -- room:viewCards(effect.from, 
    --  { cards = effect.to:getCardIds("h"), 
    --  skill_name = skill.name, 
    --  prompt = skill.name,
    -- })
    -- end
  end,
})



return cardSkill

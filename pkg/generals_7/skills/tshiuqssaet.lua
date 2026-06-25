local tshiuqssaet = fk.CreateSkill({
  name = "tshiuqssaet",
})

Fk:loadTranslationTable{
  ["tshiuqssaet"] = "秌殺",
  [":tshiuqssaet"] = "主旹,伱預弃x梅花手牌選擇x其它角色伱至其距離不大于1者發動.伱對所選角色各与1傷",  --可无色  --梅花?

  ["#puohquat"] = "秌殺：選x梅花牌与x名至其距離不大于1其它角色",
}

tshiuqssaet:addEffect("active", {
  anim_type = "offensive",
  prompt = "#puohquat",
  min_card_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(tshiuqssaet.name, Player.HistoryPhase) < 1 
  -- end,
  card_filter = function(self, player, to_select, selected)
    return          table.contains(player:getCardIds("h"), to_select) and not player:prohibitDiscard(to_select) 
    -- and   table.every(selected, function (id)
    --   return Fk:getCardById(to_select):compareSuitWith(Fk:getCardById(id), true)
    -- end)
    and  Fk:getCardById(to_select).suit==Card.Club
  end,
  target_filter = function(self, player, to_select, selected,selected_cards)
    return #selected<#selected_cards
    and player:compareDistance(to_select,1,"<=")
    -- to_select.hp<2 
  end,
  feasible = function (self, player, selected, selected_cards, card)
    return #selected_cards == #selected
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    room:throwCard(effect.cards, tshiuqssaet.name, player, player)
    for _, p in ipairs(effect.tos) do
      if not p.dead then
        room:damage{
          from = player,
          to = p,
          damage = 1,
          damageType = fk.NormalDamage,
          skillName = tshiuqssaet.name,
        }
      end
    end
  end,
})

return tshiuqssaet

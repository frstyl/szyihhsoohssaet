local szissik = fk.CreateSkill({
  name = "szissik",
})

Fk:loadTranslationTable{
  ["szissik"] = "試色",
  [":szissik"] = "主旹,伱可与1其它脚色A賭鬥發動.若賭鬥牌:同色,伱抽2,A抽2; 異色,伱自弃1,A自弃1",

  ["#szissik"] = "試色 与1其它脚色A賭鬥發動",

  ["$szissik1"] = "此乃巧鬥吞狼之计。",
  ["$szissik2"] = "借你之手，与他一搏吧。",
}

szissik:addEffect("active", {
  anim_type = "offensive",
  prompt = "#szissik",
  max_phase_use_time = 1,
  card_num = 1,
  target_num = 1,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and player:canPindian(to_select) 
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, szissik.name,Fk:getCardById(effect.cards[1]))
    if player.dead or target.dead then return end

    local fromCard= pindian.fromCard --可能變
    local toCard =  pindian.results[target].toCard
    if not fromCard or toCard==nil then return end
    if fromCard:compareColorWith(toCard) then
      if not player.dead then player:drawCards(2,szissik.name) end
      if not target.dead then target:drawCards(2,szissik.name) end
    else
      local param={
        min_num=1,
        max_num=1,
        include_equip=true,
        skip=false,
      }
      if not player.dead then room:askToDiscard(player, param) end
      if not target.dead then room:askToDiscard(target, param) end
    end
  end,
})

return szissik

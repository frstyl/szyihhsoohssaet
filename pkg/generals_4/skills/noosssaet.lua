local noosssaet = fk.CreateSkill{
  name = "noosssaet",
}

Fk:loadTranslationTable{
  ["noosssaet"] = "怒殺",
  [":noosssaet"] = "皆主旹,伱可預弃1殺，選擇1角色體力值或手牌數至大者(皆不計伱)發動.伱与其1傷.執行歬,若其手牌數體力值皆至大,伱可弃1手牌令傷害值+1",

  ["#noosssaet"] = "怒殺：弃一殺，与1角色1傷 ",
  ["#noosssaet-discard"] = "怒殺：弃一牌 對 %src 傷害+1",

  ["$noosssaet1"] = "伱昰廝是喫已熊心豹子膽。",
  ["$noosssaet2"] = "丞相勿忧，司马懿不足为患。",
}

noosssaet:addEffect("active", {
  anim_type = "offensive",
  prompt = "#noosssaet",
  card_num = 1,
  target_num = 1,
  max_phase_use_time=1,
  can_use = function(self, player)
    return player:usedSkillTimes(noosssaet.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and not player:prohibitDiscard(to_select) and Fk:getCardById(to_select).trueName=="ssaet"
  end,
  target_filter = function(self, player, to_select, selected, cards)
    local ps=      table.filter(Fk:currentRoom().alive_players, function(p)
        return p~=player
      end)
    if #ps<=1 then return  table.contains(p,selected) end
    local hand={ps[1]}
    local hp={ps[1]}
    local n=#ps[1]:getCardIds("h")
    for i=2, #ps,1 do
      if hp[1].hp < ps[i].hp then  --能傳否
        hp={ps[i]}
      elseif hand[1].hp == ps[i].hp then
        table.insert(hp, ps[i])
      end

      if n < #ps[i]:getCardIds("h") then  --能傳否
        hand={ps[i]}
        n=#ps[i]:getCardIds("h")
      elseif n == #ps[i]:getCardIds("h") then
        table.insert(hand, ps[i])
      end
      
    end
    return #selected == 0 and
      (table.contains(hand,to_select) or table.contains(hp,to_select))
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    room:throwCard(effect.cards, noosssaet.name, player, player)
    if  target.dead then return end
    local n=1
    if       table.every(room:getOtherPlayers(player), function(p)
        return p.hp <= target.hp
      end)
      and
      table.every(room:getOtherPlayers(player), function(p)
        return #p:getCardIds("h") <= #target:getCardIds("h")
      end)
      and
      #room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = noosssaet.name,
        cancelable = true,
        pattern=".",  --slas?
        prompt = "#noosssaet-discard:"..target.id,
        cancelable=true,
        skip = false,
      }) ==1
      then 
        n=2
    end
      room:damage{
        from = player,
        to = target,
        damage = n,
        skillName = noosssaet.name,
      }
    
  end,
})

return noosssaet

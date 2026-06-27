local hqximqqwer_active = fk.CreateSkill {
  name = "hqximqqwer_active",
}

Fk:loadTranslationTable{
  ["hqximqqwer_active"] = "侌䘙",
}

hqximqqwer_active:addEffect("active", {
  card_filter = function (self, player, to_select, selected)
    return table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function (self, player, to_select, selected, selected_cards)
    return #selected < #selected_cards
  end,
  feasible = function (self, player, selected, selected_cards)
    return #selected == #selected_cards and #selected > 0
  end,
})

hqximqqwer_active:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player  --問多次?
    and   target:getMark("@@hqximqqwer") > 0 
    and data.damageType ~= fk.ThunderDamage 
    and data.from and data.from~=player
    and data.from:getMark("@@hqximqqwer")==0
  end,
  on_cost = Util.TrueFunc,
  on_use = function(self, event, target, player, data)
    -- local card = Fk:cloneCard("duel")  --虛牌鎖无色?
    -- card.skillName = hqximqqwer.name
    -- card:addFakeSubcard(cards)
    local use = player.room:useVirtualCard("duel", nil, player, data.from, hqximqqwer_active.name, true)
    -- room:useCard(use)
    if not use or target.dead then return end      
    if use.damageDealt and use.damageDealt[data.from] then
      data:preventDamage()
    end
  end,
})

hqximqqwer_active:addEffect(fk.DamageInflicted, {
  priority=2, --duel失敗
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and data.card and table.contains(data. card.skillName, hqximqqwer_active.name)
    and player:getMark("@@hqximqqwer")>0
  end,
  on_trigger=  function(self, event, target, player, data)
        data:preventDamage()
    player.room:setPlayerMark(player,"@@hqximqqwer",0) 
  end,
})

return hqximqqwer_active

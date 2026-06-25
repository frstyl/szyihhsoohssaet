local maestthiacs = fk.CreateSkill {
  name = "maestthiacs",
}

Fk:loadTranslationTable{
  ["maestthiacs"] = "賣唱",
  [":maestthiacs"] = "主旹,伱可預展示3{黑/紅}手牌發動.其它存活角色各{弃1手牌/抽1},肰後各選一項1➀交与伱1手牌➁視爲伱對其使用无中生有",

  ["#maestthiacs-discard"] = "賣唱：弃1手牌",
  ["#maestthiacs-give"] = "賣唱：是否交与 %src 1手牌",

  ["$maestthiacs1"] = "老咬蟲喫貧婆賤人豈敢罵我",
  ["$maestthiacs2"] = "少刻我對知縣說看道奈何得伱輩也不",
}

maestthiacs:addEffect("active", {
  anim_type = "control",
  prompt = "#maestthiacs",
  card_num = 3,
  card_filter = function(self, player, to_select, selected)
    return table.contains(player:getCardIds("h"),to_select)
    and (
      (#selected==0 and Fk:getCardById(to_select).color~=Card.NoColor)
    or (#selected~=0 and Fk:getCardById(to_select).color== Fk:getCardById(selected[1]).color))
  end,
  max_phase_use_time=1,
  on_use = function(self, room, effect)  --目幖?
    local player = effect.from
    local targets = room:getOtherPlayers(player)

    if Fk:getCardById(effect.cards[1]).color~=Card.Black then
      for _,p in ipairs(targets) do
        p:drawCards(1,maestthiacs.name)
      end
    else
      for _,p in ipairs(targets) do
        local cards = room:askToDiscard(player, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = maestthiacs.name,
          prompt = "#maestthiacs-discard",
          cancelable = false,
          skip = false,
        })
      end
    end
    for _, p in ipairs(targets) do
      if player.dead then break end
      if not p.dead then
        local card = room:askToCards(p, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = maestthiacs.name,
          cancelable = true,
          prompt = "#maestthiacs-give:"..player.id,
        })
        if #card > 0 then
          room:moveCardTo(card, Card.PlayerHand, player, fk.ReasonGive, maestthiacs.name, nil, false, p)
        else
          room:useVirtualCard("muo_ttiuc_ssaac_qiuh", nil, player, {p}, maestthiacs.name, true)  --??檢測合理?
        end
      end
    end
  end,
})


return maestthiacs

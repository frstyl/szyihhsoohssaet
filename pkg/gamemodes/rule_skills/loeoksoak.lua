local loeoksoak = fk.CreateSkill {
  name = "loeoksoak",
  mode_skill = true,
}

Fk:loadTranslationTable{
  ["loeoksoak"] = "勒索",
  [":loeoksoak"] = "主旹,与1其它脚色A賭鬥發動.若伱:贏,伱取得雙方賭鬥牌;未贏,A弃1手牌",

  ["#loeoksoak"] = "勒索：与一名脚色賭鬥，若赢，伱取得其1牌",

  ["$loeoksoak1"] = "不給也得給",
}

loeoksoak:addEffect("active", {
  anim_type = "control",
  prompt = "#loeoksoak",
  min_card_num = 0,
  max_card_num = 1,
  target_num = 1,
  max_phase_use_time =1,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player and player:canPindian(to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, loeoksoak.name, effect.cards[1] and Fk:getCardById(effect.cards[1]) or nil)
    if player.dead then return end
    if pindian.results[target].winner == player then
      -- local cid = room:askToChooseCard(effect.from, { target = target, flag = "he", skill_name = loeoksoak.name })
      -- room:obtainCard(effect.from, cid, false, fk.ReasonPrey, effect.from, loeoksoak.name)
      local to_get = {}
      local cid = pindian.fromCard and pindian.fromCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insert(to_get, cid)
      end
      local toCard = pindian.results[target].toCard
      cid = toCard and toCard:getEffectiveId()
      if room:getCardArea(cid) == Card.DiscardPile then
        table.insertIfNeed(to_get, cid)
      end
      if #to_get > 0 then
        room:obtainCard(player, to_get, true, fk.ReasonPrey, loeoksoak, "zhiba")
      end
    else
    room:askToDiscard(target, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = loeoksoak.name,
        cancelable = false,
        prompt = "#loeoksoak-discard",
        skip = false,
      })   
    end
  end,
})



return loeoksoak

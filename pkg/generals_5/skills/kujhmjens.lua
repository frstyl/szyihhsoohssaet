local kujhmjens = fk.CreateSkill{
  name = "kujhmjens",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["kujhmjens"] = "鬼面",
  [":kujhmjens"] = "鎖定.每輪始旹必發,伱迻除鬼面牌,將牌堆頂1牌置于武將牌上.恆續,伱不是与鬼面牌同花牌之合理目幖",

  ["kujhmjens_mjens"] = "鬼面",

  ["$kujhmjens1"] = "我欲行夏禹旧事，为天下人。",

}

kujhmjens:addEffect(fk.RoundStart, {
  derived_piles = "kujhmjens_mjens",
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(kujhmjens.name) 
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room
    local cards=player:getPile("kujhmjens_mjens")
    if #cards>0 then
      room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, kujhmjens.name, nil, true, player)
    end
    -- local cards = room:askToCards(player, {
    --   min_num = 1,
    --   max_num = 1,
    --   include_equip = false,
    --   skill_name = kujhmjens.name,
    --   prompt = "#kujhmjens-card",
    --   cancelable = false,
    -- })
    player:addToPile("kujhmjens_mjens", room:getNCards(1), true, kujhmjens.name)

  end,
})

kujhmjens:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return to and #to:getPile("kujhmjens_mjens")>0  and card and from and  card:compareSuitWith(Fk:getCardById(to:getPile("kujhmjens_mjens")[1]))
  end,
})

return kujhmjens

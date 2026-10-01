local soakdzoeoj = fk.CreateSkill {
  name = "soakdzoeoj",
}

Fk:loadTranslationTable{
  ["soakdzoeoj"] = "索財",
  [":soakdzoeoj"] = "主旹,与1其它脚色賭鬥發動.若伱:贏,其交与伱一半(下整)手牌;未贏,其展示全部手牌,其受到x无源傷(x爲其中♦️牌數)",

  ["#soakdzoeoj"] = "索財：与一名脚色賭鬥，若赢，伱取得賭鬥牌",
  ["#soakdzoeoj-give"] = "索財 將 %arg 至多手交予 %src",

  ["$soakdzoeoj1"] = "今日撞在我手裏",
}

soakdzoeoj:addEffect("active", {
  anim_type = "control",
  prompt = "#soakdzoeoj",
  min_card_num = 0,
  max_card_num = 0,
  target_num = 1,
  card_filter = Util.FalseFunc,
  max_phase_use_time =1,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player and player:canPindian(to_select)
  end,
  on_use = function(self, room, effect)
    local player = effect.from
    local target = effect.tos[1]
    local pindian = player:pindian({target}, soakdzoeoj.name,effect.cards[1] and Fk:getCardById(effect.cards[1]) or nil)

    if player.dead or target.dead then return end

    if pindian.results[target].winner == player then
      -- local to_get = {}
      -- local cid = pindian.fromCard and pindian.fromCard:getEffectiveId()
      -- if room:getCardArea(cid) == Card.DiscardPile then
      --   table.insert(to_get, cid)
      -- end
      -- local toCard = pindian.results[target].toCard
      -- cid = toCard and toCard:getEffectiveId()
      -- if room:getCardArea(cid) == Card.DiscardPile then
      --   table.insertIfNeed(to_get, cid)
      -- end
      -- if #to_get > 0  then
      --   room:obtainCard(player, to_get, true, fk.ReasonPrey, player, soakdzoeoj.name)
      -- end
      local n=#target:getCardIds("h")/2
      if n>0 then
          local ids = room:askToCards(player, {
          min_num = n,
          max_num = n,
          include_equip = false,
          skill_name = soakdzoeoj.name,
          prompt = "#soakdzoeoj-choose:::"..n..":".. player.id,
          cancelable = false,
        })
        room:moveCardTo(ids, Player.Hand, player, fk.ReasonGive, soakdzoeoj.name, nil, false, player.id)

      end
    else
      -- room:damage{
      --   to = player,
      --   from=target,
      --   damage = 1,
      --   damageType = fk.NormalDamage,
      --   skillName = soakdzoeoj.name,
      -- } 
      local cards=target:getCardIds("h")
      target:showCards(cards)
      local n = #table.filter(target:getCardIds(cards ),
      function(id) return Fk:getCardById(id).suit==Card.Diamond
      end)
      if n<=0 or target.dead then return end

      room:damage{
        to = target ,
        from=nil,
        damage = n,
        damageType = fk.NormalDamage,
        skillName = soakdzoeoj.name,
      } 
    end
  end,
})



return soakdzoeoj

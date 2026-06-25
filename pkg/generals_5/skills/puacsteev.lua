local puacsteev = fk.CreateSkill {
  name = "puacsteev",
}

Fk:loadTranslationTable{
  ["puacsteev"] = "放刁",  --撒野
  -- [":puacsteev"] = "主段,選1伱攻程內其他角色發動.伱与其交換手牌",
  [":puacsteev"] = "輪限1｡其它角色補段終旹,若其有手牌,伱可發動｡伱獲取其全部手牌,交予其x牌｡(x爲伱發動歬手牌數)",

  ["#puacsteev-invoke"] = "放刁 %src 補段終, 是否發動",
  ["#puacsteev-choose"] = "放刁 交予 %src %arg 牌",

  ["$puacsteev1"] = "我特來向伱討百十串錢花",
}
puacsteev:addEffect(fk.EventPhaseEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(puacsteev.name) and target.phase == Player.Draw
    and not target:isKongcheng()
    and player:usedEffectTimes(puacsteev.name, Player.HistoryRound) == 0  --遊戲始屬第一輪
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = puacsteev.name,
      prompt = "#puacsteev-invoke:"..target.id,
    })
    then
      event:setCostData(self,{tos={target},n=#player:getCardIds("h")})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    if player.dead or target.dead then return end
    local room=player.room
    room:obtainCard(player, target:getCardIds("h"), false, fk.ReasonPrey, player, puacsteev.name)
    if player.dead or target.dead then return end
    local n=event:getCostData(self).n
    if n==0 then return end
    local cards = room:askToCards(player, {
      skill_name = puacsteev.name,
      min_num = n,
      max_num = n,
      pattern = ".",
      prompt = "#puacsteev-choose:"..target.id.."::"..n,
      cancelable=false,
    })
    if #cards==0 then return end
    room:obtainCard(target, cards, false, fk.ReasonGive, player, puacsteev.name)
  end,
})
-- puacsteev:addEffect("active", {
--   anim_type = "control",
--   max_phase_use_time = 1,
--   card_num = 0,
--   target_num = 1,
--   prompt = "#puacsteev",
--   max_phase_use_time=1,
--   -- can_use = function(self, player)
--   --   return player:usedSkillTimes(puacsteev.name) == 0 
--   -- end,
--   card_filter = Util.FalseFunc,
--   target_filter = function(self, player, to_select, selected, selected_cards)
--     return player:inMyAttackRange(to_select)
--   end,
--   on_use = function(self, room, effect)
--     local player = effect.from
--     room:swapAllCards(player, {player, effect.to[1],}, puacsteev.name)  --2角色用table
--   end,
-- })

return puacsteev

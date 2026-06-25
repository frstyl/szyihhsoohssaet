local gwisleejh = fk.CreateSkill {
  name = "gwisleejh",
}

Fk:loadTranslationTable{
  ["gwisleejh"] = "饋禮",
  [":gwisleejh"] = "輪限1.➀其它角色A轉始旹,選1手牌發動.將所選牌交与A,A抽3,交予伱2牌,伱褈鑄之.➁輪終,伱可發動,伱抽3,褈鑄2",

  ["#gwisleejh-active"] = "饋禮 將1手牌交予其他角色",
  ["#gwisleejh-choose"] = "饋禮 將1手牌交予 %src",

  ["#gwisleejh-card"] = "饋禮 交予 %arg 3牌",
  ["#gwisleejh-disdraw"] = "饋禮 弃3",

}
-- gwisleejh:addEffect("active", {
--   anim_type = "support",
--   prompt = "#gwisleejh-active",
--   max_card_num = 1,
--   max_target_num = 1,
--   max_phase_use_time=1,
--   card_filter = function(self, player, to_select, selected)
--     return table.contains(player:getCardIds("he"), to_select)
--   end,
--   target_filter = function(self, player, to_select, selected)
--     return #selected == 0 and to_select ~= player
--   end,
--   -- can_use=function(self,player)
--   --   return player:getMark("_gwisleejh-phase")==0
--   -- end,
--   on_use = function(self, room, effect)
--     local player = effect.from
--     local ids={}
--     if effect.tos[1] and effect.cards[1] then
--       local target = effect.tos[1]
--       local cards = effect.cards

--       room:moveCardTo(cards, Player.Hand, target, fk.ReasonGive, gwisleejh.name, nil, false, player.id)
--       target:drawCards(3,gwisleejh.name)
--        ids = room:askToCards(target, {
--           min_num = 3,
--           max_num = 3,
--           include_equip = true,
--           skill_name = gwisleejh.name,
--           prompt = "#gwisleejh-card::"..player.id,
--           cancelable = false,
--         })
--       room:moveCardTo(ids, Player.Hand, player, fk.ReasonGive, gwisleejh.name, nil, false, target.id)
--     else
--       player:drawCards(3,gwisleejh.name)
--        ids = room:askToCards(player, {
--         min_num = 3,
--         max_num = 3,
--         include_equip = true,
--         skill_name = gwisleejh.name,
--         prompt = "#gwisleejh-discard",
--         cancelable = false,
--       })
--     end
--       room:recastCard(ids, player, gwisleejh.name)
--   end,
-- })
gwisleejh:addEffect(fk.RoundEnd, {
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(gwisleejh.name) and player:usedSkillTimes(gwisleejh.name, Player.HistoryRound) == 0     
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    player:drawCards(3,gwisleejh.name)
    local    ids = room:askToCards(player, {
        min_num = 2,
        max_num = 2,
        include_equip = true,
        skill_name = gwisleejh.name,
        prompt = "#gwisleejh-discard",
        cancelable = false,
      })
    room:recastCard(ids, player, gwisleejh.name)
  end,
})
gwisleejh:addEffect(fk.TurnStart, {
  can_trigger = function(self, event, target, player, data)
    return  target~=player and player:hasSkill(gwisleejh.name) and player:usedSkillTimes(gwisleejh.name, Player.HistoryRound) == 0 
    and  not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local ids={}
    local room=player.room

      ids = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = gwisleejh.name,
        prompt = "#gwisleejh-choose:"..target.id,
        cancelable = true,
      })
      if #ids > 0 then
        event:setCostData(self,{ids=ids})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local ids=event:getCostData(self).ids
    local room=player.room

      room:moveCardTo(cards, Player.Hand, target, fk.ReasonGive, gwisleejh.name, nil, false, player.id)
      target:drawCards(3,gwisleejh.name)
       ids = room:askToCards(target, {
          min_num = 2,
          max_num = 2,
          include_equip = true,
          skill_name = gwisleejh.name,
          prompt = "#gwisleejh-card::"..player.id,
          cancelable = false,
        })
      room:moveCardTo(ids, Player.Hand, player, fk.ReasonGive, gwisleejh.name, nil, false, target.id)

      room:recastCard(ids, player, gwisleejh.name)
  end,
})

return gwisleejh

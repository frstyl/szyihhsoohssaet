local koamqljim = fk.CreateSkill {
  name = "koamqljim",
}

Fk:loadTranslationTable{
  ["koamqljim"] = "甘霖",
  [":koamqljim"] = "主動.主旹選擇至少1手牌与1其它角色A發動.將所選牌交与A,肰後伱選擇1項➀令A一轉內｢殺｣次數上限+1➁伱抽x,此技能當輪失效.(x爲當輪伱發動此技能次數)",

  ["#koamqljim-active"] = "甘霖 將任意手牌交予其他角色",

  ["#koamqljim-choose"] = "甘霖 將任意手交予 %src",
  ["koamqljim-draw"] = "抽 %arg 本輪內甘霖失效",

  -- ["koamqljim-ssaet"] = "其使用殺次數上限+1",
  -- ["koamqljim-draw"] = "補牌至已損體力值",

  ["@ssaet_times-turn"] = "殺數",

  ["@@koamqljim-inhand-turn"] = "甘霖",
}
-- koamqljim:addEffect("active", {
--   anim_type = "support",
--   prompt = "#koamqljim-active",
--   min_card_num = 1,
--   target_num = 1,
--   card_filter = function(self, player, to_select, selected)
--     return table.contains(player:getCardIds("h"), to_select)
--   end,
--   target_filter = function(self, player, to_select, selected)
--     return #selected == 0 and to_select ~= player
--   end,
--   can_use=function(self,player)
--     return player:getMark("_koamqljim-phase")==0
--   end,
--   on_use = function(self, room, effect)
--     local target = effect.tos[1]
--     local player = effect.from
--     local cards = effect.cards
--     local marks = player:getMark("_koamqljim_cards-phase")
--     room:moveCardTo(cards, Player.Hand, target, fk.ReasonGive, koamqljim.name, nil, false, player.id)
--     local choice = room:askToChoice(player, {
--           choices = {"koamqljim-ssaet","koamqljim-draw","Cancel"},
--           skill_name = koamqljim.name,
--           prompt = "#koamqljim-choice",
--           all_choices = all_names,
--         })
--     if choice=="Cancel" then return end

--     room:addPlayerMark(player,"_koamqljim-phase",1)
--     if choice=="koamqljim-ssaet" then 
--       room:addPlayerMark(target,"@koamqljim-ssaet",1)
--     else
--         local n=player:getLostHp()-player:getHandcardNum() 
--         if n>0 then
--         player:drawCards(n,koamqljim.name,"top","@@koamqljim-inhand-turn")
--         end
--     end
--   end,
-- })


koamqljim:addEffect(fk.TurnStart, {
  can_trigger = function(self, event, target, player, data)
    return  target~=player and player:hasSkill(koamqljim.name)  
    and  not player:isNude()
  end,
  on_cost = function(self, event, target, player, data)
    local ids={}
    local room=player.room

        ids = room:askToCards(player, {
        min_num = 1,
        max_num = 999,
        include_equip = true,
        skill_name = koamqljim.name,
        prompt = "#koamqljim-choose:"..target.id,
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

      room:moveCardTo(ids, Player.Hand, target, fk.ReasonGive, koamqljim.name, nil, false, player.id)

      room:addPlayerMark(target,"@ssaet_times-turn",1)
      room:addSkill("ssaet_times")
      if player.dead then return end
      local x=player:usedSkillTimes(koamqljim.name, Player.HistoryRound)
      -- local y=player:getLostHp()
    -- local choice = room:askToChoice(player, {
    --       choices = {"koamqljim-draw:::"..x,"koamqljim-draw:::"..y,"Cancel"},
    --       skill_name = koamqljim.name,
    --       prompt = "#koamqljim-choice",
    --       all_choices = all_names,
    --       cancelable=true,
    --     })
    if choice=="Cancel" then return end
      player:drawCards(x,koamqljim.name)
      room:invalidateSkill(player, koamqljim.name, "-round")

  end,
})


-- koamqljim:addEffect("maxcards", {
--   exclude_from = function(self, player, card)
--     return card:getMark("@@koamqljim-inhand-turn") > 0
--   end,
-- })

-- koamqljim:addEffect("targetmod", {
--   residue_func = function(self, player, skill, scope)
--     if player:getMark("@ssaet_times-turn") > 0 and skill.trueName == "ssaet_skill" and scope == Player.HistoryPhase then
--       return player:getMark("@ssaet_times-turn")
--     end
--   end,
-- })
return koamqljim

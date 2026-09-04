local szjethqeens = fk.CreateSkill {
  name = "szjethqeens",
  tags = {Skill.Composite},
}

Fk:loadTranslationTable{
  ["szjethqeens"] = "設宴",
  [":szjethqeens"] = "➀轉終,若當轉腳色爲伱或其轉內致傷合計不小于2點｡伱可將1手牌轉化爲｢置酒設筵｣起動發動.➁此置酒設筵生效結算歬,伱可選擇1脚色發動.其爲結算起點.",  --➂置酒設筵取牌終,若有𠟇餘牌,伱可發動,伱取得之

  -- ["#szjethqeens"] = "設宴：1紅桃牌轉化爲置酒設筵起動",
  ["#szjethqeens-use"] = "設宴：1手牌轉化爲｢置酒設筵｣起動",

  ["$szjethqeens1"] = "讓吾款待諸个",
  ["$szjethqeens2"] = "諸位兄弟請",
}

-- szjethqeens:addEffect("viewas", {
--   anim_type = "offensive",
--   pattern = "ttis_tsiuh_szjet_jjen",
--   prompt = "#szjethqeens",
--   handly_pile = true,
--   max_phase_use_time=1,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and Fk:getCardById(to_select).suit == Card.Heart
--   end,
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     local c = Fk:cloneCard("ttis_tsiuh_szjet_jjen")
--     c.skillName = szjethqeens.name
--     c:addSubcard(cards[1])
--     return c
--   end,
--   enabled_at_response = function(self, player, response)
--     return player:usedSkillTimes(szjethqeens,Play.HistoryPhase)==0
--   end,
--   enabled_at_response =Util.FalseFunc

-- })
szjethqeens:addEffect(fk.TurnEnd, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(szjethqeens.name) then return end
    if target==player then return true end
    local n =0
    player.room.logic:getActualDamageEvents(2, function (e)
            if e.data.from == target and e.data.damage >0 then n=n+e.data.damage return true end
          end, Player.HistoryTurn)
    return n>1
  end,
  on_cost = function(self, event, target, player, data)
    local cards=player:getHandlyIds(true)
    local use = player.room:askToUseVirtualCard(player, {
      name = "ttis_tsiuh_szjet_jjen",
      skill_name = szjethqeens.name,
      prompt = "#szjethqeens-use:"..to.id,
      cancelable = true,
      extra_data = {
      },
      card_filter = {
        n = 1,
        pattern=".|.|.",
        -- cards = cards,
      },
      skip = true,
    })
    if use then
      use.extra_data=use.extra_data or {}
      use.extra_data.szjethqeens=player.id
      event:setCostData(self, { extra_data = use,tos={use.tos} })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).extra_data)
  end,
})

szjethqeens:addEffect(fk.BeforeCardUseEffect, {
  can_trigger= function(self, event, target, player, data)
    return  player:hasSkill(szjethqeens.name) 
    -- and data.card.trueName=="ttis_tsiuh_szjet_jjen"
    and data.extra_data and data.extra_data.szjethqeens==player
  end,
  on_cost= function(self, event, target, player, data)
      local tos = player.room:askToChoosePlayers(player, {
        targets = data.tos,
        min_num = 1,
        max_num = 1,
        prompt = "#szjethqeens-choose",
        skill_name = szjethqeens.name,
        cancelable = true,
      })
      if #tos>0 then 
        event:setCostData(self,{tos=tos})
        return true
      end
  end,
  on_use= function(self, event, target, player, data)
    local new_tos = {}
    local n = table.indexOf(data.tos,event:getCostData(self).tos[1])
    local m= #data.tos
    for i, p in ipairs(data.tos) do
      local j =(i-n+1)%m
      if j==0 then j=m end
       new_tos[j]=p
    end
    data.tos = new_tos
  end,
})

-- szjethqeens:addEffect(fk.BeforeCardsMove, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     if not  player:hasSkill(szjethqeens.name)  then return end
--       for _, move in ipairs(data) do  --data MoveCards
--         if move.skillName=="ttis_tsiuh_szjet_jjen_skill" and  move.toArea == Card.DiscardPile then  
--           return true
--         end
--       end

--     end,
--   on_use = function(self, event, target, player, data)
--     if player.dead then return end
--     local cards={}  --直接改元迻動?
--     for _, move in ipairs(data) do  --data MoveCards
--       if move.skillName=="ttis_tsiuh_szjet_jjen_skill" and  move.toArea == Card.DiscardPile then  
--           for _, info in ipairs(move.moveInfo) do
--             table.insert(cards,info)
--           end
--       end
--     end
--     player.room:cancelMove(data,cards)  --无旹機 待定
--     player.room:moveCardTo(cards, Card.PlayerHand,player, fk.ReasonPrey, szjethqeens.name, nil, true, player)  --fk.ReasonPrey ?
-- end,
-- })

return szjethqeens

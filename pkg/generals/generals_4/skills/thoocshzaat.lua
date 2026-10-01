
local thoocshzaat = fk.CreateSkill {
  name = "thoocshzaat",
}

Fk:loadTranslationTable{
  ["thoocshzaat"] = "統轄",
  [":thoocshzaat"] = "伱額定抽牌後伱可發動,伱抽3,連續3次,伱將1牌交予1脚色,若爲軍器牌則置入裝僃欄,𠟇餘牌元敘置于牌堆頂",

  ["#thoocshzaat-invoke"] = "統轄 令 %src 發動",
  ["thoocshzaat-choose"] = "統轄",
}

-- local spec ={
  
--   on_use = function(self, event, target, player, data)
--     if target~=player then  data.phase_end = true  end

--     local room = player.room
--     local all = room:getNCards(3+#room.alive_players)

--       room.logic:getCurrentEvent():addCleaner(function()
--         local cards=table.filter(all,function(id) return room:getCardArea(id)==Card.Processing end)
--         if #cards>0 then
--         room:cleanProcessingArea(cards, thoocshzaat.name)
--         end
--       end)

--     room:moveCards({  --放回
--       ids = all,
--       toArea = Card.Processing,
--       moveReason = fk.ReasonPut,
--       skillName = thoocshzaat.name,
--       proposer = player,
--     })
--           --
--     -- for _, p in ipairs(room.players) do
--     --   room:fillAG(p, cards)
--     -- end


--     for i = 1, 3, 1 do
--       if player.dead then
--         break
--       end
--       local cards=table.filter(all,function(id) return room:getCardArea(id)==Card.Processing end)
--       if #cards==0 then return end

--       local to, chosen = room:askToChooseCardsAndPlayers(player, {
--         min_num = 0,  --不選脚色則爲自己
--         max_num = 1,
--         min_card_num = 1,
--         max_card_num = 1,
--         targets = room.alive_players,
--         pattern = tostring(Exppattern{ id = cards }),
--         skill_name = thoocshzaat.name,
--         prompt = "#thoocshzaat-give",
--         cancelable = false,
--         expand_pile = cards,  --額外牌 遺計所觀看牌
--       })

--       if  #to==0 then table.insert(to,player) end --不選脚色則爲自己
--       -- room:takeAG(to, chosen, room.players)
--       -- table.insert(AGResult, {to.id, chosen})
--       if Fk:getCardById(chosen[1]).type == Card.TypeEquip then
--         room:moveCardIntoEquip(to[1], chosen, thoocshzaat.name, true, player)  --player.id?
--         -- to[1]:drawCards(1,thoocshzaat.name)
--         -- room:changeShield(to[1],1)
--       else --置入moveCardTo(card, to_place, target, reason, skill_name, special_name, visible, proposer, moveMark, visiblePlayers)
--         room:moveCardTo(chosen, Card.PlayerHand, to[1], fk.ReasonGive, thoocshzaat.name, nil, true, player.id)
--       end
--       -- table.removeOne(cards, chosen[1])  --list
--       -- room:takeAG(to[1], chosen[1])
--     end  --給牌


--     -- for _, p in ipairs(room.players) do
--     --     room:closeAG(p)
--     -- end
--       local cards=table.filter(all,function(id) return room:getCardArea(id)==Card.Processing end)
--       if #cards>0 then
--         room:moveCards({  --放回
--           ids = table.reverse(cards),
--           toArea = Card.DrawPile,
--           moveReason = fk.ReasonPut,
--           skillName = thoocshzaat.name,
--           proposer = player,
--         })
--       end
--   end
-- }


local spec ={
  
  on_use = function(self, event, target, player, data)
    if target~=player then  data.phase_end = true  end

    local room = player.room

    player:drawCards(3,thoocshzaat.name)

    for i = 1, 3, 1 do
      if player.dead or player:isNude() then
        return
      end

      local to, chosen = room:askToChooseCardsAndPlayers(player, {
        min_num = 1,
        max_num = 1,
        min_card_num = 1,
        max_card_num = 1,
        targets = room.alive_players,
        pattern = ".",
        include_equip=true,
        skill_name = thoocshzaat.name,
        prompt = "#thoocshzaat-give",
        cancelable = true,
      })

      if  #to==0 then return end 
      if Fk:getCardById(chosen[1]).type == Card.TypeEquip then
        room:moveCardIntoEquip(to[1], chosen, thoocshzaat.name, true, player)  --player.id?
      else
                room:moveCardTo(chosen, Card.PlayerHand, to[1], fk.ReasonGive, thoocshzaat.name, nil, true, player.id)
      end
    end 

  end
}
thoocshzaat:addEffect(fk.AfterDrawNCards, {  --EventPhaseStart
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(thoocshzaat.name)
    --  and player.phase == Player.Draw and not data.phase_end
  end,
  on_use=spec.on_use,
})

thoocshzaat:addEffect(fk.DrawNCards, {  --EventPhaseStart
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target ~=player and player:hasSkill(thoocshzaat.name)
    --  and player.phase == Player.Draw and not data.phase_end
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(target, { skill_name = thoocshzaat.name,prompt="#thoocshzaat-invoke:"..player.id })
    and player.room:askToSkillInvoke(player, { skill_name = thoocshzaat.name })
  end,
  on_use=spec.on_use,
})
return thoocshzaat


local cardSkill = fk.CreateSkill {
  name = "deep_skill",
}



-- local loos = {
--   can_refresh = function(self, event, target, player, data)
--     card = {}
--     for _, i in data.cards
--    if i.name == "deep"
--    table.insert(cards,i)
--   end 
--   if #cards~=0
--    event.setCostData({cards = card})
--    return #true
--   end,
--   on_refresh = function(self, event, target, player, data)
--     for _, s in  event.getCostData(self).cards
--       card = Fk:getCardById(s)
--     if  player.dead then return

--     if  card.suit = Card.Spade  then --1
--               player.room:LoseHp({
--             player = event.who,
--             num = 1,
--             skillName = "deep",
--             })
--     elseif card.suit = Card.Club then 
--           player.room:damage({
--             from = event.who,
--             to = event.who,
--             card = card,  --
--             damage = 1,
--             damageType = fk.ThunderDamage,
--             skillName = "deep",
--             })

--     elseif  card.suit = Card.Heart then 
--           player.room:damage({
--             from = event.who,
--             to = event.who,
--             card = card,  --
--             damage = 1,
--             damageType = fk.FireDamage,
--             skillName = "deep",
--             })
--     elseif  card.suit = Card.Diamond then 
--           player.room:damage({
--             from = event.who,
--             to = event.who,
--             card = card,  --
--             damage = 1,
--             damageType = fk.NormalDamageDamage,
--             skillName = "deep",
--             })

--     end 
--   end,
-- }

--增加全局規則 若僞信亮出或正置離開區域 生效
-- --- 未知区域
-- Card.Unknown = 0
-- --- 手牌区
-- Card.PlayerHand = 1
-- --- 装备区
-- Card.PlayerEquip = 2
-- --- 判定区
-- Card.PlayerJudge = 3
-- --- 武将牌上/旁
-- Card.PlayerSpecial = 4
-- --- 处理区
-- Card.Processing = 5
-- --- 牌堆
-- Card.DrawPile = 6
-- --- 弃牌堆
-- Card.DiscardPile = 7
-- --- 移出游戏区
-- Card.Void = 8

cardSkill:addEffect(fk.AfterCardsMove, {
  priority=0,
  global = true,
  can_trigger = function(self, event, target, player, data)
      local ids = {}
      for _, move in ipairs(data) do  --data move info
        if  move.from  
          and move.from == player 
          and (--player:cardVisible(id)
            move.moveVisible==true 
            -- or (visiblePlayers and #move.visiblePlayers>0 )
            or (
              move.moveVisible~=false 
            and table.contains({Card.DiscardPile,Card.Processing,Card.PlayerEquip,Card.PlayerJudge},move.toArea) 
          ))
        then --問player  
          for _, info in ipairs(move.moveInfo) do
            if  (Fk:getCardById(info.cardId).trueName == "deep" or Fk:getCardById(info.cardId,true).trueName == "deep" )
            and info.fromArea == Card.PlayerHand 

            then
              table.insertIfNeed(ids, info.cardId)
            end
          end
        end
      end
    if #ids>0 then
      event:setCostData(self, {ids = ids})
      return true
    end
  end,
  on_trigger= function(self, event, target, player, data)
    local hp=function(card,player)

        if  card.suit == Card.Spade  then --1
                player.room:loseHp(player,1,cardSkill.name,player)
        elseif card.suit == Card.Club   then
                player.room:damage({
                    from = player,
                    to = player,
                    card = card,  --是否使用
                    damage = 1,
                    damageType = fk.ThunderDamage,
                    skillName = "deep_skill",
                })

        elseif  card.suit == Card.Heart  then
                    player.room:damage({
                    from = player,
                    to = player,
                    card = card,  --
                    damage = 1,
                    damageType = fk.FireDamage,
                    skillName = "deep_skill",
                    })
        elseif  card.suit == Card.Diamond  then
                    player.room:damage({
                    from = player,
                    to = player,
                    card = card,  --
                    damage = 1,
                    damageType = fk.NormalDamageDamage,
                    skillName = "deep_skill",
                    })
        end
    end
    
    local room=player.room
    local card 
    local ids=event:getCostData(self).ids
    while true do
      if #ids==1 then
        card=Fk:getCardById(ids[1])
        ids=nil
            hp(card,player)
        return
      -- else
      --    card =player:askToCard
      else
        local id = room:askToCards(player, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = cardSkill.name,
          pattern = tostring(Exppattern{ id = ids }),
          prompt = "#cardSkill-choose::",
          expand_pile = ids,
        })[1]
        card=Fk:getCardById(id)
        table.removeOne(ids,id)
        hp(card,player)
      end
    end

end,
})

cardSkill:addEffect(fk.CardShown, {
  priority=0,
  global = true,
  can_trigger = function(self, event, target, player, data)
    if player.seat~=1 then return end
    local cards = {}
    for _, id in ipairs(data.cardIds) do
      if Fk:getCardById(id).trueName == "deep" and player.room:getCardArea(id)==Card.PlayerHand then
        local p =player.room:getCardOwner(id)
        if p then
          local pid =p.id
          cards[pid]=cards[pid] or {}
          table.insert(cards[pid],id)
        end
      end
    end 
    if #cards~=0 then
      event:setCostData(self,{cards = cards})
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    -- player = event.getCostData(self).cards.from
    local cards=event:getCostData(self).cards

      for pid, ids in ipairs(cards) do
        local p =room:getPlayerById(pid)
        room:throwCard(ids, cardSkill.name, p, p) --同旹展示?
      end
  end,
})

 --自暴  CardsMove
cardSkill:addEffect("cardskill", {
  prompt = "#deep_use",
  target_num = 0,
})
return cardSkill

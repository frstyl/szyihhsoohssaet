local liocqdzjem = fk.CreateSkill{
  name = "liocqdzjem",
}

Fk:loadTranslationTable{
  ["liocqdzjem"] = "龍濳",
  [":liocqdzjem"] = "一角色成爲錦囊目幖旹,若伱至其距離不大于1,伱可發動.其与伱各抽1,肰後其選1手牌置于牌堆頂",

  ["#liocqdzjem-ask"] = "龍濳 是否對 %src 發動",
  ["#liocqdzjem-choose"] = "龍濳 選擇1手牌",

  ["$liocqdzjem1"] = "且慢",  --
  -- ["$liocqdzjem1"] = "慢著,不要輕動",  --
  ["$liocqdzjem2"] = "待俺尋思尋思",
  ["$liocqdzjem3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


-- Fk:addPoxiMethod{
--   name = "liocqdzjem_discard",
--   prompt = "#liocqdzjem-ask",
--   card_filter = function(to_select, selected, data)

--     return not (Self:prohibitResponse(Fk:getCardById(to_select)) and table.contains(data[1][2], to_select))
--   end,
--   feasible = function(selected)
--     return #selected == 1
--   end,
-- }
liocqdzjem:addEffect(fk.TargetConfirming, {  --TargetSpecifying TargetConfirming
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return 
    player:hasSkill(liocqdzjem.name) --
    and player:compareDistance(data.to,1,"<=")
    and S.getCardTypeByName(data.card.name)==2
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=liocqdzjem.name,
      prompt="#liocqdzjem-ask:"..data.to.id
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if not data.to.dead then 
    data.to:drawCards(1,liocqdzjem.name)
    end
    if not player.dead then 
    player:drawCards(1,liocqdzjem.name)
    end
    
    -- if player.dead then return end
    if data.to:isNude() then return end
    local  cards  = room:askToCards(data.to, {
      min_num = 1,
      max_num = 1,
      include_equip = false,
      prompt = "#liocqdzjem-choose",
      skill_name = liocqdzjem.name,
      cancelable = false,
    })
    if #cards>0 then
      room:moveCards({
        ids = cards,
        from = data.to,
        fromArea = Card.PlayerHand,
        toArea = Card.DrawPile,
            -- drawPilePosition = drawPilePosition,
        moveReason = fk.ReasonPut,
        skillName = liocqdzjem.name,
        proposer = data.to,
      })  
    end

    -- if data.to==player then 
    --   cards = room:askToCards(player, {
    --   min_num = 1,
    --   max_num = 1,
    --   include_equip = false,
    --   prompt = "#liocqdzjem-choose",
    --   skill_name = liocqdzjem.name,
    --   cancelable = false,
    -- })
    -- else
    
    --   if player:isNude() and data.to:isNude() then return end

    --   local targetCards=data.to:getCardIds("h") 

    --   local cards_data={
    --       { player.general, player:getCardIds("h") },
    --       -- { player.general, player:getCardIds("e") },
    --       { data.to.general, targetCards},
    --       -- { data.to.general, data.to:getCardIds("e") },
    --   }

    --   local data = {
    --   to = data.to.id,
    --   min = 1,
    --   max = 1,
    --   skillName = liocqdzjem.name,
    --   prompt = ".",
    --   -- pattern = ".",
    --   visible_data={}
    -- }
    -- local visible_data = {}
    --     for _, id in ipairs(targetCards) do
    --       if not player:cardVisible(id) then
    --         visible_data[tostring(id)] = false
    --       end
    --     end
    --   data.visible_data = visible_data
    -- cards = room:askToPoxi(player, {
    --   poxi_type = "AskForCardsChosen",
    --   data = cards_data,
    --   extra_data = data,
    --   cancelable = false,
    --   })
    -- end


    -- if #cards>0 then
    --   room:moveCards({
    --     ids = cards,
    --     from = room:getCardOwner(cards[1]),
    --     fromArea = Card.PlayerHand,
    --     toArea = Card.DrawPile,
    --         -- drawPilePosition = drawPilePosition,
    --     moveReason = fk.ReasonPut,
    --     skillName = liocqdzjem.name,
    --     proposer = player,
    --   })  
    -- end

  end,
})



return liocqdzjem

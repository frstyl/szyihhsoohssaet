local liocqdzjem = fk.CreateSkill{
  name = "liocqdzjem",
}

Fk:loadTranslationTable{
  ["liocqdzjem"] = "龍濳",
  [":liocqdzjem"] = "一脚色A成爲起動目幖旹(每次起動限1次),若爲計謀牌且伱至A距離不大于1,伱可➀發動.A与伱各抽1,A選1手牌置于牌堆頂➁迻除此目幖發動,伱弃置1手牌",

  ["#liocqdzjem-ask"] = "龍濳 是否對 %src 發動",
  ["#liocqdzjem-choose"] = "龍濳 選擇1手牌",

  ["liocqdzjem-draw"] = "其伱各抽1",
  ["liocqdzjem-defensive"] = "迻除目幖",

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
    and not (data.extra_data and data.extra_data.liocqdzjem and table.contains(data.extra_data.liocqdzjem,player.id))
  end,
  on_cost = function(self, event, target, player, data)
    local all={"liocqdzjem-draw","liocqdzjem-defensive","Cancel"}

    local choice = player.room:askToChoice(player,{
        cancelable=false,
        choices= data.cancelled and {"liocqdzjem-draw"} or all,
        all_choices=all,
        cancelable=true,
        prompt="#liocqdzjem-ask:"..data.to.id
        })
    if choice~="Cancel" then
      event:setCostData(self,{tos={data.to},choice=choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.extra_data = data.extra_data  or {}
    data.extra_data.liocqdzjem= data.extra_data.liocqdzjem or {}
    table.insert(data.extra_data.liocqdzjem,player.id) 
    if not event:getCostData(self) or event:getCostData(self).choice=="liocqdzjem-defensive" then
      data:cancelTarget(data.to)
      if not player:isKongcheng() then
        room:askToDiscard(player, {
          min_num = 1,
          max_num = 1,
          include_equip = false,
          skill_name = liocqdzjem.name,
          cancelable = false,
          skip = false,
        })
      end
      return 
    end

    if not data.to.dead then 
    data.to:drawCards(1,liocqdzjem.name)
    end
    if not player.dead then 
    player:drawCards(1,liocqdzjem.name)
    end

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

local tsoeojssi = fk.CreateSkill{
  name = "tsoeojssi",
  tags={Skill.Compulsory},
  derived_piles = "tsoeojssi_si",
}

Fk:loadTranslationTable{
  ["tsoeojssi"] = "再思",
  [":tsoeojssi"] = "伱得到初始手牌後/不因此技能{得/失}牌後,必發,伱將牌堆頂x牌置于伱將牌上/伱隨機廢置x｢再思｣牌｡x爲{得/失}牌數｡印牌:廢除1手牌起動1再思牌",

  ["#tsoeojssi-recover"] = "再思：選擇目幖,令其回1",
  ["#tsoeojssi-card"] = "再思：選擇至多 %arg 牌交予其它脚色",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

tsoeojssi:addEffect("viewas", {
  -- anim_type = "control",
  pattern = ".", --无目幖牌
  expand_pile = "tsoeojssi_si",
  handly_pile=false,
  card_filter = function(self, player, to_select, selected)
    return (#selected == 0 and table.contains(player:getPile("tsoeojssi_si"), to_select))
     or 
  (#selected == 1 and not table.contains(player:getPile("tsoeojssi_si"), to_select))
  end,
  view_as = function(self, player, cards)
    if #cards ~= 2 then return end
    local card = Fk:getCardById(cards[1])
    card:addFakeSubcard(cards[2])
    return card
  end,
  before_use = function(self, player, use)
    -- local cards=player.room:askToCards(player, {
    --   min_num = 1,
    --   max_num = 1,
    --   skill_name = tsoeojssi.name,
    --   -- pattern = ".",
    --   prompt = "#tsoeojssi-ask",
    --   cancelable = false,
    --   include_equip=false,
    -- })
    -- if #cards > 0 then
    local cards=use.card.fake_subcards --說到底 不對
    -- if table.contains(player:getCardIds("h"),cards[1]) then
      player.room:moveCardTo(cards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tsoeojssi.name, nil, true, player)
    -- end
  end,
  enabled_at_play = function (self, player)
    return  not player:isKongcheng()
  end,
  enabled_at_response = function (self, player, response)
    return not response and not player:isKongcheng()
  end,
  enabled_at_nullification = function (self, player, cardEffectData)
    if #player:getPile("tsoeojssi_si")==0 then return end
    if Fk.currentResponsePattern==nil then return true end

    for _, id in ipairs(player:getPile("tsoeojssi_si")) do
      if Exppattern:Parse(Fk.currentResponsePattern):match(Fk:getCardById(id))  then return true end
    end
    
  end,
})

tsoeojssi:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(tsoeojssi.name) then return end

      local n = 0
      local m = 0
      for _, move in ipairs(data) do
        if move.skillName== tsoeojssi.name then return end
        if move.to == player and table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)  then

          for _, info in ipairs(move.moveInfo) do
            if not (move.from==player and table.contains({Card.PlayerEquip,Card.PlayerHand }, info.fromArea) ) then
              n=n+1
            end
          end
        elseif  move.to ~= player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea) then
          for _, info in ipairs(move.moveInfo) do
            if  (move.from==player and table.contains({Card.PlayerEquip,Card.PlayerHand }, info.fromArea) ) then
              m=m+1
            end
          end
        end
      end
        
      if n>0 or m>0 then
        event:setCostData(self,{n=n,m=m})
        return true 
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if event:getCostData(self).n>0 then
      player:addToPile("tsoeojssi_si", room:getNCards(event:getCostData(self).n), false, tsoeojssi.name) 
    end
    if player.dead then return end
    local m = event:getCostData(self).m
    if m>0 then
      local ids ={}
      if m<#player:getPile("tsoeojssi_si") then
        ids = room:tableRandomPick(player:getPile("tsoeojssi_si"))
      else
        ids = player:getPile("tsoeojssi_si")
      end
      player.room:moveCardTo(ids, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, tsoeojssi.name, nil, true, player)
    end
  end,
})

tsoeojssi:addEffect(fk.AfterDrawInitialCards, {
  anim_type = "drawcard",
  on_use = function(self, event, target, player, data)
    local room = player.room
    player:addToPile("tsoeojssi_si", room:getNCards(data.num), false, tsoeojssi.name) 

  end,
})

return tsoeojssi

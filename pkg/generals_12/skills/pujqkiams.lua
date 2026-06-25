local pujqkiams = fk.CreateSkill {
  name = "pujqkiams",
}

Fk:loadTranslationTable{
  ["pujqkiams"] = "飛劍",
  [":pujqkiams"] = "當殺不因使用打出進入弃牌堆後(不需仍在弃牌堆),你可以預打出手牌与此殺不同色者發動,伱虛擬使用此殺(无視距離次數且不可響應,)。",

  ["#pujqkiams-choose"] = "飛劍 選擇所用殺与所弃牌",

  ["$pujqkiams1"] = "百步之內,取汝性命",
  ["$pujqkiams2"] = "著我玄天混元飛劍",
  ["$pujqkiams3"] = "飛劍破空",
}

-- local U = require "packages/utility/utility"
-- pujqkiams: addAcquireEffect(function (self, player)
--   local t=player.room:getBanner(pujqkiams.name) or {}
--   table.insertIfNeed(t,player.id)
--   player.room:setBanner(pujqkiams.name,t) 
-- end)

-- pujqkiams:addLoseEffect(function (self, player) 
--   local t=player.room:getBanner(pujqkiams.name) or {}
--   table.remove(t,player.id)
--   player.room:setBanner(pujqkiams.name,t) 
-- end)

pujqkiams:addEffect(fk.AfterCardsMove, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)  --每个player 緟數ids? 

    -- if  not player:hasSkill(pujqkiams.name) 
    -- or  player:isKongcheng() 
    -- then return end

    if  event:getCostData(self)==nil --or  event:getCostData(self).ids==nil 
    
    then  --skill在牌局 多角色共用訊?

      local ids = {}
      local t=table.map(player.room.alive_players,Util.IdMapper)
      -- local from
      local used={}
      for _, move in ipairs(data) do  --data move info


        if 
        move.moveReason ~= fk.ReasonUse and move.moveReason ~= fk.ReasonResponse
          and 
           move.toArea == Card.DiscardPile  --元 Area不爲 DiscardPile
        then  

          -- if #t==0 then return  end --中途得技能?
          -- from=move.from.id
          for _,id in ipairs(t) do
            used[id]={}
          end

          -- if move.from~=nil then
          --   used[move.from.id]=nil
          -- elseif move.moveReason ~= fk.ReasonResponse then
          --   local response_event = player.room.logic:getCurrentEvent():findParent(GameEvent.Response)
          --   if response_event and response_event.data.from  then
          --   used[response_event.data.from.id]=nil
          --   end
          -- end

          for _, info in ipairs(move.moveInfo) do
            if  Fk:getCardById(info.cardId).trueName == "ssaet" then
            -- and  (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip) 
              table.insertIfNeed(ids, info.cardId)
            end
          end

        end

      end
      if #ids>0 then
        event:setCostData(self, { ids = ids})
      else
        event:setCostData(self, {ids=nil})
      end
    end

    if event:getCostData(self).ids==nil then return end
    if (event:getCostData(self).used 
      and #event:getCostData(self).used  >= #event:getCostData(self).ids) then
      event:setCostData(self, { ids = event:getCostData(self).ids})
    else
      return    
        player:hasSkill(pujqkiams.name) 
        and not  player:isKongcheng() 
    end
        

  end,
  trigger_times = function(self, event, target, player, data)  ---回合內不觸發
    return 999  --發動次數需手動實現
  end,
  on_cost = function(self, event, target, player, data)
      -- if player:isKongcheng() then return end

      local room = player.room
      local ids=event:getCostData(self).ids
      -- ids = table.filter(ids, function (id)
      --   return table.contains(player.room.discard_pile, id)
      -- end)
      -- ids = player.room.logic:moveCardsHoldingAreaCheck(ids)

      local used = event:getCostData(self).used or {}

      local temp ={}
      for _, id in ipairs(ids) do
        if not table.contains(used,id) then
          table.insert(temp,id)
        end
      end
      -- if #temp==0 then event:setCostData(self, {ids=ids}) return end

      local yes, dat = room:askToUseActiveSkill(player, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "pujqkiams_active",
      prompt = "#pujqkiams-choose",
      cancelable = true,
      skip = true,  --不執行
      extra_data = {
        expand_pile = temp,
        skillName = pujqkiams.name,
      },
      --  = {ids=ids},
    })
    if yes and dat then
      -- table.remove(ids, table.indexOf(ids, dat.cards[1]))

      table.insert(used, dat.cards[1])
      event:setCostData(self, { ids=ids,used=used, cards = dat.cards, tos = dat.targets})  --需tos目幖發動
      return true
    else
      event:setCostData(self, {ids=ids}) 
    end

    	-- self.cancel_cost = true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- room:throwCard(event:getCostData(self).cards[2], pujqkiams.name, player, player)
    local tos =event:getCostData(self).tos
    room:responseCard({
      from=player,
      card=Fk:getCardById(event:getCostData(self).cards[2]),
      -- responseToEvent=,
      -- skipDrop=,
      -- customFrom=,
      attachedSkillAndUser={
        muteCard=true,
      },
    })

    local cards=Fk:getCardById(event:getCostData(self).cards[1])
    local card = Fk:cloneCard(cards.name, cards.suit, cards.number)  --虛牌鎖无色?
    card.color=cards.color
    card.skillName = pujqkiams.name
    -- card:addFakeSubcard(cards)
    if not  player:canUseTo(card, tos[1], {bypass_distances = true, bypass_times = true}) then return end

    room:useCard{  --bypase times
      from = player,
      tos = tos,
      card = card,
      disresponsiveList = table.simpleClone(room.players),
      extraUse=true,
    }

    -- local ids=event:getCostData(self).ids
    -- table.remove(ids, table.indexOf(ids, cards.id))
    -- event:setCostData(self, {ids=ids})
end,
})

return pujqkiams

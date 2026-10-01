local doavqthoav = fk.CreateSkill{
  name = "doavqthoav",
}

Fk:loadTranslationTable{
  ["doavqthoav"] = "濤洮", --淘
  [":doavqthoav"] = "伱受傷後/伱伏段始旹,伱可選1至x脚色發動｡伱同旹弃置所選脚色各1牌｡",

  ["#doavqthoav-invoke"] = "濤洮：選擇目幖 弃置其牌 ",

  ["doavqthoav_poxi"] = "選擇不同區域牌",

  -- ["#doavqthoav_1"] = "%dest手牌",
  -- ["#doavqthoav_2"] = "%dest裝僃",
  -- ["#doavqthoav_3"] = "%dest伏區",

  ["$doavqthoav1"] = "",
}

Fk:addPoxiMethod{
  name = "doavqthoav_poxi",
  prompt = function (data, extra_data)
    if extra_data then
      if extra_data.prompt then return extra_data.prompt end
      if extra_data.skillName and extra_data.to then
        return "#doavqthoav_poxi::"..extra_data.to..":"..extra_data.skillName
      end
    end
    return "doavqthoav_poxi"
  end,
  card_filter = function (to_select, selected, data, extra_data)
    if extra_data and extra_data.max and #selected>=extra_data.max then return false end
    if data and #selected < #data then
      for _, id in ipairs(selected) do
        for _, v in ipairs(data) do
          if table.contains(v[2], id) and table.contains(v[2], to_select) then
            return false
          end
        end
      end
      return true
    end
  end,
  feasible = function(selected, data)
    return #selected>0
  end,
  default_choice = function(data)
    if not data then return {} end
    local cids = table.map(data, function(v) return v[2][1] end)
    return cids
  end,
}

local spec={
  on_cost = function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
        min_num = 1,
        max_num = math.max(1,player:getLostHp()),
        targets = player.room.alive_players,
        -- targets = player.room:getOtherPlayers(player),
        skill_name = doavqthoav.name,
        prompt = "#doavqthoav-invoke",
        cancelable = true,
      })
      if #tos==0 then  return end
        event:setCostData(self,{tos=tos})
        return true 
      
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    -- local tos=event:getCostData(self).tos
    -- local moveInfos={}
    -- for _, p in ipairs(tos) do
    --   if player.dead then return end
    --   if not p:isNude() then
    --     local id = room:askToChooseCard(player, {
    --       target = p,
    --       skill_name = doavqthoav.name,
    --       flag = "he",
    --     })
    --     table.insert(moveInfos, {
    --       from = p.id,
    --       ids = {id},
    --       toArea = Card.DiscardPile,
    --       moveReason = fk.ReasonDiscard,
    --       proposer = player,
    --       skillName = doavqthoav.name,
    --     })
    --     -- room:throwCard(id, doavqthoav.name, p, player)
    --   end
    -- end
    local tos=event:getCostData(self).tos
      local data = {
        skillName =  doavqthoav.name,
        prompt = "doavqthoav_poxi",
      }
      local visible_data = {}
      local card_data={}
      for _, p in ipairs(tos) do
        for i=1,3,1 do
          local ids = p:getCardIds({i})
          if #ids>0 then
            -- local prompt="#doavqthoav_"..tostring(i).."::"..p.id
            local prompt=i==1 and "$Hand" or i==2 and "$Equip" or "$Judge"
            table.insert(card_data, {prompt, ids})
            if not player:cardVisible(id) then
              visible_data[tostring(id)] = false
            end
          end
        end
      end

      if #card_data == 0 then return {} end

    local cards = room:askToPoxi(player, {
      poxi_type ="doavqthoav_poxi",
      data = card_data,
      extra_data = data,
      cancelable = true,
      extra_data={
        min=1,
        max=math.max(1,player:getLostHp()),
      }
    })

    room:moveCardTo(cards,Card.DiscardPile,nil,fk.ReasonDiscard,doavqthoav.name)
    -- room:moveCards(table.unpack(moveInfos))
  end,
}

doavqthoav:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(doavqthoav.name) and player.phase == Player.Judge
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})
doavqthoav:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(doavqthoav.name)
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})
return doavqthoav

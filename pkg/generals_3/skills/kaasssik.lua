local kaasssik = fk.CreateSkill {
  name = "kaasssik",
}

Fk:loadTranslationTable{
  ["kaasssik"] = "稼穡",
  [":kaasssik"] = "➀隱祕.主旹任意次,伱可葢伏1手牌➁伱伏段始旹任意次,伱可將伱葢伏牌轉化爲「糧艸先行」使用發動,可指定任一角色爲目幖,且若元牌爲「肉/酒」,抽牌數+1.", --被龍傲刻  --至多體力上限次? 改成流程不計次數?

  ["#kaasssik-invoke"] = "稼穡  將葢伏牌轉化爲 糧艸先行 對 任一角色 使用",

  ["$kaasssik1"] = "沒有耕耘若來收穫",
  ["$kaasssik2"] = "一粒種子就是一个萅天",
  ["$kaasssik3"] = "好一片麥田",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


kaasssik:addAcquireEffect(function (self, player)
  -- player.room:handleAddLoseSkills(player, "koarbiuk_active&", nil, false, true)
  S.handleAddLoseVirtualSkills(player, "koarbiuk_active&", "kaasssik", false, true)
end)

kaasssik:addLoseEffect (function (self, player)
  -- player.room:handleAddLoseSkills(player, "-koarbiuk_active&", nil, false, true)  --其它 tag?
  S.handleAddLoseVirtualSkills(player, "-koarbiuk_active&", "kaasssik", false, true)
end)


kaasssik:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return  target==player     and player:hasSkill(kaasssik.name)  
    and player.phase==Player.Judge
    -- and #S.getPlayerKoarbiukCards({player}) > 0
    and #S.getPlayerKoarbiukCards({player}) >0
  end,
  on_trigger= function(self, event, target, player, data)
      local yes, dat = player.room:askToUseActiveSkill(player, {
      skill_name = "kaasssik_active",
      prompt = "#kaasssik-invoke",
      cancelable = true,
      skip = true,  --不執行
      extra_data = {
        expand_pile = S.getPlayerKoarbiukCards({player}),
        skillName = kaasssik.name,
      },
      })
      if not yes or not  dat then return end
      for _, id in ipairs(dat.cards) do
        if player.dead then break end
        local to =dat.targets[1] or player
        if to.dead then break end
        local card=Fk:cloneCard("liac_tshoavh_seen_hzaac") 
        card:addSubcard(id)
        card.skillName = kaasssik.name
        if player:canUseTo(card,to) then
          local use ={
            from = player,
            tos = {to},
            card = card,
            extraUse=true,
          }        
        event:setCostData(self, {use=use,tos={to}})
        self:doCost(event, target, player, data)
          -- return true
        end
      end

  end,
  trigger_times= function(self, event, target, player, data)
    return 999
  end,
  -- trigger_times= function(self, event, target, player, data)
  --   if event:getCostData(self) and event:getCostData(self).n then
  --     return event:getCostData(self).n 
  --   else 
  --     event:setCostData(self,{n=#S.getPlayerKoarbiukCards({player})})
  --     return #S.getPlayerKoarbiukCards({player})
  --   end
  -- end,

  on_cost = function(self, event, target, player, data)
    if event:getCostData(self)then
        return true
    end
  --   local room = player.room
  --   local koarbiukcards=S.getPlayerKoarbiukCards({player})

  --       local use = room:askToUseVirtualCard(player, {
  --         name="liac_tshoavh_seen_hzaac",
  --         expand_pile=koarbiukcards,
  --         -- card_filter={
  --         --   n=1,
  --         --   pattern = tostring(Exppattern{ id = koarbiukcards }),
  --         -- },
  --         skill_name = kaasssik.name,
  --         prompt = "#kaasssik-invoke",
  --         cancelable=true,
  --         skip=true,
  --       })

  --   if use then
  --       event:setCostData(self, {use=use,tos=use.tos})
  --       return true
  --   end

  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    -- room:useVirtualCard("liac_tshoavh_seen_hzaac", event:getCostData(self).cards, player, event:getCostData(self).tos, kaasssik.name, true)
    room:useCard(event:getCostData(self).use)
    -- while 1 do
    --   local koarbiukcards=S.getPlayerKoarbiukCards({player})
    --   if #koarbiukcards==0 then return end
    --   local tos, cards = room:askToChooseCardsAndPlayers(player, {
    --     min_num = 1,
    --     max_num = 2,
    --     min_card_num = 1,
    --     max_card_num = 1,
    --     targets = room.alive_players,
    --     pattern = tostring(Exppattern{ id = koarbiukcards}),
    --     skill_name = kaasssik.name,
    --     prompt = "#kaasssik-invoke",
    --     cancelable = true,
    --     will_throw = true,
    --     expand_pile=koarbiukcards,
    --   })
    --   if #tos>0 and #cards>0 then
    --     room:useVirtualCard("liac_tshoavh_seen_hzaac", cards, player, tos, kaasssik.name, true)
    --   end
    -- end
  end,
})

kaasssik:addEffect(fk.BeforeDrawCard, {
  priority = 0.001,
  can_refresh = function(self, event, target, player, data)
    if target == player and data.skillName == "liac_tshoavh_seen_hzaac_skill" then
      local use_event = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
      if use_event then
        local use = use_event.data
        if not  table.contains(use.card.skillNames, kaasssik.name) then return end
        local  cid = Card:getIdList(use.card)
        return cid and table.contains({"nziuk","tsiuh"} , Fk:getCardById(cid[1]).trueName)
      end
    end
  end,
  on_refresh = function(self, event, target, player, data)
    data.num = data.num + 1
  end,
})
return kaasssik

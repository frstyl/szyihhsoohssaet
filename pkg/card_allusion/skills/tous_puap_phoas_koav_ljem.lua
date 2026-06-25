local cardSkill = fk.CreateSkill {
  name = "tous_puap_phoas_koav_ljem_skill",
}
-- Fk:loadTranslationTable{
--   ["#touh_ttwenh_seec_jje"] = "斗轉星迻 以鬥法破高廉 交換%dest 之%arg判定牌",
--   ["#koav_doac_tous_puap"] = "选择一其他角色，伱予其1雷傷",
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#koav_doac_tous_puap",
  -- prompt = function(self, _, _, _, extra_data)
  --   return extra_data.touh_ttwenh_seec_jje and "#touh_ttwenh_seec_jje"  
  -- or "#koav_doac_tous_puap"  --extra?
  -- end,
  target_num=1,
  can_use = Util.FalseFunc,  --不能主動旹用
  mod_target_filter = function(self, player, to_select, selected, card,extra_data)
    return  to_select ~= player 
  end,
  target_filter = Util.CardTargetFilter,
  -- feasible=function(self,player,selected,selected_cards,extra_data)
  --   if not extra_data  then return false end
  --   if extra_data.koav_doac_tous_puap then return #selected==1 end
  --   if extra_data.touh_ttwenh_seec_jje then return #selected==0 end
  -- end,
  -- on_use = function (self, room, use)
  --   if use.extra_data and  use.extra_data.touh_ttwenh_seec_jje then
  --     use.tos={}
  --   use.toCard=use.card
  --   end
  -- end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.extra_data then return end
    if    effect.extra_data.koav_doac_tous_puap then
    room:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.ThunderDamage,
      skillName = cardSkill.name,
    })
    end
  end,
})




cardSkill:addEffect(fk.FinishJudge, {
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    if player.seat~=1 then return end
    if data.card and data.card.suit==Card.Spade then
      local players=S.getHolders("tous_puap_phoas_koav_ljem")  --如有多張止能用1?
      if  #players > 0  then
        event:setCostData(self,{players=players})
        return  true
      end

    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=target.room
    local params={
      skill_name = "koav_doac_tous_puap",
      pattern="tous_puap_phoas_koav_ljem",
      cancelable=true,
      prompt="#koav_doac_tous_puap",
      skip=true,
      extra_data = {
        koav_doac_tous_puap = true,
      }
    }
  local use = room:askToNullification(event:getCostData(self).players, params)  --選上家再選下家?

    if use then
      
      use.extra_data = use.extra_data or {}
      use.extra_data.koav_doac_tous_puap = true    
      player.room:useCard(use)
    end
  end,
})


cardSkill:addEffect(fk.AskForRetrial, {  --与技能同旹?--不屬使用 單純迻動
  global = true,
  can_trigger = function(self, event, target, player, data)
    if player.seat~=1 then return end
    local players=S.getHolders({"tous_puap_phoas_koav_ljem"}, nil,fk.ReasonExchange )
    if  #players>0 then
      event:setCostData(self,{players=players})
      return true
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local params={
      players=event:getCostData(self).players,
      skill_name = "touh_ttwenh_seec_jje",
      pattern="tous_puap_phoas_koav_ljem",
      cancelable=true,
      prompt="#touh_ttwenh_seec_jje::"..target.id..":"..data.reason,
      skip=true,
      min_num=1,
      max_num=1,
      include_equip=false,
      will_throw=false,
      -- extra_data = {
      --   touh_ttwenh_seec_jje = true,
      -- }
    }
    local p,newId = S.askToChooseCardExclusively(nil, params)  --彊化選擇req
    if not p or #newId~=1 then return end
    newId=newId[1]
    -- player.room:changeJudge{
    --   card = Fk:getCardById(cards[1]),
    --   player = player,
    --   data = data,
    --   skillName = "touh_ttwenh_seec_jje",
    --   response = false,
    --   exchange=true,
    -- }

    local moveInfos={}

    table.insert(moveInfos,{  --改判
      ids = {newId}, --id list
      from = p,
      toArea = Card.Processing,
      moveReason = fk.ReasonExchange,
      skillName = "touh_ttwenh_seec_jje",
      proposer = p,
    })

  
    table.insert(moveInfos,{---@type CardsMoveInfo
      ids = data.card:isVirtual() and data.card.subcards or { data.card.id },
      to =  p ,
      toArea =  Card.PlayerHand,
      moveReason =  fk.ReasonExchange,
      skillName = "touh_ttwenh_seec_jje",
      proposer = p,
    } )

    room:moveCards(table.unpack(moveInfos))

    room:sendLog{
      type = "#ChangedJudge",
      from = p.id,
      to = {data.who.id}, --判定者
      arg2 = Fk:getCardById(newId):toLogString(),  --改判用牌
      arg = "touh_ttwenh_seec_jje"
    }
    room:filterCard(newId, target, true)
    data.card = Fk:getCardById(newId)  --id

  end,
})
-- cardSkill:addEffect(fk.AskForRetrial, {  --与技能同旹 算使用?
--   global = true,
--   can_trigger = function(self, event, target, player, data)
--     return #table.filter(player:getCardIds("h"), 
--       function(id)
--         return Fk:getCardById(id).name == "tous_puap_phoas_koav_ljem"
--       end)>0
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room = player.room

--     local use = room:askToUseCard(player, {  --使用
--       skill_name = "touh_ttwenh_seec_jje",
--       pattern = "tous_puap_phoas_koav_ljem",
--       prompt = "#touh_ttwenh_seec_jje::"..target.id..":"..data.reason,
--       cancelable = true,
--       extra_data = {
--         touh_ttwenh_seec_jje = true,
--       }
--     })
--     if use then
--       use.extra_data = use.extra_data or {}
--       use.extra_data.touh_ttwenh_seec_jje = true    
--       use.extra_data.judgeData = data    
--       room:useCard(use)
--     end
--     -- local cards = room:askToCards(player, {
--     --   min_num = 1,
--     --   max_num = 1,
--     --   skill_name = cardSkill.name,
--     --   pattern = "tous_puap_phoas_koav_ljem",
--     --   prompt = "#cardSkill",
--     --   cancelable = true,
--     -- })
--     -- if cards then
--     -- player.room:changeJudge{
--     --   card = Fk:getCardById(cards[1]),
--     --   player = player,
--     --   data = data,
--     --   skillName = cardSkill.name,
--     --   response = false,
--     --   exchange=true,
--     -- }
--     -- end

--   end,
-- })


return cardSkill


    -- local players = {}
    -- Fk.currentResponsePattern = "buac_hzfan_mujs_nzjen"
    -- local cardCloned = Fk:cloneCard("buac_hzfan_mujs_nzjen")
    -- for _, p in ipairs(room.alive_players) do
    --   if not p:prohibitUse(cardCloned) then
    --     local cards = p:getHandlyIds()
    --     for _, cid in ipairs(cards) do
    --       if Fk:getCardById(cid).trueName == "buac_hzfan_mujs_nzjen" and
    --         (not (
    --           cardEffectData:isDisresponsive(p) or
    --           cardEffectData:isUnoffsetable(p)
    --         ))
    --       then
    --         table.insert(players, p)
    --         break
    --       end
    --     end
    --     if not table.contains(players, p) then
    --       Self = p -- for enabledAtResponse
    --       for _, s in ipairs(table.connect(p.player_skills, rawget(p, "_fake_skills"))) do
    --         ---@cast s ViewAsSkill
    --         if
    --           s.pattern and
    --           Exppattern:Parse("buac_hzfan_mujs_nzjen"):matchExp(s.pattern) and
    --           (s:enabledAtNullification(p, cardEffectData) or s:enabledAtResponse(p)) and
    --           (not (
    --             cardEffectData:isDisresponsive(p) or
    --             cardEffectData:isUnoffsetable(p)
    --           ))
    --         then
    --           table.insert(players, p)
    --           break
    --         end
    --       end
    --     end
    --   end
    -- end

    -- local prompt = ""
    -- if cardEffectData.to then
    --   prompt = "#AskForNullification::" .. cardEffectData.to.id .. ":" .. cardEffectData.card.name
    -- elseif cardEffectData.from then
    --   prompt = "#AskForNullificationWithoutTo:" .. cardEffectData.from.id .. "::" .. cardEffectData.card.name
    -- end

    -- local extra_data
    -- if #cardEffectData.tos > 1 then
    --   local parentUseEvent = room.logic:getCurrentEvent():findParent(GameEvent.UseCard)
    --   if parentUseEvent then
    --     extra_data = { useEventId = parentUseEvent.id, effectTo = cardEffectData.to.id }
    --   end
    -- end
    -- if #players > 0 and cardEffectData.card.trueName == "buac_hzfan_mujs_nzjen" then
    --   room:animDelay(2)
    -- end
    -- local params = { ---@type AskToUseCardParams
    --   skill_name = "buac_hzfan_mujs_nzjen",
    --   pattern = "buac_hzfan_mujs_nzjen",
    --   prompt = prompt,
    --   cancelable = true,
    --   extra_data = extra_data,
    --   event_data = cardEffectData
    -- }
    -- local use = room:askToNullification(players, params)
    -- if use then
    --   use.toCard = cardEffectData.card
    --   use.responseToEvent = cardEffectData
    --   room:useCard(use)
    -- end
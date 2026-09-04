local koarbiuk_rule = fk.CreateSkill {
  name = "koarbiuk_rule",
}

Fk:loadTranslationTable{
  ["#koarbiuk_rule"] = "葢伏",
  ["#koarbiuk-use"] = "伱預段 你可以起動伱葢伏牌",

  ["koarbiuk"] = "葢伏",

  ["@@koarbiuk-inarea"] = "葢伏",


  ["#phase_discard"] = "勶段 弃置 %arg 手牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

--𢧵階段
--EventPhaseStart
koarbiuk_rule:addEffect(fk.EventPhaseProceeding, {  --手牌可用之牌 葢牌何用
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    return player==target
    and table.contains({Player.Judge,Player.Discard, Player.Play}, data.phase )
  end,

  on_trigger = function(self, event, target, player, data)
    local room=player.room
    if data.phase ==Player.Judge then
      local cardNames ={"mae_biuk","thou_liac_hzvoans_dduoh","szyih_kouc"} 
      while true do
        if data.phase_end then return end

        local ids=S.getPlayerKoarbiukCards({target})
        if #ids==0 then break end
        local params={
          pattern = ids,
          skill_name = "koarbiuk_rule",  --提示
          prompt = "#koarbiuk-use",
          cancelable = true,
          expand_pile = ids,
          skill_name="koarbiuk",
          skip = true,
          -- event_data = data,
          extra_data = {
            -- exclusive_targets = {target.id},  --又用Id矣
            bypass_distances = true,  --葢伏特性
            bypass_times = false,
            extraUse = false,
            -- not_passive=false,
            koarbiuk_rule=true,
          }
        }

          Fk.currentResponseReason = "koarbiuk_rule"
          -- local use = S.askToUseKoarbiukCard(room, players,  params, nil, expand)  --不同脚色不同
          local use = room:askToUseRealCard(target,params)
          if use then
            -- room:addTableMark(use.from, "koarbiuk-phase", use.card.trueName)  --每个牌名1次?

            use.extra_data = use.extra_data or {}
            use.extra_data.koarbiuk = true
            -- use.from:removeVirtualEquip(use.card.id)
            room:useCard(use)
            
            table.removeOne(cardNames,use.card.name)
            if #cardNames==0 then break end
          else
            Fk.currentResponseReason = nil
            room:moveCardTo(ids, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, koarbiuk_rule.name, nil, true, nil)  --弃 廢
            break
            -- return --畢 false 
          end

      end

      local cards = target:getCardIds(Player.Judge)
      while #cards > 0 do
        if data.phase_end then return end
        local cid = table.remove(cards)
        if not cid then return end
        local card = target:getVirtualEquip(cid)
        if not card then
          card = Fk:getCardById(cid)
        end

        if  not table.contains({"hqjin_szjer_ljis_doavs","tshoak_hsvoah_tsjek_sjin","koarbiuk_card"},card.trueName)
        and 
        table.contains(target:getCardIds(Player.Judge), cid) and card.skill and card.skill.name ~= "default_card_skill"
        then
          room:moveCardTo(card, Card.Processing, nil, fk.ReasonPut, "phase_judge")
          if card:isVirtual() then
            room:sendCardVirtName({cid}, card.name)
          end

          local effect_data = CardEffectData:new {
            card = card,
            to = target,
            tos = { target },
          }
          room:sendLog{
            type = "#CardEffect",
            from = target.id,
            arg = card:toLogString(),
          }
          room:doCardEffect(effect_data)
          if effect_data.isCancellOut then
            card.skill:onNullified(room, effect_data)
          end
        end
      end
      
    elseif data.phase == Player.Discard then
        local toBeDis =target:getCardIds(Player.Hand)
        local discardNum=#target:getCardIds(Player.Hand) - S.getMaxCards(target)
        for _, id in ipairs(target:getCardIds(Player.Hand)) do
            local card = Fk:getCardById(id)
            for _, skill in ipairs(room.status_skills[MaxCardsSkill] or Util.DummyTable) do  --不應該是狀態
              if   skill:excludeFrom(target, card) then table.removeOne(toBeDis, id) discardNum=discardNum-1 goto continue  end
              --不占用 
            end
            for _, skill in ipairs(Fk:currentRoom().status_skills[ProhibitSkill] or Util.DummyTable) do
              if skill:prohibitDiscard(target, card) then
                table.removeOne(toBeDis, id)
              end
            end
            if card:hasMark("extra_retain") then discardNum=discardNum-1 end
            ::continue::
        end
        room:broadcastProperty(target, "MaxCards")

        if discardNum > 0 then
          local data={
          num = discardNum,
          -- include_equip = false,
          skillName = "phase_discard",
          toBeDis = toBeDis,
        }
          local _, ret = room:askToUseActiveSkill(target, {
            skill_name = "phase_discard_skill",
            prompt = "#phase_discard:::"..discardNum,
            cancelable = false,
            extra_data = data,
          })
          if ret and ret.cards and #ret.cards>0 then
          room:throwCard(ret.cards, "phase_discard", target, target)
          end
      end

    elseif data.phase ==Player.Play then
      local logic=room.logic
        local oldPattern
        local oldDisabledSkillNames
        local disabledSkillNames={} ---不必要
        -- local oldPattern=Fk.currentResponsePattern
        -- Fk.currentResponsePattern=nil  --active cardNames
        -- local oldDisabledSkillNames=room:getBanner("bannedSkillsForEachPlayer")  --單用个名?
        -- room:setBanner("bannedSkillsForEachPlayer",nil)
        local clear =function()
          -- Fk.currentResponsePattern = oldPattern
          -- room:setBanner("bannedSkillsForEachPlayer" , oldDisabledSkillNames)
          room:setPlayerMark(target,"bannedSkills",nil)
        end
        while true do
          -- oldPattern=Fk.currentResponsePattern
          -- oldDisabledSkillNames=room:getBanner("bannedSkillsForEachPlayer")

          -- Fk.currentResponsePattern="."--active cardNames
          -- room:setBanner("bannedSkillsForEachPlayer",disabledSkillNames)

          room:setPlayerMark(target,"bannedSkills",disabledSkillNames)
          if  target.dead then clear() break end
          if data.phase_end then clear() return end   --事件內不能return

          logic:trigger(fk.BeforePlayCard, target, data)
          if data.phase_end then clear() return end

          local dat = { timeout = room:getBanner("Timeout") and room:getBanner("Timeout")[tostring(target.id)] or room.timeout }
          logic:trigger(fk.StartPlayCard, target, dat, true)

          local req = Request:new(target, "PlayCard")
          req.timeout = dat.timeout
          local result = req:getResult(target)
          if result == "" then clear() break end

          local useResult = room:handleUseCardReply(target, result)
          if type(useResult) == "table" then
            room:useCard(useResult)
          elseif type(useResult) == "string" and useResult ~= "" then
            -- table.insertIfNeed(disabledSkillNames, useResult)
              if Fk.skills[useResult] and Fk.skills[useResult]:hasTag(Skill.NotViewAs) then
                table.insert(disabledSkillNames,useResult)
             end
          end
        end
    end
    data.phase_end = true
    return true
  end,
})


--迻致open
-- koarbiuk_rule:addEffect("visibility", {
--   card_visible = function (self, player, card)
--     -- local owner = Fk:currentRoom():getCardOwner(card)
--     -- if owner and (#card:getTableMark("@@koarbiuk-inarea")>0
--     -- (or owner:getVirualEquip(card.id) and owner:getVirualEquip(card.id).name == "koarbiuk_card")) then
--     --   return player == owner
--     -- end
--     if table.contains(S.getPlayerKoarbiukCards(player),card.id ) then
--       return true
--     elseif table.contains(S.getAllKoarbiukCards(),card.id ) then
       
--         return false
--     end
--   end,
--   -- move_visible = function (self, player, info, move)
--   --   local cid = info.cardId
--   --   if move.from and move.toArea == Card.PlayerJudge then
--   --     local from = Fk:currentRoom():getPlayerById(move.from)
--   --     if #Fk:getCardById(cid):getTableMark("@@koarbiuk-inarea")>0 or (from:getVirualEquip(cid) and from:getVirualEquip(cid).name == "koarbiuk_card") then
--   --       return false
--   --     end
--   --   end
--   -- end,
-- })


return koarbiuk_rule

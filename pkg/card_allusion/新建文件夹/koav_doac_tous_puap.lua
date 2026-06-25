local koav_doac_tous_puap = fk.CreateSkill {
  name = "koav_doac_tous_puap",
}
Fk:loadTranslationTable{
  ["koav_doac_tous_puap"] = "高唐鬥法",
  ["#koav_doac_tous_puap"] = "选择一其他角色，伱予其1雷傷",


}
koav_doac_tous_puap:addEffect("cardskill", {
  prompt = "#koav_doac_tous_puap",
  target_num = 1,
  can_use = Util.FalseFunc,  --不能主動旹用
    mod_target_filter = function(self, player, to_select, selected, card)
    return to_select ~= player 
  end,
  target_filter = Util.CardTargetFilter,
  on_effect = function(self, room, effect)
    room:damage({
      from = effect.from,
      to = effect.to,
      card = effect.card,
      damage = 1,
      damageType = fk.ThunderDamage,
      skillName = koav_doac_tous_puap.name,
    })
  end,
})

koav_doac_tous_puap:addEffect(fk.FinishJudge, {
  global = true,
  can_trigger = function(self, event, target, player, data)
    return data.card and data.card.suit==Card.Spade
    and #table.filter(player:getCardIds("h"), 
      function(id)
        return Fk:getCardById(id).name == "tous_puap_phoas_koav_ljem"
      end)>0
  end,
  on_trigger = function(self, event, target, player, data)
    local use =player.room:askToUseCard(player,{
      skill_name = koav_doac_tous_puap.name,
      pattern="tous_puap_phoas_koav_ljem",
      cancelable=true,
      prompt="koav_doac_tous_puap",
    })
    if use then
      player.room:useCard(use)
    end
  end,
})

return koav_doac_tous_puap


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
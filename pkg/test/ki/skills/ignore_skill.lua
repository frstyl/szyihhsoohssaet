local sk = fk.CreateSkill{
  -- name = "armor_invalidity",
  name = "ignore_player_skill",  --給｢殺｣
}


-- Fk:loadTranslationTable{
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sk:addEffect('invalidity', {
  -- global = true,
  invalidity_func = function(self, player, skill)
    if not skill:isPlayerSkill(player, true)
    -- or not skill:isEffectable(player)
  --   ( skill:isInstanceOf(CardSkill) 
  --   or
  --     skill:isEquipmentSkill(player) 
  --     or skill.name:endsWith("&")
  -- )
    then return end 

        --player == to
      local from=nil
      local card=nil  --止用于狀態
      local current_UseCard_event=nil
      local current_CardEffect_event=nil

      if  RoomInstance and RoomInstance.logic:getCurrentEvent() then   --事件應該在此判斷

        local logic = RoomInstance.logic
        local event = logic:getCurrentEvent()
        local data=event.data

        if event.event == GameEvent.UseCard then  --onAim?
          from = data.from
          card=data.card
          current_UseCard_event=event
        elseif event.event == GameEvent.CardEffect then
            card =data.card
            from =data.from
            current_CardEffect_event=data
            current_UseCard_event=data.use

        elseif event.event == GameEvent.SkillEffect then --牌技能
          -- if not data.skill.cardSkill then
            from = data.who
            if event.parent.event==GameEvent.CardEffect then
              card=event.parent.data.card
              current_CardEffect_event=event.parent.data
              current_UseCard_event=event.parent.data.use
            end
           --   goto check
        elseif event.event == GameEvent.Damage then
          -- ---@cast data DamageData
          -- if data.to ~= player then return false end
          from = data.from
          card=data.card
          current_CardEffect_event=data.event_data
        elseif event.event == GameEvent.ChangeHp then
          if data.reason=="damage" and data.damageEvent then
            from = data.damageEvent.from
            card =data.damageEvent.card
            current_CardEffect_event=data.damageEvent.event_data
          end
        -- elseif  event.event==GameEvent.Recover then
        --   from=event.data.recoverBy
              -- card=data.card
        -- elseif  event.event==GameEvent.MoveCards then
        --   for _, move in ipairs(event.data) do
        --       from = move.proposer 
        --       local cardEffectEvent=event:findParent(GameEvent.CardEffect, true) --CardEffect
        --       if  cardEffectEvent then card=cardEffectEvent.card end
        --      --   goto check
          -- end
        -- elseif event.data and (event.data.from or event.data.who) then
        --   from = event.data.from or event.data.who
        --  --   goto check

        end
      else
      -- ::request::
      --多人詢問?
        if ClientInstance and ClientInstance.current_request_handler   --无視狀態技 request不屬于event中
        and ClientInstance.current_request_handler.player  then
          from = ClientInstance.current_request_handler.player
          -- card = Fk:getCardById(ClientInstance.current_request_handler.pendings[1])
        end
      end

      if S.isIgnorePlayerSkillsFromAToB(from,player,card,current_UseCard_event,current_CardEffect_event) then 
        return true 
      end


  end,
})

return sk

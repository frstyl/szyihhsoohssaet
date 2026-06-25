local sk = fk.CreateSkill{
  -- name = "armor_invalidity",
  name = "ignoreArmor_skill",
}


Fk:loadTranslationTable{
["@@MarkArmorNullified"] = "防具失效",
["@@MarkArmorNullified-phase"] = "防具失效",
["@@MarkArmorNullified-turn"] = "防具失效",
["@@MarkArmorNullified-round"] = "防具失效",
["@@ignoreArmor"] = "无視防具",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sk:addEffect('invalidity', {
  -- global = true,
  invalidity_func = function(self, player, skill)
    if not( skill:getSkeleton() 
          and 
            skill:getSkeleton().attached_equip 
            and
            Fk:cloneCard(skill:getSkeleton().attached_equip).sub_type == Card.SubtypeArmor 
          )
    then return end 
      if player:hasMark("@@MarkArmorNullified") then return true end  --防具无效 不等于 被任意角色无視, 无視防具 等于 无視任意角色防具

        --player == to
      local from=nil
      local card=nil  --无視防書于card 選擇目幖旹不能生效
      -- if not RoomInstance then goto request end
      if  RoomInstance and RoomInstance.logic:getCurrentEvent() then

        local logic = RoomInstance.logic
        local event = logic:getCurrentEvent()
        local data=event.data
        -- if not event then 
        --   -- return 
        --   goto request
        if event.event == GameEvent.UseCard then  --onAim?
          -- ---@cast data UseCardData
          -- if not table.contains(data.tos, player) then return false end
          from = data.from
          card=data.card
         --   goto check
        elseif event.event == GameEvent.CardEffect then
            card =data.card
            from =data.from
        elseif event.event == GameEvent.SkillEffect then   --from to  ---skill.trueName
          -- if not data.skill.cardSkill then
            from = data.who
            if event.parent.event==GameEvent.CardEffect then
              card=event.parent.data.card
            end
           --   goto check
        elseif event.event == GameEvent.Damage then  --尋得或記錄相關 CardUsing  --无視?无視目幖
          -- ---@cast data DamageData
          -- if data.to ~= player then return false end
          from = data.from
          card=data.card
         --   goto check
        elseif event.event == GameEvent.ChangeHp then  --ChangeMaxHp
          if data.reason=="damage" and data.damageEvent then  --skillName ? card  --回復?
            from = data.damageEvent.from
            card =data.damageEvent.card
           --   goto check
          end
        -- elseif  event.event==GameEvent.Recover then
        --   from=event.data.recoverBy
              -- card=data.card
        elseif  event.event==GameEvent.MoveCards then
          for _, move in ipairs(event.data) do
              from = move.proposer 
              local cardEffectEvent=event:findParent(GameEvent.CardEffect, true) --CardEffect
              if  cardEffectEvent then card=cardEffectEvent.card end
             --   goto check
          end
        -- elseif event.data and (event.data.from or event.data.who) then
        --   from = event.data.from or event.data.who
        --  --   goto check

        end
      else
      -- ::request::
        if ClientInstance and ClientInstance.current_request_handler   --request不屬于event中
        and ClientInstance.current_request_handler.player  then
          from = ClientInstance.current_request_handler.player
          -- card = Fk:getCardById(ClientInstance.current_request_handler.pendings[1])
        end
      end

      -- ::check::  --from to card
      if S.isIgnoreArmorFromAToB(from,player,card) then return true end
      if card then
        if card:hasMark("@@ignoreArmor")  then 
          return true--qinggang?
        else
          local e=player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
          while true do
            if e==nil then return end
            if e.data and e.data.card ==card then  --上次使用 卽止當次使用有效
              -- player:drawCards(5)
              return e.data.extra_data and e.data.extra_data.qinggang_tag 
            end
            e=e:findParent(GameEvent.UseCard)
          end
        end


        -- for _, suffix in ipairs(suffixes) do
        --   if table.contains(card:getTableMark(MarkEnum.MarkArmorInvalidTo .. suffix), player.id)  then
        --     return true
        --   end
        -- end

      end


  end,
})

return sk

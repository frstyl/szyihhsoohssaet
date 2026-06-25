local cardSkill = fk.CreateSkill {
  name = "tsjas_szji_hzfan_hzoon_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
["tsjas_szji_hzfan_hzoon"] = "借屍還䰟",
[":tsjas_szji_hzfan_hzoon"] = "一名角色A進入瀕死旹,,指定1死亾角色B使用,A死B復活.",

["#tsjas_szji_hzfan_hzoon_use"] = "借屍還䰟 %src",
}

cardSkill:addEffect("cardskill", {
  prompt = "#tsjas_szji_hzfan_hzoon",
  -- mod_target_filter = function(self, player, to_select, selected, card, extra_data)
  --   return to_select.dead
  -- end,
  -- target_filter = function(self, player, to_select, selected, _, card, extra_data)
  --   return to_select.dead
  -- end,
  -- target_num = 1,  --算單體
  max_turn_use_time = 1,
  can_use = Util.FalseFunc,  --見後
  on_use = function(self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
  end,
  -- on_use = function(self, room, UseCardData)  --見後
  --     -- if not effect.responseToEvent then return end
  --     local tos = table.map(table.filter(room.players, function(p) 
  --           return p.dead 
  --         end), 
  --       function(p) return "seat#" .. tostring(p.seat) 
  --     end)
  --     if #tos <= 0 then return end

  --       local targets = room:askToChoice(effect.from, {choices = tos, skill_name = cardSkill.name, prompt = "#revive-ask"})
  --       if not targets or targets== "" then return end
  --       local to = tonumber(string.sub(targets, 6))
  --       for _, p in ipairs(room.players) do
  --         if p.seat == to then
  --             effect.to=p  --過可選擇判定
  --           break
  --         end
  --       end
      
  -- end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)  
    if effect.responseToEvent  then
    -- room:revivePlayer(effect.to,  true, self.name,)
    end


    room:killPlayer({who=effect.responseToEvent.who, killer=effect.responseToEvent.killer, damage=effect.responseToEvent.damage})

    S.revive({
      who=effect.extra_data.tsjas_szji_hzfan_hzoon,
      drawN=3,
      skill=self.name
    })
  end,
})


cardSkill:addEffect(fk.EnterDying, {
  priority = 0.001,
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    if target.dead then return end
    if  player.seat~=1 then return end
    if player.room.alive_players==player.room.players then return end
    local players = S.getHolders("tsjas_szji_hzfan_hzoon")
    local card=Fk:cloneCard("lih_doeojs_doav_kiac")
      card:setVSPattern(nil,nil,".")
      local ps={}
      for _, p in pairs(players) do
        if S.magicCanUse(p,card) then
          table.insert(ps,p)
        end
      end
    if #ps==0 then return end

    event:setCostData(self,{players=ps})
    return true 
      
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local param ={
      pattern = "tsjas_szji_hzfan_hzoon",
      skill_name = "tsjas_szji_hzfan_hzoon",
      prompt = "#tsjas_szji_hzfan_hzoon_use:"..data.who.id,
      cancelable = true,
      extra_data = {
        -- must_targets = {data.to.id},
        -- exclusive_targets = event:getCostData(self).tos --id list
        -- bypass_distances = true,
        -- bypass_times = true,
      },
      event_data = data,
    }
    local use = room:askToNullification(event:getCostData(self).players, param)
    if use then


      local to

      local tos = table.map(table.filter(room.players, function(p) 
            return p.dead 
          end), 
        function(p) return "seat#" .. tostring(p.seat) 
      end)
      if #tos <= 0 then return end

        local target = room:askToChoice(use.from, {choices = tos, skill_name = cardSkill.name, prompt = "#revive-ask"})
        if not target or target== "" then return end
        target = tonumber(string.sub(target, 6))
        for _, p in ipairs(room.players) do
          if p.seat == target then
              -- effect.to=p  --過可選擇判定
            to=p
            break
          end
        end
      -- sendLog

      use.responseToEvent = data
      use.toCard=use.card

      use.extra_data = use.extra_data or {}
      use.extra_data.tsjas_szji_hzfan_hzoon=to
      -- use.attachedSkillAndUser={muteCard=true}
      room:doIndicate(use.from, {to})
      room:sendLog{
        type = "#UseCardToTargets",
        from = use.from.id,
        card = use.card:isVirtual() and use.card.subcards or { use.card.id },
        to={to.id}
      }
      room:playCardEmotionAndSound(use.from, use.card)
      player.room:useCard(use)
    end
    end,

})

return cardSkill

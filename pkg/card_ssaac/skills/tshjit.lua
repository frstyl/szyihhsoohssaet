local cardSkill = fk.CreateSkill {
  name = "tshjit_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#tshjit_skill",
  -- can_use =  function(self, player)
  --   local n=0
  --   local room = Fk:currentRoom()
  --   for _, p in ipairs(room.players) do
  --     if p:isWounded() then
  --       n=n+1
  --     end
  --   end
  --   return n >#room.players //2  --下整
  -- end,
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    if not player:prohibitUse(card) 
    -- and self:withinTimesLimit(player, Player.HistoryTurn, card, "tshjit", player)
    and S.magicCanUse(player, card)
    then

      for _, p in ipairs(Fk:currentRoom().players) do
        if not p:isWounded() then
          return false
        end
      end
      return true
    end
  end,
  on_use = function (self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    cardUseEvent.toCard=cardUseEvent.card
  end,
  mod_target_filter = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect) --无目幖 直接執行effect --對全體效果 无目幖--復活自己
    local times=(room:getBanner("tshjit") or 0 )+1
    room:setBanner("tshjit",times)
    room:addSkill("tshjit_skill_check")

    effect.extra_data =effect.extra_data or {}
    effect.extra_data.tshjit=true
    local tos=room:getAllPlayers(false)  --中途復𣴠
    local n=effect.from.seat
    local m=#tos
    while true do
      n=(n+1)%m
      if n==0 then n=m end
      if not tos[n].dead then
        room:loseHp(tos[n],1,cardSkill.name)  --无源
        room:delay(300) --ms
      end
      if effect.extra_data and effect.extra_data.tshjit==false then
        times = times-1
        room:setBanner("tshjit",times)
        if times<1 then
          Fk.skills["tshjit_skill_check"] = nil  --迻除
        end
        return
      end
    end
  end,
})
--addSkillType
-- cardSkill:addEffect(fk.Deathed, {
--   global=true,
--   can_refresh = function(self, event, target, player, data)
--       local losehp_event = player.room.logic:getCurrentEvent():findParent(GameEvent.LoseHp)
--       local effect_event = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect)
--       return losehp_event and losehp_event.data.who == target and effect_event and  effect_event.data.extra_data and effect_event.data.extra_data.tshjit
--     end,
--   on_refresh = function(self, event, target, player, data)
--       local effect_event = player.room.logic:getCurrentEvent():findParent(GameEvent.CardEffect)
--       if effect_event and effect_event.data and effect_event.data.extra_data and effect_event.data.extra_data.tshjit==true then
--         effect_event.data.extra_data.tshjit=false
--       end
--     end,
-- })
return cardSkill

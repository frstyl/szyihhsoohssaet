local sisziocs = fk.CreateSkill {
  name = "sisziocs",
}

Fk:loadTranslationTable{
  ["sisziocs"] = "伺訟",
  [":sisziocs"] = "➀伱不可額定起動➁其它腳色起動旹,伱起動(无視次數)",


}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


sisziocs:addEffect(fk.CardUsing, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return data.from ~= player and player:hasSkill(sisziocs.name) 
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room

    local use = room:askToUseCard(player, {  --askToPlayCard
        pattern = ".", --
        cancelable=false,
        skip=true,
        skill_name=sisziocs.name,
        extra_data={
          bypass_distances=false,
          bypass_times=true,
          extraUse=true,
          bypass_moment=true,
          not_passive=true,
      },
    }) 
    if use then
      room:useCard(use)
    end
  end,
})

sisziocs:addEffect("prohibit", {
  prohibit_use = function (self, player, card)
    if player:hasSkill(sisziocs.name)  then return 
      not card.is_passive and player:getMark("_sisziocs")==0
    end
  end,
})

sisziocs:addEffect(fk.HandleAskForPlayCard, {
  can_refresh = function(self, event, target, player, data) 
    -- if not  player:hasSkill(sisziocs.name)  then return end
    return (data.user==player or data.user==nil) 
    and not data.isResponse
    and data.extraData and data.extraData.bypass_moment 
  end,
  on_refresh = function(self, event, target, player, data)
    local room = player.room
    if not data.afterRequest then
      room:setPlayerMark(player,"_sisziocs", 1)
    else
      room:setPlayerMark(player,"_sisziocs", nil)
    end
  end,
})

-- sisziocs:addEffect("prohibit", {
--   prohibit_use = function (self, player, card)
--     if not player:hasSkill(sisziocs.name) then return end
--     if card.is_passive then return end
--     if not ClientInstance then return end
--     local handler = ClientInstance.current_request_handler
--     if (not handler) or (not handler:isInstanceOf(ClientInstance.request_handlers["AskForUseActiveSkill"])) then return  end
--     if handler.class.name == "ReqPlayCard" then
--       return true
--     elseif handler.class.name == "ReqUseCard" then
--       return handler.extra_data and handler.extra_data.bypass_moment
--     end
--   end,
-- })

return sisziocs


local jikpjis = fk.CreateSkill{
  name = "jikpjis",
}
Fk:loadTranslationTable{
["jikpjis"] = "翼庇",
[":jikpjis"] = "輪始旹,伱選擇1腳色A發動｡1輪內,一｢殺｣若目幖不含伱則不能選擇A",

["#jikpjis-invoke"] = "翼庇 打出1牌發動",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

jikpjis:addEffect(fk.RoundStart, {
  anim_type = "deffensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(jikpjis.name)
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local tos  = room:askToChoosePlayers(player, {
          targets =room:getOtherPlayers(player), 
          min_num = 1,
          max_num = 1,
          prompt = "#jikpjis-invoke",
          skill_name = jikpjis.name,
          cancelable = true,
        })
    -- local tos = event:getCostData(self).tos
    if #tos==0 then return end
    event:setCostData(self,{tos=tos})
    return true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:addTableMark(event:getCostData(self).tos[1],"@jikpjis-round",player.general)
    room:addTableMark(event:getCostData(self).tos[1],"jikpjis-round",player.id)
  end,
})



jikpjis:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    if to:getMark("jikpjis-round")==0 or card.trueName~="ssaet" then return end

        if ClientInstance and ClientInstance.current_request_handler
        and ClientInstance.current_request_handler.player  
        and  ClientInstance.current_request_handler.selected_targets
        then

            for _, pid in ipairs(to:getMark("jikpjis-round")) do
              if not table.contains(ClientInstance.current_request_handler.selected_targets, pid ) then return true end
            end

        end

  end,
})

return jikpjis

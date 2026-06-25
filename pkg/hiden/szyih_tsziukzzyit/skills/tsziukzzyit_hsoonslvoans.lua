local tsziukzzyit_hsoonslvoans = fk.CreateSkill {
  name = "tsziukzzyit_hsoonslvoans",
}

Fk:loadTranslationTable{
  ["tsziukzzyit_hsoonslvoans"] = "溷亂",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["#hsoonslvoans-effected"] = "%from 溷亂生效, %arg 目幖改 %to",
}
tsziukzzyit_hsoonslvoans:addEffect(fk.CardUsing, {
  anim_type = "negative",
  -- is_delay_effect = true,
  -- globle=true,
  can_trigger = function(self, event, target, player, data)
    return target == player 
    -- and table.contains({"ssaet","tous_tsiacs","hzaac_tshjes",data.card.trueName})
    and #data.tos==1
    and data.tos[1]~=player
    and S.tsziukzzyitTrigger(player,"hsoonslvoans")
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room


      local targets=room.alive_players

      local random_target = table.random(targets)
      player.room:sendLog{ type = "#hsoonslvoans-effected", from = player.id,to={random_target.id},arg=data.card:toLogString()}

      data:removeTarget(data.tos[1])
      data:addTarget(random_target)
      
      -- if #targets > 1 then
      --   for _ = 1, 2 do
      --     for _, p in ipairs(room:getAllPlayers()) do
      --       if table.contains(targets, p) then
      --         room:setEmotion(p, "./image/anim/selectable")
      --         room:notifyMoveFocus(p, tsziukzzyit_hsoonslvoans.name)
      --         room:delay(300)
      --       end
      --     end
      --   end
      --   for _, p in ipairs(room:getAllPlayers()) do
      --     if table.contains(targets, p) then
      --       room:setEmotion(p, "./image/anim/selectable")
      --       room:delay(600)
      --       if p.id == random_target then
      --         room:doIndicate(data.from, {random_target})
      --         break
      --       end
      --     end
      --   end
      -- end

  end,
})


return tsziukzzyit_hsoonslvoans

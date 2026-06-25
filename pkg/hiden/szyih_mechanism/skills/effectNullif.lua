local effectNullify = fk.CreateSkill {  --usecard 旹對目幖无效 之 後續, effect事件中无效當時卽處理
  name = "effectNullify",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

effectNullify:addEffect(fk.PreCardEffect, {
  -- global = true,
  can_refresh = function(self, event, target, player, data)
    return player.seat==1
    and data.to 
    and data.use ~= nil 
    and data.use.extra_data and data.use.extra_data.ssaethsooh
    and table.contains(data.use.extra_data.ssaethsooh, data.to)  --必有目幖
  end,
  on_refresh = function(self, event, target, player, data)
    S.effectNullify(data,data.to)
    return true 
  end,
})

return effectNullify

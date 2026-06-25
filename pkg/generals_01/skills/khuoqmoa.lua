local khuoqmoa = fk.CreateSkill{
  name = "khuoqmoa",
}

Fk:loadTranslationTable{
  ["khuoqmoa"] = "敺魔",
  [":khuoqmoa"] = "伱始段始旹,伱可選1角色發動｡其隨機附加咒術",

  ["#khuoqmoa"] = "敺魔 爲1角色附加咒術",
  -- ["#khuoqmoa-ask"] = "敺魔 是否附加 負面 咒術",

  ["$khuoqmoa1"] = "禍福從天降 心仁萬事誼",
  ["$khuoqmoa2"] = "禍兮福所倚 福兮禍所伏",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

khuoqmoa:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(khuoqmoa.name) and data.phase == Player.Start
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local success, dat = room:askToUseActiveSkill(player, {
      skill_name = "khuoqmoa_active",
      prompt = "#khuoqmoa",
      cancelable = true,
      skip = true,
    })
    if success and dat then
      event:setCostData(self, {tos = dat.targets, choice = dat.interaction})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- local room=player.room
    S.addTsziukzzyitBuff(event:getCostData(self).tos[1],  event:getCostData(self).choice,player)
  end,
})


return khuoqmoa

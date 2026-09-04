local deephzoon = fk.CreateSkill {
  name = "deephzoon",
  -- tags = { Skill.Compulsory },
}
Fk:loadTranslationTable{
  ["deephzoon"] = "蝶䰟",
  [":deephzoon"] = "腳色致傷後,對其發動(其未被技能)｡1轉內,其致傷前,防止之,其抽1",

  ["#deephzoon-invoke"] = "蝶䰟 選擇目幖 ",
  ["@deephzoon-turn"] = "蝶䰟",

  ["$deephzoon1"] = "一對白龍爭上下",
  ["$deephzoon2"] = "董一撞在此",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

deephzoon:addEffect(fk.Damaged, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from and player:hasSkill(deephzoon.name) 
    and not data.from:hasMark("@deephzoon-turn")
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    room:addPlayerMark(data.from, "@deephzoon-turn",1)
  end,
})

deephzoon:addEffect(fk.PreDamage, {
  can_trigger = function(self, event, target, player, data)
    return data.from==player and  data.from:hasMark("@deephzoon-turn")
  end,
  on_trigger= function(self, event, target, player, data)
    S.preventDamage({damageData=data, skillName=deephzoon.name})
    if not data.from.dead then data.from:drawCards(1,deephzoon.name) end
  end,
})

return deephzoon

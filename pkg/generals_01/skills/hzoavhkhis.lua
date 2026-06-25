Fk:loadTranslationTable{
  ["hzoavhkhis"] = "浩气",
  [":hzoavhkhis"] = "伱使用殺對其它角色致傷後,伱可發動:伱抽x,其弃x",



  ["$hzoavhkhis1"] = "哈哈哈哈哈哈哈哈！",
  ["$hzoavhkhis2"] = "伯符，且看我这一手！",
}

local hzoavhkhis = fk.CreateSkill{
  name = "hzoavhkhis",
  -- tags = { Skill.Compulsory,Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoavhkhis:addEffect(fk.Damage, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hzoavhkhis.name) and data.to~=player and data.damage>0
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local n =data.damage
    player:drawCards(n,hzoavhkhis.name)
    room:askToDiscard(data.to, {
      min_num = n,
      max_num = n,
      include_equip = true,
      skill_name = hzoavhkhis.name,
      cancelable = false,
      prompt = "#hzoavhkhis-discard",
      skip = false,
    })
  end,
})


return hzoavhkhis

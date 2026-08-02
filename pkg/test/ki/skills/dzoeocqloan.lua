local dzoeocqloan = fk.CreateSkill {
  name = "dzoeocqloan",
  tags={Skill.Compulsory,Skill.Switch},
}

Fk:loadTranslationTable{
  ["dzoeocqloan"] = "層瀾",
  -- [":dzoeocqloan"] = "伱受傷後必發,若手牌數爲:奇,伱抽3;耦,伱弃1", 
  [":dzoeocqloan"] = "輪流發動,伱受傷後必發,➀伱抽3➁伱弃一半手牌", 

  -- ["dzoeocqloan"] = "層瀾",

  ["$dzoeocqloan1"] = "讓俺再宰一个",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"
dzoeocqloan:addEffect(fk.Damaged, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(dzoeocqloan.name)  
  end,
  -- on_cost = function(self, event, target, player, data)
  -- evevt:setCostData(self,{Switch=player:getSwitchSkillState(dzoeocqloan.name, false)})
  --   return true
  -- end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if player:currentSwitchState()  == fk.SwitchYang then
      player:drawCards(3,dzoeocqloan.name)
    else
      local n=player:getHandcardNum()
      if n==0 then return end
      local cards = room:askToDiscard(player, {
        min_num = n//2,
        max_num = n//2,
        include_equip = false,
        skill_name = dzoeocqloan.name,
        -- prompt = "#dzoeocqloan-discard",
        cancelable = false,
        skip = false,
      })
    end
  end,
})

-- dzoeocqloan:addEffect(fk.Damaged, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return  player:hasSkill(dzoeocqloan.name)  
--   end,
--   on_cost = function(self, event, target, player, data)
--     return true
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local n=player:getHandcardNum()
--     if n % 2 ==0 then
--       if n==0 then return end
--     local cards = room:askToDiscard(player, {
--       min_num = n//2,
--       max_num = n//2,
--       include_equip = false,
--       skill_name = dzoeocqloan.name,
--       -- prompt = "#dzoeocqloan-discard",
--       cancelable = false,
--       skip = false,
--     })
--     else
--       player:drawCards(3,dzoeocqloan.name)
--     end
--   end,
-- })

return dzoeocqloan

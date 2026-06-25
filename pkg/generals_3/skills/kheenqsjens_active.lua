local kheenqsjens_active = fk.CreateSkill {
  name = "kheenqsjens_active&",
}

Fk:loadTranslationTable{
  ["kheenqsjens_active&"] = "牽線",
  [":kheenqsjens_active&"] = "1梅花手牌交予与伱併選1角色B除伱与其己者發動。",

  ["#kheenqsjens_active&"] = "1梅花手牌交予与伱併選1角色B除伱与其己者發動",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

local sig=function(n)
  if n==0 then 
    return 0
  elseif n>0 then 
    return 1
  elseif n<0 then 
    return -1
  end
end

kheenqsjens_active:addEffect("active", {
  anim_type = "support",
  prompt = "#kheenqsjens_active&",
  mute = true,
  card_num = 0,
  target_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  -- end,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected < 1 and Fk:getCardById(to_select).type == Card.TypeTrick  -- 
  -- end,
  target_filter = function(self, player, to_select, selected)
    return to_select ~= player 
    and(
      #selected == 0  
    and to_select:hasSkill("kheenqsjens") 
  )
    or (
      #selected==1
      and   sig(player.hp -player:getHandcardNum()) ~= sig(to_select.hp-to_select:getHandcardNum())
    )
  end,
  on_use = function(self, room, effect)
    -- Fk.skills["kheenqsjens"]:onUse(room, SkillUseData:new {
    --   from = effect.tos[1],
    --   cards = {},
    --   tos = {player,effect.tos[2]},
    -- })
        Fk.skills["kheenqsjens"]:onUse(room,{
      from = effect.tos[1],
      -- cards = {},
      tos = {player,effect.tos[2]},
        })

  end,
})

return kheenqsjens_active

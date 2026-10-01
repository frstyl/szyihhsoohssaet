local cardSkill = fk.CreateSkill {
  name = "hzouc_paav_skill",
}

Fk:loadTranslationTable{
  ["hzouc_paav_skill"] = "紅包",
  ["#hzouc_paav-choose:"] = "紅包 選擇牌類",

  ["action"] = "行動牌",
  ["goods"] = "物資牌",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#hzouc_paav_skill",
  -- mod_target_filter = function(self, player, to_select)
  --   return to_select:getMark("hzouc_paav")==0
  -- end,
  -- can_use = Util.CanUseToSelf,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  mod_target_filter = Util.TrueFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local player=effect.to
    if effect.to.dead then return end
    local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = cardSkill.name,
      prompt = "#hzouc_paav-choose",
    })
    choice=S.convertType(choice)
    local n=math.random(1,4)==1 and 2 or 1
    local cards={}
    for _,id in ipairs(room.draw_pile) do
      if S.getCardTypeByName(id)==choice then 
        table.insert(cards,id)
        if #cards==n then break end
      end
    end
    room:moveCards({
        ids = cards,
        to = player,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonPrey,  --Prey?
        proposer = player,
        skillName = cardSkill.name,
      })
  end,
  -- on_effect = function(self, room, effect)
  --   local player=effect.to
  --   if effect.to.dead then return end
  --   local choices={"action","trick","equip","goods" ,"magic","allusion"}  --S.
  --   local choice = room:askToChoice(player, {
  --     choices = choices,
  --     skill_name = cardSkill.name,
  --     prompt = "#hzouc_paav-choose",
  --   })

  --   local pattern  =tostring(Exppattern{ name=S.getCardTypeByName(table.indexOf(choices,choice),true)})
  --   local n=1
  --   if math.random(1,4)==1 then n=2 end
  --   local cards=room:getCardsFromPileByRule(pattern,n)
  --   room:moveCards({
  --       ids = cards,
  --       to = player,
  --       toArea = Card.PlayerHand,
  --       moveReason = fk.ReasonPrey,  --Prey?
  --       proposer = player,
  --       skillName = cardSkill.name,
  --     })
  -- end,
})

return cardSkill

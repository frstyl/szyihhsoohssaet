local hsxestszjens = fk.CreateSkill{
  name = "hsxestszjens",
}

Fk:loadTranslationTable{
  ["hsxestszjens"] = "戲戰",
  [":hsxestszjens"] = "伱指定/成爲｢殺｣目幖旹,伱可迻除此目幖發動,伱弃其1",

  -- ["#hsxestszjens-ask"] = "戲戰 是否對 %src 發動",
  ["#hsxestszjens-choose"] = "戲戰 選擇1手牌",


  ["$hsxestszjens1"] = "且慢",  --

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
  anim_type = "defensive",
  -- can_trigger = function(self, event, target, player, data)
    -- return (data.to==player or data.from ==player)
    -- and player:hasSkill(hsxestszjens.name) --
    -- and data.card.trueName=="ssaet"
    -- and not data.cancelled
  -- end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, { skill_name = self.name }) then
      event:setCostData(self,{tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room

      data:cancelTarget(data.to)
      if not data.to:isKongcheng() then
        local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = hsxestszjens.name })
        room:throwCard({cid}, hsxestszjens.name, data.to, player)

      end
  end,
}
hsxestszjens:addEffect(fk.TargetConfirming, {
  can_trigger = function(self, event, target, player, data)
    return data.from==player 
    and player:hasSkill(hsxestszjens.name)  and self:isEffectable(player)--
    and data.card.trueName=="ssaet"
    and not data.cancelled
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})
hsxestszjens:addEffect(fk.TargetConfirming, {
  can_trigger = function(self, event, target, player, data)
    return data.to ==player
    and player:hasSkill(hsxestszjens.name)  and self:isEffectable(player)--
    and data.card.trueName=="ssaet"
    and not data.cancelled
  end,
  on_cost=spec.on_cost,
  on_use=spec.on_use,
})



return hsxestszjens

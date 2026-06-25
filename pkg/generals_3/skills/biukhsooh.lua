local biukhsooh = fk.CreateSkill {
  name = "biukhsooh",
}

Fk:loadTranslationTable{
  ["biukhsooh"] = "伏虎",
  [":biukhsooh"] = "當一其它角色使用【殺】致傷後或被抵消後,，(若其未陣亾)伱可將1{♠️/♠️/无花}牌轉化爲殺對其預使用發動，无視合理檢測,若伏虎殺:元牌爲酒或裝僃,其傷害基數+1;結算後未致傷,伱抽x(x爲其傷害基數)",

  ["#biukhsooh-use"] = "伏虎 將非紅牌轉化爲殺對 %src  使用",

  ["$biukhsooh1"] = "小小大蟲有何可懼",
}

local spec ={
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return target~=player and  player:hasSkill(biukhsooh.name) 
    and data.card and data.card.trueName == "ssaet" 
    and not target.dead
    and not player:isNude()
  end,
  -- trigger_times= function(self, event, target, player, data)
  --   return data.damage
  -- end,
  on_cost = function(self, event, target, player, data)
    local use = player.room:askToUseVirtualCard(player, {
      name = "ssaet",
      skill_name = biukhsooh.name,
      prompt = "#biukhsooh-use:"..target.id,
      cancelable = true,
      extra_data = {
        must_targets = {target.id},
        exclusive_targets = {target.id},
        bypass_distances = true,
        bypass_times = true,
      },
      card_filter = {
        n = 1,
        pattern=".|.|club,spade,nosuit", --无色
        -- cards = cards,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, { use = use,tos={target} })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local use = event:getCostData(self).use
    -- local c= Fk:getCardById(event:getCostData(self).cards[1])
    -- room:throwCard(event:getCostData(self).card, biukhsooh.name, player, player)

    -- local card = Fk:cloneCard("ssaet")  --虛牌鎖无色?
    -- card.skillName = biukhsooh.name
    -- local use={
    --   from = player,
    --   tos = {target},
    --   card = card,
    -- }
    local sub = Fk:getCardById(use.card.subcards[1])
    if sub.type==Card.TypeEquip or sub.trueName=="tsiuh" then
      
      use.additionalDamage = (use.additionalDamage or 0) + 1
    end
    if not player:canUseTo(use.card,target,{ bypass_distances = true,bypass_times = true}) then return end--无視合理
    room:useCard(use)
    if use.damageDealt==nil then 
      local n =(use.additionalDamage or 0) +1
      player:drawCards(n, biukhsooh.name)
    end
  end,
}
biukhsooh:addEffect(fk.Damage, {
  can_trigger = spec.can_trigger,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

biukhsooh:addEffect(fk.CardEffectCancelledOut, {
  can_trigger = spec.can_trigger,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})
return biukhsooh

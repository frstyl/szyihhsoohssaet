local zyenqtoav = fk.CreateSkill {
  name = "zyenqtoav",
  tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable {
  ["zyenqtoav"] = "旋刀",
  [":zyenqtoav"] = "鎖定.伱所使用殺被閃抵消旹,必發.中止此殺結算視爲伱未使用此殺,肰後視爲伱對目幖角色下家使用此殺(虛牌同牌面,傷害基數+1,).當伱需因虛殺使用閃,必發.視爲伱使用閃",
--伱每段所用第一殺无視距離.
  ["$zyenqtoav1"] = "飛影漫天,必有一傷",
  ["$zyenqtoav2"] = "昰一刀必昰要殺出血灮",
}

zyenqtoav_spec={
  on_use = function(self, event, target, player, data)
    local card = data.card
    local newcard = Fk:cloneCard(card.name, card.suit, card.number)
    newcard.color=data.card.color
    newcard.skillName = zyenqtoav.name
    newcard.mark=card.mark
    -- local use ={
    --   from = player,
    --   tos = {data.to:getNextAlive(flase,1,true)},  --迻除
    --   card = card,
    --   additionalDamage =(data.use.additionalDamage or 0) +1,
    --   extra_data= data.use.extra_data ,
    -- }
    local use ={
      from = player,
      tos = {S.getNextOne(data.to)},  --迻除
      card = newcard,
      responseToEvent=data.use.responseToEvent,
      nullifiedTargets=data.use.nullifiedTargets,
      extraUse=data.use.extraUse,
      disresponsiveList==data.use.disresponsiveList,
      unoffsetableList==data.use.disresponsiveList,
      additionalDamage =(data.use.additionalDamage or 0) +1,
      extra_data= data.use.extra_data or {},
      -- cardsResponded
      cardsResponded=data.use.cardsResponded,
      additionalEffect=data.use.cardsResponded,
    }
    use.extra_data.zyenqtoav=S.getNextOne(data.to).id --无效後 肰与結算終旹同旹 

    player.room:useCard(use)
    data.use.extraUse=true --視爲未使用 主戰?
    data.use.extra_data=data.use.extra_data or {}
    data.use.extra_data.not_used=true
    return true
  end,
}

--无效用 于結算終旹觸發
zyenqtoav:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  data.cardsResponded[1].trueName=="szjemh" 
    and data.from == player
    and player:hasSkill(zyenqtoav.name) 
    and data.card.trueName=="ssaet"
  end,
  on_use = zyenqtoav_spec.on_use,
})

-- zyenqtoav:addEffect(fk.CardEffectFinished, {  --死循環?
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return  player:hasSkill(zyenqtoav.name) and data.card.trueName=="ssaet" --and data.nullified
--   end,
--   on_use = zyenqtoav_spec.on_use,
-- })

-- zyenqtoav:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card)
--           return card and card.trueName=="ssaet" and 
--           player:getMark("zyenqtoav-phase") == 0
--   end,
-- })
-- zyenqtoav:addEffect(fk.AfterCardUseDeclared, {
--   can_refresh = function(self, event, target, player, data)
--     return target == player and player.phase == Player.Play
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:addPlayerMark(player, "zyenqtoav-phase", 1)
--   end,
-- })

zyenqtoav:addEffect(fk.AskForCardUse, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zyenqtoav.name) 
      and data.eventData
      and data.eventData.to==player
      and data.eventData.use
      and data.eventData.use.card
      and data.eventData.use.card.trueName=="ssaet"
      and #data.eventData.use.card.subcards==0  --isVirtual

      and Exppattern:Parse(data.pattern):matchExp("szjemh|0|nosuit|none") 
      and not player:prohibitUse(Fk:cloneCard("szjemh"))
  end,
  on_use = function(self, event, target, player, data)  
  local new_card = Fk:cloneCard('szjemh')
      new_card.skillName = "zyenqtoav"
      local result = {
        from = player,
        card = new_card,
        tos = {}
      }
      data.result = result
    end,
})

return zyenqtoav
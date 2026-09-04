local zyenqtoav = fk.CreateSkill {
  name = "zyenqtoav",
  tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable {
  ["zyenqtoav"] = "旋刀",
  [":zyenqtoav"] = "➀伱所起動殺被閃抵消旹,必發.伱對目幖脚色下家或下家(有向,无已有向則遠離伱之方向)起動｢殺｣(繼承此殺牌面与效果,傷害基數+1,越過合理檢測).➁當伱需因虛殺起動閃,必發.視爲伱起動閃",
--伱每段所起動第一殺无視距離.
  ["$zyenqtoav1"] = "飛影漫天,必有一傷",
  ["$zyenqtoav2"] = "昰一刀必昰要殺出血灮",
}

zyenqtoav_spec={
  on_use = function(self, event, target, player, data)
    local room=player.room
    local card = data.card
    local newcard = Fk:cloneCard(card.name, card.suit, card.number)
    newcard.color=data.card.color
    newcard.skillName = zyenqtoav.name
    newcard.mark=card.mark


    local direction = data.use.extra_data and  data.use.extra_data.direction
    if not direction then --不計死
      direction=S.getDirectFromAToB(player,data.to)
      if direction==0 then direction=1 end
    end
    local to=S.getNextOne(data.to,direction)
    local use ={
      from = player,
      tos = {to} ,  --迻除
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
    use.extra_data.direction = direction
    player.room:useCard(use)

      -- -- table.insert(data.use.tos,player,1)
      -- -- data.use.tos={player,data.to,player}
      -- data.use.tos={}
      --       -- local c={1}
      -- -- for _,v in ipairs(c) do
      -- --   player:drawCards(#c)
      -- --   table.insert(c,1)
      -- -- end
      -- data.to:drawCards(5)
      -- player:drawCards(data.use.effectTimes+1 or 4)
      -- data.use.additionalEffect=(data.use.additionalEffect or 0) +1

    -- data.use.extraUse=true --視爲未起動 主戰?
    -- data.use.extra_data=data.use.extra_data or {}
    -- data.use.extra_data.not_used=true
    return true
  end,
}

--无效用 于結算終旹觸發
zyenqtoav:addEffect(fk.CardEffectCancelledOut, { -- -- ----CardEffectFinished
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  
    data.cardsResponded[#data.cardsResponded].trueName=="szjemh" 
    and 
    data.from == player
    and player:hasSkill(zyenqtoav.name) 
    and data.card.trueName=="ssaet"
    and data.use  --直接生效?f
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
    return 
    player:hasSkill(zyenqtoav.name) 
      and data.eventData
      and data.eventData.to==player
      and data.eventData.card
      and data.eventData.card.trueName=="ssaet"
      and data.eventData.card:isRuleVirtual()

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
local hzoojmaah_trigger = fk.CreateSkill {
  name = "hzoojmaah_trigger",
}

Fk:loadTranslationTable{
  ["hzoojmaah_trigger"] = "回馬",
  [":hzoojmaah_trigger"] = "當伱可使用(虛无點无色)閃旹,伱預轉化1牌爲殺發動,若此殺致傷,視爲伱使用虛閃.",--不能自選序

  ["#hzoojmaah_trigger"] = "回馬：伱可使用殺,若致傷視爲伱使用閃",

  ["$hzoojmaah_trigger1"] = "回馬定策,叫汝等有來无回",
  ["$hzoojmaah_trigger2"] = "此計向西而示之已東",
}

---@type AskForCardFunc
local hzoojmaah_trigger_spec = {
    on_cost = function(self, event, target, player, data)
    local room = player.room
    local use = room:askToUseVirtualCard(player, {  --檢測不對 不能用无點无花卽退出,
      name = "ssaet",
      skill_name = hzoojmaah_trigger.name,
      prompt = "#hzoojmaah_trigger",
      cancelable = true,
      extra_data = {      
        bypass_times = true,
        extraUse=true,
        -- hzoojmaah_trigger=player.id
        },
      card_filter = {
        n = 1,
        -- cards = player:getCardIds("he"),
      },
      skip = true,
    })
    if use then
      use.extraUse = true
      event:setCostData(self,{use=use,tos=use.tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local use =event:getCostData(self).use
     room:useCard(use)
    --CardUseFinished
    -- if player:getMark("@hzoojmaah_trigger-phase")~=1 then 
    --   return 
    -- end
    -- room:setPlayerMark(player,"@hzoojmaah_trigger-phase",0)  --

    if  use.damageDealt==nil  then return end

    local new_card = Fk:cloneCard('szjemh')
    new_card.skillName = hzoojmaah_trigger.name
    local result = {
        from = player,
        card = new_card,
      }  
    if event:isInstanceOf(fk.AskForCardUse) then
      result.tos = {}
    end
    data.result = result
    return true --使用閃後中止旹機流程
  end,
}

hzoojmaah_trigger:addEffect(fk.AskForCardUse, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzoojmaah_trigger.name) 
      and Exppattern:Parse(data.pattern):matchExp("szjemh|0|nosuit|none") and
      not player:prohibitUse(Fk:cloneCard("szjemh"))
  end,
  on_cost = hzoojmaah_trigger_spec.on_cost,
  on_use = hzoojmaah_trigger_spec.on_use,
})
hzoojmaah_trigger:addEffect(fk.AskForCardResponse, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzoojmaah_trigger.name) 
      and Exppattern:Parse(data.pattern):matchExp("szjemh|0|nosuit|none") and
      not player:prohibitResponse(Fk:cloneCard("szjemh"))
  end,
  on_cost = hzoojmaah_trigger_spec.on_cost,
  on_use = hzoojmaah_trigger_spec.on_use,
})

-- hzoojmaah_trigger:addEffect(fk.CardUseFinished, {  --
--   priority=-999, --无其它旹機事件 接閃
--   mute = true,
--   is_delay_effect = true,
--   can_refresh = function(self, event, target, player, data)
--     return 
--     target == player  
--     and 
--     data.damageDealt 
--     and table.contains(data.card.skillNames, hzoojmaah_trigger.name)
--     -- and data.extra_data --and data.extra_data.hzoojmaah_trigger
--     --  and data.extra_data.hzoojmaah_trigger == player.id
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:setPlayerMark(player,"@hzoojmaah_trigger-phase",1)
--   end,
-- })



return hzoojmaah_trigger

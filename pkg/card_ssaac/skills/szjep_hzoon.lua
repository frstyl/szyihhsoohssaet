local szjep_hzoon = fk.CreateSkill {
  name = "szjep_hzoon_skill",
}


Fk:loadTranslationTable{
-- ["szjep_hzoon"] = "攝䰟",
-- [":szjep_hzoon"] = "一名角色回合開始歬,選擇一其它角色A發動.A判定.判定後伱可弃一張与判定牌同色手牌,令A失去全部技能至其轉終後或此技能離場失效.",
["@@ssaac-turn"] = "攝䰟-生",
["@@sjih-turn"] = "攝䰟-死",

["#szjep_hzoon"] = "攝䰟 先選擇生角色(實際牌目幖) 後選死 ",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local clear = function (room)
    for _, p in ipairs(room:getAllPlayers()) do 
        -- local p=room:getPlayerById(id)
        -- if p:getMark("@@ssaac-turn") ~=0 then
            room:setPlayerMark(p, "@@ssaac-turn", 0)
        -- end
        -- if p:getMark("@@sjih-turn") ~+0 then
            room:setPlayerMark(p, "@@sjih-turn", 0)
        -- end
    end
end


szjep_hzoon:addEffect("cardskill", {
  prompt = "#szjep_hzoon",
  max_turn_use_time = 1,
  can_use = function(self, player, card, extra_data)
    return S.magicCanUse(player, card)
  end,  
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    if #selected == 0 then
      return true
    elseif #selected == 1 then
      return selected[1]~=(to_select)
    end
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    if #selected >= 2 then
      return false
    elseif #selected == 0 then
      return Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data)
    else
      return selected[1]~=(to_select)
    end
  end,
  target_num = 2,  --算單體
  on_use = function(self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    local tos = table.simpleClone(cardUseEvent.tos)
    cardUseEvent:removeAllTargets()
    for i = 1, #tos, 2 do
      cardUseEvent:addTarget(tos[i], { tos[i + 1] })
    end
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)  
    clear(room)     --先清理 同旹止有一組
    if effect.to.dead or effect.subTargets.dead then return end
    room:setPlayerMark(effect.to,"@@ssaac-turn",effect.subTargets[1].id)
    room:setPlayerMark(effect.subTargets[1],"@@sjih-turn",effect.to.id)
  end,
})

szjep_hzoon:addEffect(fk.DamageInflicted,{
  global=true,
  can_trigger = function(self, event, target, player, data)
    return player == target and target:getMark("@@sjih-turn") ~=0
  end,
  on_trigger = function(self, event, target, player, data)
    target.room:recover{
        who =  target.room:getPlayerById(target:getMark("@@sjih-turn")),
        num = data.damage,
        recoverBy = target,  --?
        skillName = szjep_hzoon.name,
      }
  end,
})

szjep_hzoon:addEffect(fk.Death,{
  global=true,
  can_trigger = function(self, event, target, player, data)
    return player==target and target:getMark("@@sjih-turn") ~=0 or target:getMark("@@ssaac-turn") ~=0
  end,
  on_trigger = function(self, event, target, player, data)
    clear(target.room)
  end,
})

return szjep_hzoon

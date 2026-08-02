local szjep_hzoon = fk.CreateSkill {
  name = "szjep_hzoon_skill",
}


Fk:loadTranslationTable{
["@@ssaac-turn"] = "攝䰟-生",
["@@sjih-turn"] = "攝䰟-死",

["#szjep_hzoon"] = "攝䰟 先選擇生脚色(實際牌目幖) 後選死 ",
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
    return S.magicCanUse(player, card, extra_data)
  end,  
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
      return true
  end,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return Util.CardTargetFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  target_num = 1,  --算單體
  on_use = function(self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)

    for i, p in ipairs(cardUseEvent.tos) do
      local targets= table.filter(room.alive_players,function(sub)
          return p~=sub
        end
        )
      if #targets==0 then return end
      
      cardUseEvent.subTos =cardUseEvent.subTos or {}
      local subTarget=room:askToChoosePlayers(cardUseEvent.from, {
        targets = targets,
        min_num = 1,
        max_num = 1,
        prompt = "#askToChooseSubTargets:::"..cardUseEvent.card:toLogString(),  --无用
        skill_name = szjep_hzoon.name,
        cancelable=false,
      })
      cardUseEvent.subTos[i]=subTarget
    end
  end,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)  
    clear(room)     --先淸理 同旹止有一組
    if effect.to.dead or effect.subTargets.dead then return end
    room:setPlayerMark(effect.to,"@@ssaac-turn",effect.subTargets[1].id)
    room:setPlayerMark(effect.subTargets[1],"@@sjih-turn",effect.to.id)
  end,
})

szjep_hzoon:addEffect(fk.DamageInflicted,{
  -- global=true,
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
  -- global=true,
  can_trigger = function(self, event, target, player, data)
    return player==target and target:getMark("@@sjih-turn") ~=0 or target:getMark("@@ssaac-turn") ~=0
  end,
  on_trigger = function(self, event, target, player, data)
    clear(target.room)
  end,
})

return szjep_hzoon

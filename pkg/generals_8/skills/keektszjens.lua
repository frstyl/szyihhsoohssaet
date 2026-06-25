local keektszjens = fk.CreateSkill {
  name = "keektszjens",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{ --拆解
  ["keektszjens"] = "擊戰",
  [":keektszjens"] = "伱使用殺或鬥將旹可發動.此牌至結算終,其致傷旹傷害值+1,其被抵消旹,伱弃2手牌或流失1體力",
  ["#keektszjens"] = "擊戰 失去體力加傷",

  ["#changeDamageBySkill"] = "由于 %arg 的效果，對 %from 傷害 + %arg2",

  ["$keektszjens1"] = "賊子伱往若里去",
  ["$keektszjens2"] = "",
}

keektszjens:addEffect(fk.CardUsing, {  --
  anim_type = "offensive",
  prompt = "#keektszjens",
	can_trigger = function(self, event, target, player, data)
		return target==player and player:hasSkill(keektszjens.name)
    and (data.card.trueName=="ssaet" or data.card.trueName=="tous_tsiacs")
	end,
	on_use = function(self, event, target, player, data)
    local room=player.room

    local use = player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
    player.room:addTableMark(player,"keektszjens-phase",use.id)

    data.extra_data=data.extra_data or {}
    data.extra_data.keektszjens=player.id

  end,
})

keektszjens:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    if player.seat~=1 then return end 
    local e=player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true)
    while true do
      if e==nil then return end
      if e.data and e.data.card ==data.card and  e.data.extra_data and e.data.extra_data.keektszjens then return true end
      e=e:findParent(GameEvent.UseCard)
    end
  end,
  on_trigger = function(self, event, target, player, data)
    -- player.room:sendLog{ type = "#changeDamageBySkill", from = data.to.id, arg = keektszjens.name ,arg2=1}
    -- data:changeDamage(1)
    S.changeDamage({damageData=data,num=1,skillName=keektszjens.name})
  end,
})

keektszjens:addEffect(fk.CardEffectCancelledOut, {
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return data.card  and table.contains(data.card:getTableMark("keektszjens-phase"),player.id)
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local discards = room:askToDiscard(player, {
        min_num = 2,
        max_num = 2,
        include_equip = false,
        skill_name = keektszjens.name,
        cancelable = true,
        skip=false,
      })
      if #discards<3 then
        room:loseHp(player,1,keektszjens.name)
      end
  end,
})

return keektszjens

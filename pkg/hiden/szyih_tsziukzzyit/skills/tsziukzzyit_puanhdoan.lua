local tsziukzzyit_puanhdoan = fk.CreateSkill {
  name = "tsziukzzyit_puanhdoan",
}

Fk:loadTranslationTable{
  -- ["puanhdoan"] = "反彈",
  ["#puanhdoan-effected"] = "%from 反彈生效 傷害轉給%tos",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 



tsziukzzyit_puanhdoan:addEffect(fk.DamageInflicted, {
  -- globle=true,
  is_delay_effect = true,
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and S.hasTsziukzzyit(player,"puanhdoan")
    and data.from 
    and data.from~=data.to
    and not data.from.dead
  end,
  on_trigger= function(self, event, target, player, data)
    local room = player.room
    player.room:sendLog{ type = "#puanhdoan-effected", from = player.id,tos={data.from.id}}
    data.to=data.from
    target = data.from
    room.logic:trigger(fk.DamageInflicted, data.from, data)
    -- data.prevented=true

    -- if player:usedSkillTimes(poavskvoeok.name, Player.HistoryTurn) ==1 then --on_use 後
    -- player:drawCards(1, poavskvoeok.name)--  --抽1
    -- end

    return true

  end,
})
return tsziukzzyit_puanhdoan


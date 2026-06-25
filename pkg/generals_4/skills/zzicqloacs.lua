local zzicqloacs = fk.CreateSkill {
  name = "zzicqloacs",
}

Fk:loadTranslationTable{
  ["zzicqloacs"] = "椉浪",
  [":zzicqloacs"] = "當牌進入任意角色伏區後,伱可發動至多x次(x爲牌數),伱抽1",  --任意角色?


  -- ["$zzicqloacs1"] = "椉",
}

-- local U = require "packages/utility/utility"

zzicqloacs:addEffect(fk.AfterCardsMove, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(zzicqloacs.name) 
  end,
  trigger_times = function(self, event, target, player, data)
    if event:getCostData(self) and event:getCostData(self).n then  
      return  event:getCostData(self).n 
    end

      local ids = {}
      for _, move in ipairs(data) do  --data move info
        if   move.toArea == Card.PlayerJudge
        then  
          for _, info in ipairs(move.moveInfo) do
              table.insertIfNeed(ids, info.cardId)
          end
        end
      end


    event:setCostData(self, {n=#ids, ids = ids})
    return #ids
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(1,zzicqloacs.name)
end,
})

return zzicqloacs

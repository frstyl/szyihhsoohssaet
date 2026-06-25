local skill = fk.CreateSkill {
  name = "loav_skill",
}

Fk:loadTranslationTable{
  ["@loav"] = "牢",
  ["@toSkipPhases"] = "越",

  ["#skipTurn"] = "%from 越過轉 牢餘%arg",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


skill:addEffect(fk.PreTurnStart, {
  -- name = "#loav",
  -- global = true,  --武將技不需 卡牌需要
  -- events = {fk.PreTurnStart},
  mute = true,
  priority = 0, -- game rule?

  can_refresh =  function(self, event, target, player, data)
    return player == target and target:getMark("@loav") > 0 
  end,
  on_refresh = function(self, event, target, player, data)
    local room=target.room
    target.room:removePlayerMark(target, "@loav", 1)
    if dat == nil then
      dat = {
        who = target,
        prevented=false,
      }
    end
    room.logic:trigger(fk.BeforeTurnOver, target, dat) --當作 SkipTurn event
    if dat.prevented then
      return false
    end
    data.turn_end=true
    target.room:sendLog{
      type = "#skipTurn",
      from = target.id,
      arg = target:getMark("@loav"),
    }

    room.logic:trigger(fk.TurnedOver, target, data)
    return true

end,
})
-- Fk:addSkill(loav)

skill:addEffect(fk.EventPhaseChanging, {
  -- name = "#loav",
  global = true,  --武將技不需 卡牌需要
  -- events = {fk.PreTurnStart},
  mute = true,
  priority = 0, -- game rule?

  can_refresh = Util.TrueFunc,  --function() return true end
  on_refresh = function(self, event, target, player, data)
    local t = table.simpleClone(target:getTableMark("@toSkipPhases"))
    if #t<=0 then return end
    for i, p in pairs(t) do
      if type(p)=="string" then 
        p=S.getPhaseClass(p)
      end
      if type(p)=="number" then
        if p==data.phase then
          data.skipped = true
          table.remove(t,i)
          if #t==0 then
          target.room:setPlayerMark(player,"@toSkipPhases",0)
            return
          end
          target.room:setPlayerMark(player,"@toSkipPhases",t)
          return
        end
      end
    end
    -- if table.contains(target:getTableMark("@toSkipPhases"), data.phase) then
    --   data.skipped = true
    --   target.room:removeTableMark(target,"@toSkipPhases",data.phase)  --removeOne
    -- end
end,
})

return skill


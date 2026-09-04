local hzoojqbjes = fk.CreateSkill({
  name = "hzoojqbjes",
  tags={Skill.Compulsory}
})

Fk:loadTranslationTable{
  ["hzoojqbjes"] = "回避",
  [":hzoojqbjes"] = "伱致或受傷後,必發,中止其轉",



  ["$hzoojqbjes1"] = "伱昰太乙三才陣何足爲奇",
  ["$hzoojqbjes2"] = "九宮八卦已无敵,河洛四像眞堪奇",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


hzoojqbjes:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return
      player:hasSkill(hzoojqbjes.name) 
      and (data.to == player or data.from==player)
  end,
  -- on_cost = function(self, event, target, player, data)
  --   return true
  -- end,
  on_use = function(self, event, target, player, data)
      player.room.logic:breakTurn()
      local room=player.room
      local e =  room.logic:getCurrentEvent()
      if not e or not e.parent then return end
      while true do
        if e.parent.event==GameEvent.Round then
          e:shutdown()
        else
          e= e.parent
        end
      end

  end,
})



return hzoojqbjes

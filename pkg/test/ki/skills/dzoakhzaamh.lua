local dzoakhzaamh = fk.CreateSkill {
  name = "dzoakhzaamh",
}

Fk:loadTranslationTable{
  ["dzoakhzaamh"] = "𣪲艦",
  [":dzoakhzaamh"] = "伱對其它脚色致傷旹伱選一項可發動:➀其執行1弃段➁當局其存牌數-1",

  -- ["MaxCards"] = "額度牌限",

  ["$dzoakhzaamh1"] = "哈哈哈哈哈哈哈哈！",
  ["$dzoakhzaamh2"] = "伯符，且看我这一手！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzoakhzaamh:addEffect(fk.Damage, {
  mute = true,
  can_trigger = function(self, event, target, player, data)
    return data.from == player and data.to~=player and player:hasSkill(dzoakhzaamh.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local choice = player.room:askToChoice(player, {
      choices={"discard","MaxCards"},
      skill_name=dzoakhzaamh.name,
      prompt="dzoakhzaamh-invoke:"..data.to.id,
      cancelable=true,
    })
    if choice then
      event:setCostData(self,{choice=choice,tos={data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to=data.to
    if event:getCostData(self).choice=="discard" then

      -- local discardNum = #table.filter(
      --   to:getCardIds(Player.Hand), function(id)
      --     local card = Fk:getCardById(id)
      --     return table.every(room.status_skills[MaxCardsSkill] or Util.DummyTable, function(skill)
      --       return not skill:excludeFrom(to, card)
      --     end)
      --   end
      -- ) - to:getMaxCards()
      -- room:broadcastProperty(to, "MaxCards")
      -- if discardNum > 0 then
      --   room:askToDiscard(to, {min_num = discardNum, max_num = discardNum, include_equip = false, skill_name = "phase_discard", cancelable = false})
      -- end
      data.to:gainAnExtraPhase(Player.Discard, dzoakhzaamh.name, false)
    else
      room:addPlayerMark(to, MarkEnum.MinusMaxCards, 1)
    end
  end,
})


return dzoakhzaamh

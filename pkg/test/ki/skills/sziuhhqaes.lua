local sziuhhqaes = fk.CreateSkill{
  name = "sziuhhqaes",
}

Fk:loadTranslationTable{
  ["sziuhhqaes"] = "守隘",
  [":sziuhhqaes"] = "每輪始旹,伱可發動｡伱牢+1,執行1補段｡伱越過轉後,伱執行1主段｡",
--加彊?

  -- ["#sziuhhqaes-invoke"] = "守隘 昰否打出1牌𠫓擊 %src",

  -- ["$sziuhhqaes1"] = "太歲頭上也敢動土",
  -- ["$sziuhhqaes2"] = "爺爺在此𠊱伱多旹了",
  -- ["$sziuhhqaes3"] = "進了昰蘆葦港伱還跑的掉",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"
-- local H = require "packages/hegemony/util"

sziuhhqaes:addEffect(fk.RoundStart, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(sziuhhqaes.name)
    -- and not H.allGeneralsRevealed(player)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    S.addLoav(player,1,sziuhhqaes.name)
    player:gainAnExtraPhase(Player.Draw, sziuhhqaes.name, false)
  end,
})

sziuhhqaes:addEffect(fk.TurnedOver, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(sziuhhqaes.name)
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    player:gainAnExtraPhase(Player.Play, sziuhhqaes.name, false)
  end,
})

return sziuhhqaes

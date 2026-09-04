
local phiocqkxims = fk.CreateSkill{
  name = "phiocqkxims",
  -- tags = { Skill.Compulsory },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos"

Fk:loadTranslationTable{
  ["phiocqkxims"] = "封禁",
  -- [":phiocqkxims"] = "",
--加彊?
  ["@phiocqkxims-phase"] = "封禁",
  ["phiocqkxims-use"] = "起動",
  ["phiocqkxims-response"] = "打出",
  ["phiocqkxims-discard"] = "弃置",

}



phiocqkxims:addEffect(fk.BeforeCardsMove, {
  anim_type = "control",
  can_refresh = function(self, event, target, player, data)
    if not table.contains(Fk:currentRoom():getBanner("phiocqkxims-phase") or {}, "phiocqkxims-discard") then return end

      for _, move in ipairs(data) do
        if fk.ReasonDiscard==move.moveReason
          -- and move.from == player 
          -- and move.toArea == Card.DiscardPile
          and
          move.proposer~=nil --系統弃牌?
        then
          return true
        end
      end

  end,
  on_refresh= function(self, event, target, player, data)
    player.room:cancelMove(data,nil)
    -- sendLog()
  end,
})
phiocqkxims:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    return      table.contains(Fk:currentRoom():getBanner("phiocqkxims-phase") or {}, "phiocqkxims-use")
  end,
  prohibit_response = function(self, player, card)
    return      table.contains(Fk:currentRoom():getBanner("phiocqkxims-phase") or {}, "phiocqkxims-response")
  end,
  prohibit_discard = function(self, player, card)
    return      table.contains(Fk:currentRoom():getBanner("phiocqkxims-phase") or {}, "phiocqkxims-discard")
  end,
})


return phiocqkxims

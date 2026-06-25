local hzoavqhqximh = fk.CreateSkill {
  name = "hzoavqhqximh",
}

Fk:loadTranslationTable{
  ["hzoavqhqximh"] = "𠢕飲",
  [":hzoavqhqximh"] = "額度抽牌前發動.伱視爲使用烈酒(无視次數),獲得1空",

  ["@jiudun_drank"] = "酒",
  ["#hzoavqhqximh-invoke"] = "𠢕飲：你可以摸一张牌，视为使用【酒】",
  ["#hzoavqhqximh-card"] = "𠢕飲：你可以弃置一张手牌，令%arg对你无效",

  ["$hzoavqhqximh1"] = "籍不胜酒力，恐失言失仪。",
  ["$hzoavqhqximh2"] = "秋月春风正好，不如大醉归去。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hzoavqhqximh:addEffect(fk.DrawNCards, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(hzoavqhqximh.name)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.n=data.n-1
      local ids= S.getKhouc(room,1)
    room:moveCards({
      ids = ids,
      to = player,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = player,
      skillName = hzoavqhqximh.name,
      moveVisible = true,
    })
    local card = Fk:cloneCard("tsiuh")

    card.skill = Fk.skills["ljet__tsiuh_skill"]
    local use = { ---@type UseCardDataSpec
    from = player,
    tos = tos,
    card = card,
    extraUse=true,
    }
    if not player:canUseTo(card, player, {bypass_distances = true, bypass_times = true}) then return end
    room:useCard(use)
  end,
})


hzoavqhqximh:addEffect(fk.TurnStart, {
  can_refresh = function (self, event, target, player, data)
    return player:getMark("@ljet_drank") > 0
  end,
  on_refresh = function (self, event, target, player, data)
    if target~=player then
    local n = player:getMark("@ljet_drank")
      player.drank = player.drank + n
      player.room:setPlayerMark(player,"@tsyis-turn",player.drank)
      player.room:broadcastProperty(player, "drank")
    else
      player.room:setPlayerMark(player, "@ljet_drank",  0)
    end
  end,
})

-- hzoavqhqximh:addEffect(fk.PreCardUse, {
--   global = true,
--   can_refresh = function(self, event, target, player, data)
--     return target == player and data.card.trueName == "ssaet" and player.drank > 0
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     data.additionalDamage = (data.additionalDamage or 0) + player.drank  --😓️
--     data.extra_data = data.extra_data or {}
--     data.extra_data.drankBuff = player.drank
--     player.drank = 0
--     room:setPlayerMark(player,"@tsyis-turn",0)
--     room:broadcastProperty(player, "drank")
--   end,
-- })

-- hzoavqhqximh:addEffect(fk.PreCardUse, {
--   can_refresh = function (self, event, target, player, data)
--     return target == player and data.card.trueName == "ssaet" and player:getMark("@jiudun_drank") > 0
--   end,
--   on_refresh = function (self, event, target, player, data)
--     player.room:setPlayerMark(player, "@ljet_drank",  0)
--   end,
-- })
return hzoavqhqximh

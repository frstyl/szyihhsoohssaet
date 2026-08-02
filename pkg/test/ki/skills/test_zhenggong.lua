local zhenggong = fk.CreateSkill{
  name = "tssaecqkouc",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tssaecqkouc"] = "迅测",
  [":tssaecqkouc"] = "锁定技，首轮开始时，你执行额外的回合。",
  ["$tssaecqkouc"] = "今疑兵之计，已搓敌兵心胆，其安敢侵近！",
}

zhenggong:addEffect(fk.GameStart, {--RoundStart
  priority=999,
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(zhenggong.name) 
  end,
  on_use = function(self, event, target, player, data)
    -- local room=player.room
    -- while not player.dead do
    --   -- if data.phase_end then break end

    --   -- logic:trigger(fk.BeforePlayCard, player, data)
    --   -- if data.phase_end then break end

    --   local dat = { timeout = room:getBanner("Timeout") and room:getBanner("Timeout")[tostring(player.id)] or room.timeout }
    --   -- logic:trigger(fk.StartPlayCard, player, dat, true)

    --   local req = Request:new(player, "PlayCard")
    --   req.timeout = dat.timeout
    --   local result = req:getResult(player)
    --   if result == "" then break end

    --   local useResult = room:handleUseCardReply(player, result)
    --   if type(useResult) == "table" then
    --     room:useCard(useResult)
    --   end
    -- end

      -- player:gainAnExtraPhase(Player.Play, zhenggong.name, false)
    player:gainAnExtraTurn(false, zhenggong.name, {Player.Play})

  end,
})

return zhenggong

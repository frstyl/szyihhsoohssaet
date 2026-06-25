local jiaktsjins = fk.CreateSkill{
  name = "jiaktsjins",
}

Fk:loadTranslationTable{
["jiaktsjins"] = "躍進",
[":jiaktsjins"] = "一角色轉始歬,若其手牌等于伱手牌數,伱可發動.伱執行1額外主段,此段內伱至其它角色距離爲1.拔籌:當伱致傷後,若若受傷角色當輪首次受傷,伱可發動.伱抽1",

["#jiaktsjins-invoke"] = "躍進 %src 轉始 是否發動",
["@@jiaktsjins"] = "躍進",
-- ["@@jiaktsjins-damaged-turn"] = "被拔籌",

["$jiaktsjins1"] = "等吾拿矣頭功再作打算",
["$jiaktsjins2"] = "兄弟,吾先行一步",
}

jiaktsjins:addEffect(fk.BeforeTurnStart, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return 
    -- target ~= player and 
    player:hasSkill(jiaktsjins.name) 
    and #player:getCardIds("h")==#target:getCardIds("h")
    -- and player:usedEffectTimes(self, Player.HistoryRound)==0
  end,
  on_cost = function(self, event, target, player, data)
        return player.room:askToSkillInvoke(player, {
      skill_name = jiaktsjins.name,
      prompt = "#jiaktsjins-invoke:"..target.id,
    }) 
  end,
  on_use = function(self, event, target, player, data)
    player.room:setPlayerMark(player,"@@jiaktsjins",1)
    player:gainAnExtraPhase(Player.Play, jiaktsjins.name, false)
    player.room:setPlayerMark(player,"@@jiaktsjins",nil)

      -- player.room:setPlayerMark(player,"@@jiaktsjins",1)
    -- player.room:setPlayerMark(player,"@@jiaktsjins-round",1)

    -- player:gainAnExtraTurn(false, jiaktsjins.name, {Player.Play,Player.Draw}, {jiaktsjins=player.id})
    -- player.room:setPlayerMark(player,"@@jiaktsjins",1)
  end,
})


jiaktsjins:addEffect("distance", {
  fixed_func = function(self, from, to)
    if from:getMark("@@jiaktsjins") >0 and to~=from then
      return 1
    end
  end,
})


jiaktsjins:addEffect(fk.Damage, {
  can_refresh = function(self, event, target, player, data)
    return target == player  and data.to:getMark("jiaktsjins-round")==0 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:setPlayerMark(data.to,"jiaktsjins-round",1)
      local damage_events = player.room.logic:getActualDamageEvents(1, function (e)
        return e.data.to == data.to
      end, Player.HistoryRound)
      if #damage_events == 1 and damage_events[1].data == data then
        event:setCostData(self,{jiaktsjins=true})
      end
  end,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(jiaktsjins.name)  and event:getCostData(self)
  end,
  on_use = function(self, event, target, player, data)
      player:drawCards(2,jiaktsjins.name)
  end,
})
-- jiaktsjins:addEffect(fk.TurnEnd, {
--   anim_type = "drawcard",
--   is_delay_effect = true,
--   can_trigger = function(self, event, target, player, data)
--     return  player:getMark("@@jiaktsjins") >0 
--   end,
--   on_use = function(self, event, target, player, data)
--       player:drawCards(2, jiaktsjins.name)
--   end,
-- })


return jiaktsjins

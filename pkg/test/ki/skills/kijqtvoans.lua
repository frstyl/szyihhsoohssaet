local kijqtvoans = fk.CreateSkill {
  name = "kijqtvoans",
}

Fk:loadTranslationTable{
  ["kijqtvoans"] = "機斷",
  [":kijqtvoans"] = "伱段終旹,伱可預打出x牌發動,伱選擇一項➀執行1同名段➁越過1轉下一段",

  ["#kijqtvoans_active"] = "機斷 %arg 打出 %arg2",

  ["kijqtvoans-again"] = "再次執行此段",
  ["kijqtvoans-to_skip"] = "越過下段",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 



kijqtvoans:addEffect(fk.EventPhaseEnd,{
  can_trigger = function(self, event, target, player, data)
    if  target == player and player:hasSkill(kijqtvoans.name) then
      return true
    end
  end,
  on_cost = function(self, event, target, player, data)
    local n =player:usedSkillTimes(kijqtvoans.name, Player.HistoryTurn)
    local success, dat = player.room:askToUseActiveSkill(player, {
      skill_name = "kijqtvoans_active",
      prompt = "#kijqtvoans_active:::"..Util.PhaseStrMapper(data.phase).. ":"..n,
      cancelable = true,
      skip = true,
    })
    if success and dat then
      event:setCostData(self, {cards = dat.cards, choice = dat.interaction})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    if #event:getCostData(self).cards>0 then
      -- room:throwCard(event:getCostData(self).cards, kijqtvoans.name, player, player)
       S.playCard(event:getCostData(self).cards, kijqtvoans.name,player)

    end
    if event:getCostData(self).choice=="kijqtvoans-again" then
      player:gainAnExtraPhase(data.phase,kijqtvoans.name,false)
    else
      room:setPlayerMark(player,"kijqtvoans_to_skip-turn",1)
    end
  end,
  }   
) --


kijqtvoans:addEffect(fk.EventPhaseChanging,{
  can_refresh = function(self, event, target, player, data)
    if  target == player and player:getMark("kijqtvoans_to_skip-turn")>0 then
      return true
    end
  end,
  on_refresh = function(self, event, target, player, data)
    data.skipped = true
    player.room:setPlayerMark(player,"kijqtvoans_to_skip-turn",0)
  end,

  }   
) --

return kijqtvoans

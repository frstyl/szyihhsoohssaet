local dvoatkhijs = fk.CreateSkill {
  name = "dvoatkhijs",
}

Fk:loadTranslationTable{
["dvoatkhijs"] = "奪气",
[":dvoatkhijs"] = "伱致傷後,若爲當轉內首次傷害事件,伱可發動,伱抽x｡x爲處理區牌數",
["#dvoatkhijs-invoke"]="奪气 抽 %src ",

}

dvoatkhijs:addEffect(fk.Damage, {  --第一次 致傷後 ? 第一次傷害事件/
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return data.from == player 
    and player:hasSkill(dvoatkhijs.name)
    and #player.room.logic:getActualDamageEvents(2,function()
      return true
    end,
    Player.HistoryTurn)<2
  end,
  on_cost = function(self, event, target, player, data)
    local n = #player.room.processing_area
    return player.room:askToSkillInvoke(player,{skill_name=dvoatkhijs.name,prompt="dvoatkhijs-invoke:"..n})
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(#player.room.processing_area)
  end,
})



return dvoatkhijs

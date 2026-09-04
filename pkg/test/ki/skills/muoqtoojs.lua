local muoqtoojs = fk.CreateSkill {
  name = "muoqtoojs",
  -- tags={Skill.Switch,},
}

Fk:loadTranslationTable{
["muoqtoojs"] = "无對",
[":muoqtoojs"] = "伱起動牌旹,(每轉輪流執行){➀伱可發動➁必發}其它脚色不可起動打出,持續1轉/迻除➀效果,伱取得起動牌(子牌)",

["@@muoqtoojs-turn"] = "无對",

}


muoqtoojs:addEffect(fk.CardUsing, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
   return target==player and ( player:hasSkill(muoqtoojs.name)  )   --再發動 需有技能
  end,
  on_cost = function(self, event, target, player, data)
    -- -- local check = false
    -- -- local n = 0
    -- player.room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
    --   check = not check
    --   -- n=n+1
    -- end, Player.HistoryTurn)
    -- -- player:drawCards(n)
    local n =player:getMark("muoqtoojs-turn")
    if n==1 or player.room:askToSkillInvoke(player, { skill_name = muoqtoojs.name }) then
      event:setCostData(self,{switch_state=n})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    if event:getCostData(self).switch_state==0 then
      room:setPlayerMark(player,"muoqtoojs-turn", 1)
      for _, p in ipairs(room:getOtherPlayers(player)) do
        room:addPlayerMark(p,"@@muoqtoojs-turn", 1)
      end
    else
      room:setPlayerMark(player,"muoqtoojs-turn", 0)
      for _, p in ipairs(room:getOtherPlayers(player)) do
        room:removePlayerMark(p,"@@muoqtoojs-turn", 1)
      end
      if not player.dead  and player.room:getCardArea(data.card) == Card.Processing then --and not data.card:isRuleVirtual()
        player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, muoqtoojs.name)
      end
    end
  end,
})

muoqtoojs:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@@muoqtoojs-turn")~=0 then return true end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@@muoqtoojs-turn")~=0 then return true end
  end,
})

return muoqtoojs

local toeocqsjen = fk.CreateSkill {
  name = "toeocqsjen",
}

Fk:loadTranslationTable{
  ["toeocqsjen"] = "登仙",
  [":toeocqsjen"] = "伱挩離瀕死後,伱可發動｡伱選擇1項:抽2;回1;當局體力上限+1;當局額定抽牌數+1;當局存牌數+1｡",

  ["toeocqsjen-drawN"] = "額定抽牌數+1",
  ["#toeocqsjen-ask"] = "登仙 選擇發動",
}

toeocqsjen:addEffect(fk.AfterDying, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(toeocqsjen.name)
  end,
  on_cost = function(self, event, target, player, data)
    local all={"draw2","recover","MaxHp","MaxCards","toeocqsjen-drawN"}
    local choice=player.room:askToChoice(target, {choices = all, skill_name = toeocqsjen.name, prompt = "#toeocqsjen-ask",cancelable=true})
    if choice~="Cancel" then
      event:setCostData(self,{choice=choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
     local choice=event:getCostData(self).choice
     if choice == "draw2" then
      target:drawCards(2,toeocqsjen.name)
     elseif choice == "recover" and target:isWounded() and  not target.dead  then
      room:recover{
        who = target,
        num = 1,
        recoverBy = target,
        skillName = toeocqsjen.name,
      }
    elseif choice == "MaxCards"  then
      room:addPlayerMark(target,MarkEnum.AddMaxCards,1)
    elseif  choice == "MaxHp"  then
      room:changeMaxHp(target,1)
    elseif   choice == "toeocqsjen-drawN"  then
      room:addPlayerMark(target,"@add_phase_draw",1)

    end
  end,
})


-- toeocqsjen:addEffect(fk.DrawNCards, {
--   can_refresh = function(self, event, target, player, data)
--     return target==player and player:getMark("@add_phase_draw")~=0
--   end,
--   on_refresh = function(self, event, target, player, data)
--     data.n=data.n+player:getMark("@add_phase_draw")
--   end
-- })

return toeocqsjen

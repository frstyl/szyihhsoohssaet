local piucshsiap = fk.CreateSkill{
  name = "piucshsiap",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["piucshsiap"] = "諷脅",
  [":piucshsiap"] = "其它角色額度抽牌後,若其{手牌數}不小于{伱与其體力值之和},伱可發動,其選擇➀交予伱1殺1閃➁牢+1",

  ["#piucshsiap-invoke"] = "諷脅 是否對 %src發動",
  ["#piucshsiap_active"] = "諷脅 選擇一殺一閃交予%src 或牢+1",

  ["$piucshsiap1"] = "我欲行夏禹旧事，为天下人。",

}

piucshsiap:addEffect(fk.AfterDrawNCards, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target~=player and player:hasSkill(piucshsiap.name) and not target.dead
    and #target:getCardIds("h")>=(player.hp+target.hp)
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = piucshsiap.name,
      prompt = "#piucshsiap-invoke:"..target.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    local yes, dat = room:askToUseActiveSkill(target, {  --askToChooseCardsAndPlayers 等實調用此 askToUseActiveSkill
      skill_name = "piucshsiap_active",
      prompt = "#piucshsiap_active:"..player.id,
      cancelable = true,
      skip = true,  --不執行
      extra_data={
        from=player.id
      }
    })
    if yes and dat and dat.cards then  
      room:moveCardTo(dat.cards, Player.Hand, player, fk.ReasonGive, piucshsiap.name,nil,false,target.to)
    else
    room:addPlayerMark(target,"@loav",1)
    end
  end,
})



return piucshsiap

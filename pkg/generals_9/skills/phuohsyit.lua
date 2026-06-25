local phuohsyit = fk.CreateSkill {
  name = "phuohsyit",
}

Fk:loadTranslationTable{
  ["phuohsyit"] = "抚恤",
  [":phuohsyit"] = "任一角色受殺所致傷後，若其未陣亡,你可發動至多x次(x爲傷害值).令其判定，判定牌生效後,若其爲{紅,伱可選➀打出1紅手牌令其回1➁打出1黑手牌終止當前段(不中止結算)/黑,伱令其得判定牌,伱抽1}",

  ["#phuohsyit-discard"] = "抚恤：%src  受到 %arg 伤害，你可以弃置一张 紅手牌 令其回復1",

  ["$phuohsyit1"] = "將軍䀆忠之心,吾定當稟報天子",
  ["$phuohsyit2"] = "下官擔保諸位英雄莫拆散分開",
  ["$phuohsyit3"] = "元景先飲此盃与眾義士看",
}

phuohsyit:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(phuohsyit.name) and data.card and data.card.trueName == "ssaet" and not target.dead
  end,
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judge = {
      who = target,
      reason = "phuohsyit",
      pattern = "",
      -- skipDrop=true
    }
    room:judge(judge)
    if not judge.card then return end
    if judge.card.color == Card.NoColor then return end
    if judge.card.color == Card.Black then
      -- if not target.dead and room:getCardArea(judge.card) == Card.Processing then --DiscardPile
      --   room:obtainCard(target, judge.card, true, fk.ReasonJustMove, player, phuohsyit.name)
      -- end
      player:drawCards(1, phuohsyit.name)
      return  --加速
    --end
    elseif judge.card.color == Card.Red then
      -- room:moveCardTo(judge.card, Card.DiscardPile, nil, fk.ReasonJudge,phuohsyit.name)
      if   target.dead then  return end
      local cards=room:askToCards(player,{
        min_num=1,
        max_num=1,
        include_equip=false,
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(id)
          return Fk:getCardById(id).color ~= Card.NoColor and not player:prohibitResponse(Fk:getCardById(id))
        end
        ) }),
        prompt = "#phuohsyit-discard:" .. target.id .. "::" .. data.card:toLogString(),
        cancelable = true,
      })
      if #cards==0 then return end
      --2
        -- room:throwCard(cards, gxeqmoon.name, player, player)  
        local card = Fk:getCardById(cards[1])
        room:responseCard({
          card=card,
          from=player,
          attachedSkillAndUser={muteCard=true},
        })

        -- room:throwCard(dat.cards, phuohsyit.name, player, player)  
        if card.color == Card.Red and not target.dead then
          room:recover{
            who = target,
            num = 1,
            recoverBy = player,
            skillName = phuohsyit.name,
          }
        else
          player:endCurrentPhase()
        end
    
    end
  end,
})


phuohsyit:addEffect(fk.FinishJudge, {  --旹機
  mute = true,
  is_delay_effect = true,
  can_trigger = function(self, event, target, player, data)
    return  data.reason == phuohsyit.name and data.card and data.card.color == Card.Black and
      player.room:getCardArea(data.card) == Card.Processing
      and not data.who.dead
  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(data.who, data.card, true, fk.ReasonJustMove, nil, phuohsyit.name)
  end,
})

return phuohsyit

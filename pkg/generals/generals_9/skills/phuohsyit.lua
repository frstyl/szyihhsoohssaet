local phuohsyit = fk.CreateSkill {
  name = "phuohsyit",
}

Fk:loadTranslationTable{
  ["phuohsyit"] = "抚恤",
  [":phuohsyit"] = "一脚色受殺所致傷後，若其未陣亡,你可發動至多x次(x爲傷害值).令其占卜，若其爲:紅,伱可選投出1紅手牌回其1 或投出1黑手牌終止當前段(不中止結算);黑,伱令其取得占卜牌,伱抽1",

  ["#phuohsyit-discard"] = "抚恤：%src  受到 %arg 伤害，你可以弃置一张 紅手牌 其回復1",

  ["$phuohsyit1"] = "將軍䀆忠之心,吾定當稟報天子",
  ["$phuohsyit2"] = "下官擔保諸位英雄莫拆散分開",
  ["$phuohsyit3"] = "元景先飲此盃与眾義士看",
}

phuohsyit:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(phuohsyit.name) and data.card and data.card.trueName == "ssaet" and not data.to.dead
  end,
  trigger_times = function(self, event, target, player, data)
    return data.damage
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local judge = {
      who = data.to,
      reason = "phuohsyit",
      pattern = "",
      -- skipDrop=true
    }
    room:judge(judge)
    if not judge.card then return end
    if judge.card.color == Card.NoColor then return end
    if judge.card.color == Card.Black then
      if not data.to.dead and room:getCardArea(judge.card) == Card.DiscardPile then --DiscardPile
        room:obtainCard(data.to, judge.card, true, fk.ReasonPrey, nil, phuohsyit.name)
      end

      if not player.dead then player:drawCards(1, phuohsyit.name) end
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
         S.playCard(cards, biukkeek.name,player)


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


-- phuohsyit:addEffect(fk.FinishJudge, {  --旹機
--   mute = true,
--   is_delay_effect = true,
--   can_trigger = function(self, event, target, player, data)
--     return  data.reason == phuohsyit.name and data.card and data.card.color == Card.Black and
--       player.room:getCardArea(data.card) == Card.Processing
--       and not data.who.dead
--   end,
--   on_use = function(self, event, target, player, data)
--     player.room:obtainCard(data.who, data.card, true, fk.ReasonPrey, nil, phuohsyit.name)
--   end,
-- })

return phuohsyit

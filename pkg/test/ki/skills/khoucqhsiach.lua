local meecqhsiach = fk.CreateSkill {
  name = "meecqhsiach",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["meecqhsiach"] = "空響",
  [":meecqhsiach"] = "應動｡其它脚色發動技能A旹,伱可➀發動,獲得1空,以此記錄A｡➁投出牌記錄A者發動,發動无效",

  ["#meecqhsiach-invoke"] = "空響 %src 發動技能 %arg, 伱可獲得空或无效之 ",

  ["#preventSkill"] = "%tos 所發動 %arg 被 %from  防止 ",

  ["@meecqhsiach"] = "空響",

  ["$meecqhsiach1"] = "人身疾苦，与我无异。",
  ["$meecqhsiach2"] = "医以济世，其术贵在精诚。",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

meecqhsiach:addEffect(fk.SkillEffect, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(meecqhsiach.name) and target and
      data.skill:isPlayerSkill(target) and data.skill ~= self 
      -- and target:hasSkill(data.skill:getSkeleton().name, true, true) 
  end,
  on_cost= function(self, event, target, player, data)
    local room = player.room
    local ids=table.filter(player:getCardIds("h"),function(id)
      local c = Fk:getCardById(id)
      return Fk:getCardById(id):getMark("@meecqhsiach")==data.skill:getSkeleton().name and not  player:prohibitResponse(Fk:getCardById(id))
    end)
    local yes, ret = room:askToUseActiveSkill(player, {
      skill_name = "choose_cards_skill", 
      prompt = "#meecqhsiach-invoke:"..data.who.id.."::"..data.skill:getSkeleton().name, 
      cancelable = true, 
      extra_data = {
        num = 1,
        min_num = 0,
        include_equip = false,
        skillName = meecqhsiach.name,
        pattern =tostring(Exppattern{ id = ids}),
      }, 
      no_indicate = false,
      skip=true,

    })
    if yes then 
      event:setCostData(self, {cards = ret.cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room 
    local cards = event:getCostData(self).cards
    if #cards>0 then
      player.room:responseCard({
        card=Fk:getCardById(cards[1]),
        from=player,
        attachedSkillAndUser={muteCard=true},
      })
      room:sendLog{
        type = "#preventSkill",
        from = player.id,
        tos = {data.who.id},
        arg= data.skill:getSkeleton().name,
      }
      data.prevent=true
    else
      local ids = S.getKhouc(1)
      room:setCardMark(Fk:getCardById(ids[1]),"@meecqhsiach",data.skill:getSkeleton().name)
      room:moveCards({
        ids = ids,
        to = player,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonJustMove,
        proposer = player,
        skillName = meecqhsiach.name,
        moveVisible = true,
      })  
    end
  end,
})

return meecqhsiach

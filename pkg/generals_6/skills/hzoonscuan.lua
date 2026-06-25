local hzoonscuan = fk.CreateSkill {
  name = "hzoonscuan",
  -- tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["hzoonscuan"] = "溷元",
  [":hzoonscuan"] = "自限:全場唯一.鎖定.任一角色體力變化後,必發.伱將牌堆頂x牌置于伱武將牌上,稱爲熵",  --規則技?


  ["#hzoonscuan-invoke"] = "溷元 以熵 交換 %dest %arg 判定",
  ["hzoonscuan_sziac"] = "熵",

  ["$hzoonscuan1"] = "今进退两难，势若溷元，魏王必当罢兵而还。",
  ["$hzoonscuan2"] = "汝可令士卒收拾行装，魏王明日必定退兵。",
}

-- local U = require "packages/utility/utility"

hzoonscuan:addEffect(fk.HpChanged, {
  derived_piles = "hzoonscuan_sziac",
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hzoonscuan.name) and data.num~=0 and not data.prevented
  end,
  on_use = function(self, event, target, player, data)
    -- player:drawCards(2,hzoonscuan.name)
    local cards=player.room:getNCards(math.abs(data.num))
    player:addToPile("hzoonscuan_sziac", cards, true, hzoonscuan.name)

  end,
})


hzoonscuan:addEffect(fk.AskForRetrial, {
  anim_type = "control",
  can_trigger = function (self, event, target, player, data)
    return player:hasSkill(hzoonscuan.name)
    and #player:getPile("hzoonscuan_sziac")>0
  end,
  on_cost = function (self, event, target, player, data)
    local room=player.room
    local pile=player:getPile("hzoonscuan_sziac")
    local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = hzoonscuan.name,
        pattern = tostring(Exppattern{ id = pile }),
        prompt = "#hzoonscuan-invoke::"..target.id..":"..data.reason,
        expand_pile = pile,
      })
    if #cards == 1 then
      event:setCostData(self, {tos = {target}, cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local moveInfos={}
    local newId =event:getCostData(self).cards[1]
    table.insert(moveInfos,{  --改判
      ids = {newId}, --id list
      from = player,
      toArea = Card.Processing,
      moveReason = fk.ReasonExchange,
      skillName = hzoonscuan.name,
      proposer = player,
    })

  
    table.insert(moveInfos,{---@type CardsMoveInfo
      ids = data.card:isVirtual() and data.card.subcards or { data.card.id },
      to =  player ,
      toArea = Card.PlayerSpecial,
      moveReason = fk.ReasonExchange,
      skillName = hzoonscuan.name,
      specialName = "hzoonscuan_sziac",
      moveVisible = true,
      proposer = player,
    } )

    room:moveCards(table.unpack(moveInfos))

    room:sendLog{
      type = "#ChangedJudge",
      from = player.id,
      to = {data.who.id}, --判定者
      arg2 = Fk:getCardById(newId):toLogString(),  --改判用牌
      arg = hzoonscuan.name
    }
    room:filterCard(newId, target, true)
    data.card = Fk:getCardById(newId)  --id

  end,
})
return hzoonscuan

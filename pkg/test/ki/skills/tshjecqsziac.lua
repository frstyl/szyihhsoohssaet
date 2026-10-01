local tshjecqsziac = fk.CreateSkill{
  name = "tshjecqsziac",
  -- tags={Skill.Limited},
  add_skills={"operate_card_skill"}
}

Fk:loadTranslationTable{
  ["tshjecqsziac"] = "淸商",
  [":tshjecqsziac"] = "伱抽牌後,伱可展示1手牌發動｡伱占卜,若色与伱所展示相同,伱令1脚色抽1｡因此所抽牌1轉无視存牌數",  --

  ["#tshjecqsziac-invoke"] = "淸商：  選擇手牌發動",
  ["#tshjecqsziac-choose"] = "淸商： 令1脚色抽1",

}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


tshjecqsziac:addEffect(S.AfterOperateCard, {
  priority=-1,--AfterDrawCard
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(tshjecqsziac.name) 
    and data.type==fk.ReasonDraw
    and target==player
  end,

  on_cost = function(self, event, target, player, data)
    local cards = player.room:askToCards(player, { ---@type AskToCardsParams
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = tshjecqsziac.name,
      cancelable = false,
      pattern = ".|.|.|hand",
      prompt = "#tshjecqsziac-invoke"
    })
    if #cards>0 then
      event:setCostData(self,{cards=cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local cards =event:getCostData(self).cards
    player:showCards(cards)
    if player.dead then return end

    local judge = {
        who = player,
        reason = tshjecqsziac.name,
        pattern = ".|.|.",
      }
              -- pattern =".|.|"..card:getSuitString()"

    room:judge(judge)
    if player.dead then return end
    local suit =judge.card.color
    for _,id in ipairs(cards) do
      if suit==Fk:getCardById(id).color then 
        local to = room:askToChoosePlayers(player, {
          targets = room.alive_players,
          min_num = 1,
          max_num = 1,
          prompt = "#tshjecqsziac-choose",
          skill_name = tshjecqsziac.name,
          cancelable = true,
        })
        if #to>0 then
          to[1]:drawCards(1, tshjecqsziac.name,nil,{"@@tshjecqsziac-inhand-turn",1 , "exclude-inhand-turn",1})
        else
          player:drawCards(1, tshjecqsziac.name,nil,{"@@tshjecqsziac-inhand-turn",1 , "exclude-inhand-turn",1})
        end
        return
      end
    end
  end,
})

-- tshjecqsziac:addEffect(fk.BeforeDrawCard, {  --被防止

return tshjecqsziac

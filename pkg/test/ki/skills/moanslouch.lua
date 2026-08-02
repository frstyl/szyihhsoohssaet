local moanslouch = fk.CreateSkill {
  name = "moanslouch",
  tags={Skill.Switch},
}

Fk:loadTranslationTable{
  ["moanslouch"] = "漫籠",
  [":moanslouch"] = "伱受傷後,伱可選擇弃牌堆1牌發動｡伱取得之",

  ["#moanslouch-invoke"] = "漫籠：自弃牌堆中選擇 %arg 牌獲得",
  ["#moanslouch-prey"] = "漫籠：獲得其1",
}



moanslouch:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function (self, event, target, player, data)
    return target == player and player:hasSkill(moanslouch.name)
  end,
  on_cost = function (self, event, target, player, data)
    local color=( player:getSwitchSkillState(moanslouch.name)== fk.SwitchYang) and Card.Red or Card.Black
    if not player.room:askToSkillInvoke(player, {
      skill_name = moanslouch.name,
      prompt = "#moanslouch-invoke:::"..(color==Card.Red and "red"or "black"),
    }) then return end
    local room = player.room
    local cards = table.filter(room.discard_pile, function (id)
      return Fk:getCardById(id).color == color
    end)
    if #cards==0 then return end
    local card = room:askToChooseCards(player, {
      target = player,
      min=0,
      max=1,
      flag = { card_data = {{ "pile_discard", cards }} },
      skill_name = moanslouch.name,
      prompt = "#moanslouch-prey",
      cancelable=true,
    })
    if #card>0 then
    event:setCostData(self,{cards=card})
    return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local card=event:getCostData(self).cards
    player.room:moveCardTo(card, Card.PlayerHand, player, fk.ReasonPrey, moanslouch.name, nil, true, player)
  end,
})


return moanslouch

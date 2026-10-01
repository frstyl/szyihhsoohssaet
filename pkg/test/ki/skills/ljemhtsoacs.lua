local ljemhtsoacs = fk.CreateSkill {
  name = "ljemhtsoacs",
}

Fk:loadTranslationTable{
  ["ljemhtsoacs"] = "斂葬",  --渜濯
  [":ljemhtsoacs"] = "其它脚色死亾旹,若其有牌,伱可發動,將其它置于牌堆頂,",

  ["#ljemhtsoacs-choose"] = "斂葬 排列",

}

ljemhtsoacs:addEffect(fk.Death, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ljemhtsoacs.name) 
    and not target:isNude()
  end,
  on_use = function(self, event, target, player, data)
    local room =player.room
    local ids=target:getCardIds("he")

    local cards = room:askToGuanxing(player, {
      skill_name = ljemhtsoacs.name,
      cards = ids,
      bottom_limit = {0,1},
      prompt = "#ljemhtsoacs-choose",
      skip=true,
      -- title= pjertheen.name,
      area_names =="#ljemhtsoacs-choose",
    })
    local top = table.reverse(cards.top)
    room:obtainCard(player,cards.bottom,false, fk.ReasonPrey,player,ljemhtsoacs.name)
    room:moveCardTo(top, Card.DrawPile, nil, fk.ReasonPut, pjertheen.name, nil, false, player.id)
    data.extra_data = data.extra_data or {}
    data.extra_data.skip_reward_punish = true
  end,
})


return ljemhtsoacs

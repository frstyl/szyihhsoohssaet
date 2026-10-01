local zjipmuoh = fk.CreateSkill {
  name = "zjipmuoh",
  tags = { Skill.Quest },
  derived_piles = "zjipmuoh-muoh",  
}

Fk:loadTranslationTable{
  ["zjipmuoh"] = "習武",
  [":zjipmuoh"] = "➀伱起動實體牌後,若起動牌与伱將牌上牌不同花,伱可發動,伱將起動牌置于伱將牌上,伱抽1➁印牌:以伱1牌轉化起動｢殺｣",


  ["$zjipmuoh1"] = "破阵杀敌，愿献犬马之劳！",
  ["$zjipmuoh2"] = "虎啸既响，厭迮当附！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos"



zjipmuoh:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#zjipmuoh-active",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.find(player:getPile("zjipmuoh-muoh"), function(id) return Fk:getCardById(to_select).suit==Fk:getCardById(id).suit end)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = zjipmuoh.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_response = function(self, player, response)
    return  true
  end,
})

zjipmuoh:addEffect(fk.CardUseFinished, {
  anim_type = "support",
  audio_index = { 1, 2 },
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(zjipmuoh.name) and target==player
    and data.card.suit~=Card.NoSuit
    and not data.card:isVirtual() 
    and Fk:getCardById(data.card.id,true).suit==data.card.suit
    and not table.find(player:getPile("zjipmuoh-muoh"), function(id) return data.card.suit==Fk:getCardById(id).suit end)
  end,

  on_use = function(self, event, target, player, data)
    local room=player.room
      if room:getCardArea(data.card) == Card.Processing then
          player:addToPile("zjipmuoh-muoh", data.card, true, zjipmuoh.name) 
        if player.dead then return end
      end
      player:drawCards(1,zjipmuoh.name) 

  end,
})

zjipmuoh:addEffect(fk.TurnEnd, {
  audio_index = { 4, 5 },
  can_trigger = function(self, event, target, player, data)
    if  player:hasSkill(zjipmuoh.name) then
      for i=1,4,1 do
        if not table.find(player:getPile("zjipmuoh-muoh"), function(id) return Fk:getCardById(id).suit==i end) then return end
      end
      return true
    end
  end,
  on_cost = Util.TrueFunc,
  on_use = function(self, event, target, player, data)
    player:drawCards(3,zjipmuoh.name)
    room:updateQuestSkillState(player, zjipmuoh.name)

  end,
})

zjipmuoh:addEffect(fk.EnterDying, {
  audio_index = { 4, 5 },
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(zjipmuoh.name) 
  end,
  on_cost = Util.TrueFunc,
  on_use = function(self, event, target, player, data)
    room:updateQuestSkillState(player, zjipmuoh.name, true)
    -- room:invalidateSkill(player, zjipmuoh.name)
  end,
})
return zjipmuoh

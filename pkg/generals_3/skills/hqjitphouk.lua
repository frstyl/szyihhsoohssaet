local hqjitphouk = fk.CreateSkill {
  name = "hqjitphouk",
}
Fk:loadTranslationTable{
  ["hqjitphouk"] = "一撲",
  [":hqjitphouk"] = "伱可將2手牌轉化爲殺使用發動.此殺致傷旹,若伱不在受傷角色攻程內,傷害值+1",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

hqjitphouk:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#hqjitphouk",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return  #selected == 0 or 
      (#selected == 1 
      and 
      -- Fk:getCardById(to_select).type == Fk:getCardById(selected[1]).type
            Fk:getCardById(to_select):compareColorWith(Fk:getCardById(selected[1]), true))

  end,
  view_as = function(self, player, cards)
    if #cards ~= 2 then return  end
    local c = Fk:cloneCard("ssaet")
    c.skillName = hqjitphouk.name
    c:addSubcards(cards)
    S.mixCard(c)
    c:addMark("hqjitphouk",player.id)
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response) 
    return  not response 
  end,
})

hqjitphouk:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and card.skillNames and table.contains(card.skillNames, hqjitphouk.name)
  end,
})

hqjitphouk:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    return player == data.to and data.card and table.contains(data.card.skillNames, hqjitphouk.name) 
    and not player:inMyAttackRange(player.room:getPlayerById(data.card:getMark("hqjitphouk")))
  end,
  on_trigger  = function(self, event, target, player, data)
    player.room:sendLog{ type = "#changeDamageBySkill", from = data.to.id, arg = hqjitphouk.name ,arg2=1}
    data:changeDamage(1)
    S.changeDamage({damageData=data,num=1,skillName=hqjitphouk.name})
end,
})
return hqjitphouk

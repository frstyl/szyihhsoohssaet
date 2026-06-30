local thoohsjins = fk.CreateSkill {
  name = "thoohsjins",
}

Fk:loadTranslationTable{
  ["thoohsjins"] = "吐信",
  [":thoohsjins"] = "伱可使用殺旹伱可預將1類爲A之牌轉化爲殺使用發動.吐信殺无視距離且致傷旹,伱可發動.展示受傷者全部牌,弃全部A類,若弃牌數大于2,伱流失1體力",

  ["#thoohsjins-invoke"] = "吐信 是否對 %src 發動 0牌确定則其弃牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

thoohsjins:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet",
  prompt = "#thoohsjins",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0--默認裝僃
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = thoohsjins.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response = function(self, player, response)
    return  not response
  end,
})


thoohsjins:addEffect("targetmod", {
  bypass_distances = function(self, player, skill, card)
    return card and table.contains(card.skillNames, thoohsjins.name)
  end,
})


thoohsjins:addEffect(fk.DamageCaused, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  target==player and player:hasSkill(thoohsjins.name)
    and data.card
    and table.contains(data.card.skillNames, thoohsjins.name) 
  end,
  -- on_cost = function(self, event, target, player, data)
  --   local room = player.room
  --   local yes, ret = room:askToUseActiveSkill(player, {
  --     skill_name = "discard_skill", 
  --     prompt = "#thoohsjins-invoke:"..data.to.id, 
  --     cancelable = true, 
  --     extra_data = {
  --       num = 1,
  --       min_num = 0,
  --       include_equip = false,
  --       skillName = thoohsjins.name,
  --       pattern = ".",
  --     }, 
  --     no_indicate = false,
  --   skip=true,

  --   })
  --   if yes then 
  --     event:setCostData(self, {cards = ret.cards})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)
    if data.to.dead  or player.dead then return end
    local room=player.room

    -- if  #event:getCostData(self).cards ==0 then
      local cards=data.to:getCardIds("he")
      data.to:showCards(cards)
      local throw={}
      local typ=S.getCardTypeByName(Fk:getCardById(data.card.subcards[1]).name)
      for _,cid in ipairs(cards) do
        card=Fk:getCardById(cid)
        if card.type==typ then 
          table.insert(throw,cid)
        end
      end
      local n=#throw
      room:throwCard(throw, thoohsjins.name, data.to, player)  --新來者不計?
      if n>2 and not player.dead then
        room:loseHp(player,1,thoohsjins.name,player)
      end
    -- elseif #event:getCostData(self).cards ==1 then
    --   player.room:throwCard(event:getCostData(self).cards, thoohsjins.name, player, player)
    --   player.room:setPlayerMark(data.to,"@@dook",1)
    --   -- Fk:addSkill(Fk.skills["dook"])
    -- room:addSkill("dook_rule")

    -- end
  end,
})


return thoohsjins

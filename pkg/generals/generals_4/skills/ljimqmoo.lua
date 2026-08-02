local ljimqmoo = fk.CreateSkill {
  name = "ljimqmoo",
  tags = { Skill.Compulsory },
  derived_piles = "ljimqmoo_dzis",
}

Fk:loadTranslationTable{
["ljimqmoo"] = "臨摹",
[":ljimqmoo"] = "➀當一元實牌A起動結算完旹(若其在処理區),伱可發動,將A置于伱武將牌上稱爲「字」➁伱轉終旹,若｢字｣數大于伱體力值,必發,伱廢置超出部分,➂印牌:以伱1牌轉化爲1｢字｣起動(同名同花色同點數)｡起動前廢置此｢字｣",
-- [":ljimqmoo"] = "➀當一牌A因起動結算完從処理區進入弃牌堆歬,若A目幖包含伱,伱可發動,將A置于伱武將牌上稱爲「字」➁當伱可起動一牌,若字中有之且伱有牌,伱可發動.將廢置此字,將1牌轉化爲此字起動(同名同花色同點數)｡➂轉終,廢置全部字",
-- [":ljimqmoo"] = "➀當一元實牌A起動結算完旹,若A目幖包含伱或伱至起動者距離不大于1,必發,將A置于伱武將牌上稱爲「字」➁轉終,若字數大于伱體力值,必發,伱廢置超出部分,印取x空(x爲所廢置字所含花色數)➂印牌:以伱1牌轉化爲某字起動(同名同花色同點數)｡廢置某字發動｡",

["ljimqmoo_dzis"] = "字",

["#ljimqmoo-remove"] = "保留 %arg 字",

}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 



ljimqmoo:addEffect("viewas", {
  -- anim_type = "control",
  pattern = ".", --无目幖牌
  expand_pile = "ljimqmoo_dzis",
  handly_pile=true,
  card_filter = function(self, player, to_select, selected)
    return (#selected == 0 and table.contains(player:getPile("ljimqmoo_dzis"), to_select))
     or 
  (#selected == 1 and not table.contains(player:getPile("ljimqmoo_dzis"), to_select))
  end,
  view_as = function(self, player, cards)
    if #cards ~= 2 then return end
    -- player.room:setPlayerMark(player,"_ljimqmoo_dzis",{cards[1]})
    local card = Fk:getCardById(cards[1])
    -- card.setMark()
    local c = Fk:cloneCard(card.name, card.suit, card.number)
    c.skillName = ljimqmoo.name
    c:addSubcard(cards[2])  --傳數據id 1爲字 --addFakeSubcards
    c.color=card.color
    c.suit=card.suit
    c.number=card.number
    c:addFakeSubcard(cards[1])
    return c
  end,
  before_use = function(self, player, use)
    player.room:moveCardTo(use.card.fake_subcards, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, ljimqmoo.name, nil, true, player)
  end,
  enabled_at_response = function (self, player, response)
    return not response
  end,
  enabled_at_nullification = function (self, player, cardEffectData)
    if #player:getPile("ljimqmoo_dzis")==0 then return end
    if Fk.currentResponsePattern==nil then return true end

    for _, id in ipairs(player:getPile("ljimqmoo_dzis")) do
      if Exppattern:Parse(Fk.currentResponsePattern):match(Fk:getCardById(id))  then return true end
    end
    
  end,
})
--算技能?

-- CardUseFinished BeforeCardsMove
ljimqmoo:addEffect(fk.CardUseFinished, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ljimqmoo.name) 
      and not data.card:isVirtual()
      and data.card.name == Fk:getCardById(data.card.id, true).name    --Utility.isPureCard
      and player.room:getCardArea(data.card) == Card.Processing 
      -- and (table.contains(data.tos, player) or player:compareDistance(data.from,1,"<="))
  end,
  on_use = function(self, event, target, player, data)
    player:addToPile("ljimqmoo_dzis", data.card, true, ljimqmoo.name) 
end,
})

ljimqmoo:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ljimqmoo.name) and
      #player:getPile("ljimqmoo_dzis") >player.hp
  end,
  on_cost = Util.TrueFunc,  --必發 --能否單獨加tag
  on_use = function(self, event, target, player, data)
      local room=player.room
      local cards = player.room:askToChooseCards(player, {
        target = player,
        min = player.hp,
        max = player.hp,
        flag = {
          card_data = {{"ljimqmoo_dzis", player:getPile("ljimqmoo_dzis")}}
        },
        prompt = "#ljimqmoo-remove:::"..player.hp,
        skill_name = ljimqmoo.name,
      })
      local remove={}
      -- local suits={}
      -- for _, id in ipairs(player:getPile("ljimqmoo_dzis")) do
      --   if not table.contains(cards,id) then
      --     table.insert(remove,id)
      --     table.insertIfNeed(suits,Fk:getCardById(id).suit)
      --   end
      -- end
    -- table.removeOne(suits,Card.NoSuit)
    player.room:moveCardTo(remove, Card.DiscardPile, nil, fk.ReasonPutIntoDiscardPile, ljimqmoo.name, nil, true, player)
    -- local ids= S.getKhouc(room,#suits)
    -- room:moveCards({
    --   ids = ids,
    --   to = player,
    --   toArea = Card.PlayerHand,
    --   moveReason = fk.ReasonJustMove,
    --   proposer = player,
    --   skillName = ljimqmoo.name,
    --   moveVisible = true,
    -- })
  end,
  })
return ljimqmoo

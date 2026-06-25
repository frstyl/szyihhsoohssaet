local ceenqjiak = fk.CreateSkill {
  name = "ceenqjiak",
}

Fk:loadTranslationTable{
  ["ceenqjiak"] = "研藥",
  [":ceenqjiak"] = "伱可將黑殺轉化爲雷殺,紅牌轉化爲火殺使用發動.伱使用屬性殺无視距離",

  ["#ceenqjiak-active"] = "研藥：将一张牌转化为任意基本牌使用",

  ["$ceenqjiak1"] = "一炮就送伱輩歸天",
  ["$ceenqjiak2"] = "不投降就去死夫",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

ceenqjiak:addEffect("viewas", {
  max_phase_use_time = 1,
  prompt = "#ceenqjiak-active",
  pattern = "ssaet",
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    if #selected == 0  then
      local c =Fk:getCardById(to_select)
      return c.color~=Card.NoColor
    -- return (c.trueName=="ssaet" or table.contains({2,3},S.getCardTypeByName(c.name)))
    --and Fk:getCardById(to_select).color~=Card.NoColor --and Fk:getCardById(to_select).trueName=="ssaet"
    end
  end,
  view_as = function(self, player, cards)
    if  #cards ~= 1 then return end
    local c =Fk:getCardById(cards[1])
    local card
    -- if c.name=="ssaet" then
      if c.color == Card.Black then
        card = Fk:cloneCard("thunder__ssaet")
      elseif c.color == Card.Red  then
        card = Fk:cloneCard("fire__ssaet")
      end
    -- elseif S.getCardTypeByName(c.name)==2 then
    --     card = Fk:cloneCard("thunder__ssaet")
    -- elseif S.getCardTypeByName(c.name)==3 then
    --     card = Fk:cloneCard("fire__ssaet")
    -- end
    card:addSubcard(cards[1])
    card.skillName = ceenqjiak.name
    return card
  end,
  enabled_at_play = function(self, player)
    return not response
  end,
})

-- ceenqjiak:addEffect(fk.PreCardUse, {
--   anim_type = "drawcard",
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:hasSkill(ceenqjiak.name)
--     and (data.card.name=="thunder__ssaet" or data.card.name=="fire__ssaet")
--   end,
--   on_use = function(self, event, target, player, data)
--     if data.card.name=="thunder__ssaet" then
--     -- data.to:addQinggangTag(data)  --function igrore
--     data.unoffsetableList = table.simpleClone(room.players)
--   elseif  data.card.name=="fire__ssaet"  then
--     data.additionalDamage = (data.additionalDamage or 0) + 1
--   end
--   end,
-- })

-- ceenqjiak:addEffect("targetmod", {
--   bypass_distances = function(self, player, skill, card)
--     return card and (card.name=="thunder__ssaet" or card.name=="fire__ssaet")
--   end,
-- })

return ceenqjiak

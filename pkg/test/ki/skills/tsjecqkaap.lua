
local tsjecqkaap = fk.CreateSkill{
  name = "tsjecqkaap",
  tags = {Skill.Composite},
}

Fk:loadTranslationTable{
  ["tsjecqkaap"] = "精甲",
  [":tsjecqkaap"] = "恆續,若伱裝僃區爲某花牌,伱同花｢殺｣次數上限+1",

}

local S = require "packages/szyihhsoohssaet/szyih_guos"


tsjecqkaap:addEffect("targetmod", {
  residue_func = function(self, player, skill, scope,card, to)

    if player:hasSkill(tsjecqkaap.name) and  card.trueName == "ssaet"  and card.suit~=Card.NoSuit and #player:getCardIds("e")>0 then
      for _,id in ipairs(player:getCardIds("e")) do
      -- for _,equip in ipairs(S.getEquips(player)) do
      local equip=Fk:getCardById(id)
        if card.suit==equip.suit then
          return 1
        end
      end
    end
  end,
})

tsjecqkaap:addEffect("maxcards", {
  correct_func = function(self, player)
    if player:hasSkill(tsjecqkaap.name) and #player:getCardIds("e")>0 then
      -- return #player:getCardIds("e")
      local n={}
            for _,id in ipairs(player:getCardIds("e")) do
            -- for _,equip in ipairs(S.getEquips(player)) do
            local equip=Fk:getCardById(id)
              if card.suit~=Card.NoSuit then
                table.insertIfNeed(n, card.suit)
              end
            end
            return #n
    end
  end,
})

tsjecqkaap:addEffect("atkrange", {
  correct_func = function(self, from, to)
    if player:hasSkill(tsjecqkaap.name) and #player:getCardIds("e")>0 then
      -- return #player:getCardIds("e")
      local n={}
            for _,id in ipairs(player:getCardIds("e")) do
            -- for _,equip in ipairs(S.getEquips(player)) do
            local equip=Fk:getCardById(id)
              if card.color~=Card.NoColor then
                table.insertIfNeed(n, card.color)
              end
            end
            return #n
    end
  end,
})
return tsjecqkaap

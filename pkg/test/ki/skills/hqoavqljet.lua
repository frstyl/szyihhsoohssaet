local hqoavqljet = fk.CreateSkill {
  name = "hqoavqljet",
}

Fk:loadTranslationTable{
["hqoavqljet"] = "鏖烈",
[":hqoavqljet"] = "伱失去軍器牌後,伱可展示之發動(多牌多次)伱抽1｡",


}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

hqoavqljet:addEffect(fk.AfterCardsMove, {
  can_trigger = function(self, event, target, player, data)
    if not player:hasSkill(hqoavqljet.name) then return end
  end,
  trigger_times = function(self, event, target, player, data)
    local id =player.id
    if event:getCostData(self) and event:getCostData(self)[id] then return event:getCostData(self)[id] end
    local n=0
    for _, move in ipairs(data) do
      if move.from ==player and (move.to~=player or not table.contains({Card.PlayerEquip,Card.PlayerHand }, move.toArea)) then
        for _, info in ipairs(move.moveInfo) do
          if   (info.fromArea == Card.PlayerHand or info.fromArea == Card.PlayerEquip)  and (S.getCardTypeByName(info.beforeCard.trueName)==3 )then
            n=n+1
          end
        end
      end
    end
    if n>0 then
      event:setCostData(self, {id = n})
    end
    return n
  end,

  on_use = function(self, event, target, player, data)
    -- to:showCards(event:getCostData(slef).cards
    player:drawCards(1, hqoavqljet.name)
  end,
})

return hqoavqljet

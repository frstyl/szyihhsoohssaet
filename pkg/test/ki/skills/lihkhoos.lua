local lihkhoos = fk.CreateSkill {
  name = "lihkhoos",
}

Fk:loadTranslationTable{
  ["lihkhoos"] = "理庫",
  [":lihkhoos"] = "印牌:打出1至多牌,元實起動或演練牌堆中1牌(卽旹基本,与所打出牌點數同餘于13)",

  ["#lihkhoos"] = "理庫：先選擇所需之牌 可用",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

lihkhoos:addAcquireEffect(function(self, player)
  player.room:handleAddLoseSkills(player, "lihkhoos_active&", nil, false, true)
end)

lihkhoos:addLoseEffect(function(self, player, isDeath)
  if not isDeath then
    player.room:handleAddLoseSkills(player, "-lihkhoos_active&", nil, false, true)
  end
end)


lihkhoos:addEffect("viewas", {
  pattern = ".|.|.|.|.|.",
  prompt = "#lihkhoos",
  interaction = function(self, player)
    if player:getMark("lihkhoos-phase") ~=0 then
      local name =  Fk:getCardById(player:getMark("lihkhoos-phase") ).trueName 
      return UI.CardNameBox { choices = {name}, all_choices = {name} }
    end
    local all_names = Fk:getAllCardNames("bt")
    local names = player:getViewAsCardNames(lihkhoos.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox { choices = names, all_choices = all_names,defaulut=names[#names] }
  end,
  handly_pile = false,
  expand_pile = function(self, player)
    if player:getMark("lihkhoos-phase") ~=0 then return {player:getMark("lihkhoos-phase")} end
    if not self.interaction.data then return {} end
    local ids =table.filter(Fk:currentRoom().draw_pile,function(id) return Fk:getCardById(id).trueName== self.interaction.data  end)
    return ids
  end,
  card_filter = function(self, player, to_select, selected)
    if not self.interaction.data then return  end
    -- local ids =self.expand_pile or {}
    if #selected==0 then return not table.contains(player:getCardIds("he"),to_select) end
    return true
  end,
  view_as = function (self, player, cards)
    if #cards< 2  or self.interaction.data == nil then return end
    local n = 0
    for i=2,#cards,1 do
      n=n+Fk:getCardById(cards[i]).number
    end
    if n%13 ==Fk:getCardById(cards[1]).number%13 then
      return Fk:getCardById(cards[1])
    end
  end,
  on_use = function(self, room, cardUseEvent, card, params) 
    local player = cardUseEvent.from
    local tos =cardUseEvent.tos
    local cards =cardUseEvent.cards
    
    local ids = table.simpleClone(cards)
    table.remove(ids,1)
    S.playCard(ids, lihkhoos.name,player)

    local use = {
      from = cardUseEvent.from,
      card = Fk:getCardById(cards[1]),
    }
    if param and param.is_response then use.tos = {} end
    return use
  end,
  -- before_use = function (self, player, use)
  -- end,
  enabled_at_response = function(self, player, response)
    return not response and not player:isNude()
  end,
  enabled_at_nullification = function(self, player, data)
    if not self:enabledAtResponse(player, false) then return end

    local all_names =  table.filter(Fk:getAllCardNames("bt"), function(name)
      return S.isCommonTrick(name)
    end)

    return true
  end,
})

return lihkhoos

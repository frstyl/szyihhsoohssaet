local test__pujqtszjim = fk.CreateSkill{
  name = "test__pujqtszjim",
}

Fk:loadTranslationTable{
  ["test__pujqtszjim"] = "飛針",
  [":pujqtszjim"] = "印牌:以一脚色裝僃區內1{武器/非武器}轉化起動或演練{閃/殺}",


  ["#test__pujqtszjim"] = "飛針：裝僃僃區武器轉化爲殺」 非武器轉化爲「閃」",

  ["$test__pujqtszjim1"] = "飛針走線,小事一樁",
  ["$test__pujqtszjim2"] = "針銀閃動,戰袍已新",
}
-- viewas peo khoah
test__pujqtszjim:addEffect("viewas", {
  pattern = "ssaet,szjemh",
  anim_type = "defensive",
  prompt = "#test__pujqtszjim",
  interaction = function(self, player)
    local ps=Fk:currentRoom().alive_players
    ps=table.map(ps, function(p)
        return (p.seat)
      end)
    table.sort(ps)
    ps=table.map(ps,function(p)
      return tostring(p)
    end)
    return UI.ComboBox {
      choices = ps,  --爲何數字傳不了 止能default
      default=tostring(player.seat)
    }
  end,

  expand_pile = function(self, player)
    local n=tonumber(self.interaction.data)
    if not n or n ==player.seat then  return {} end

    -- local p=Fk:currentRoom():getPlayerById(n )
    local p=Fk:currentRoom():getPlayerBySeat(n)
    if not p then return {} end
    if #p:getCardIds("e")>0  then
      return p:getCardIds("e")
    else 
      return {}
    end
    -- end

    end,
  card_filter = function(self, player, to_select, selected)  --可選 後有可用占卜
    local n=tonumber(self.interaction.data)
    if #selected == 0 
    and (n==player.seat and table.contains(player:getCardIds("e"), to_select) 
    or Fk:currentRoom():getPlayerBySeat(n ) and 
    table.contains(Fk:currentRoom():getPlayerBySeat(n ):getCardIds("e"), to_select) )
    --and not player:getCardIds(),
    then
      local _c = Fk:getCardById(to_select)
      local c
      if _c.sub_type == Card.SubtypeWeapon then
        c = Fk:cloneCard("ssaet")
      elseif _c.sub_type == Card.SubtypeDefensiveRide 
      or _c.sub_type == Card.SubtypeOffensiveRide
      or _c.sub_type == Card.SubtypeArmor
      or _c.sub_type == Card.SubtypeTreasure then
        c = Fk:cloneCard("szjemh")
      else
        return false
      end
      return  (Fk.currentResponsePattern == nil and c.skill:canUse(player, c)) or
      Fk.currentResponsePattern and Exppattern:Parse(Fk.currentResponsePattern):match(c)
    end
  end,

  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local card
    if Fk:getCardById(cards[1]).sub_type == Card.SubtypeWeapon then
      card = Fk:cloneCard("ssaet")
    elseif Fk:getCardById(cards[1])then
      card = Fk:cloneCard("szjemh")
    end
    card.skillName = test__pujqtszjim.name
    card:addSubcard(cards[1]) --s?
    return card
  end,


})



return test__pujqtszjim

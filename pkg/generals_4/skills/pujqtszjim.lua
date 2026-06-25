local pujqtszjim = fk.CreateSkill{
  name = "pujqtszjim",
}

Fk:loadTranslationTable{
  ["pujqtszjim"] = "飛針",
  [":pujqtszjim"] = "當伱可使用打出{閃/殺},伱可選擇一角色裝僃區內1{武器/非武器}轉化{閃/殺}發動,伱使用打出之",


  ["#pujqtszjim"] = "飛針：裝僃僃區武器轉化爲殺」 非武器轉化爲「閃」",

  ["$pujqtszjim1"] = "飛針走線,小事一樁",
  ["$pujqtszjim2"] = "針銀閃動,戰袍已新",
}
-- viewas peo khoah
pujqtszjim:addEffect("viewas", {
  pattern = "ssaet,szjemh",
  anim_type = "defensive",
  prompt = "#pujqtszjim",
  interaction = function(self, player)
    local ps={}
    for _, p in ipairs(Fk:currentRoom().alive_players) do
      if #p:getCardIds("e")>0 then
        table.insert(ps,tostring(p.seat)..">"..":"..p.id)
      end
    end

    return UI.ComboBox {
      choices = ps,
      default=tostring(player.seat)
    }
  end,
  expand_pile = function(self, player)
    if not self.interaction.data then return {} end

    -- local n=tonumber(self.interaction.data)
    -- if not n or n ==player.seat then  return {} end

    -- -- local p=Fk:currentRoom():getPlayerById(n )
    -- local p=Fk:currentRoom():getPlayerBySeat(n)
    local p = Fk:currentRoom():getPlayerBySeat(tonumber(self.interaction.data:split(">")[1]))
    if not p or p==player then return {} end  --默認展開裝僃屰天
    if #p:getCardIds("e")>0  then
      return p:getCardIds("e")
    else 
      return {}
    end
    -- end

    end,
  card_filter = function(self, player, to_select, selected)  --可選 後有可用判定
    if not self.interaction.data then return end
    if #selected ~= 0  then return end
    
    if table.contains(Fk:currentRoom():getPlayerBySeat(tonumber(self.interaction.data:split(">")[1])):getCardIds("e"), to_select) 
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
      return  (Fk.currentResponsePattern == nil and c.skill:canUse(player, c)) or  --不必要
      Fk.currentResponsePattern and Exppattern:Parse(Fk.currentResponsePattern):match(c)
    end
  end,

  view_as = function(self, player, cards)
    if not self.interaction.data then return end
    if #cards ~= 1 then return end
    local card
    if Fk:getCardById(cards[1]).sub_type == Card.SubtypeWeapon then
      card = Fk:cloneCard("ssaet")
    elseif Fk:getCardById(cards[1])then
      card = Fk:cloneCard("szjemh")
    end
    card.skillName = pujqtszjim.name
    card:addSubcard(cards[1]) --s?
    return card
  end,


})



return pujqtszjim

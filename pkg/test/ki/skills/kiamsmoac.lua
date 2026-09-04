local kiamsmoac = fk.CreateSkill{
  name = "kiamsmoac",
}


Fk:loadTranslationTable{
  ["kiamsmoac"] = "劍芒",
  [":kiamsmoac"] = "印牌:消耗1｢殺｣𠟇餘次數,虛擬起動或演練｢{殺/酒➀}｣",
  -- [":kiamsmoac"] = "自限:擁有技能｢結緣｣｡印牌:交与結緣脚色1紅/黑牌,虛擬起動或演練殺/閃",

  ["#kiamsmoac-invoke"] = "劍芒 選擇目幖",

  ["$kiamsmoac1"] = "无物結劍芒",

}


kiamsmoac:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh,tsiuh,nziuk",  --,
  prompt = "#kiamsmoac",
  mute_card = true,
  interaction = function(self, player)
    local all_names = {"ssaet", "tsiuh"}  --, "nziuk", "tsiuh"
    local names = player:getViewAsCardNames(kiamsmoac.name, all_names)
    return  UI.CardNameBox {choices =  names, all_choices = all_names }
    -- return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  card_filter = function(self, player, to_select, selected)
    return false
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local c = Fk:cloneCard(self.interaction.data)
    c.skillName = kiamsmoac.name
    return c
  end,
  before_use = function (self, player, use)
    player:addCardUseHistory("ssaet", 1)
  end,
  enabled_at_play = function(self, player)
     return Fk:cloneCard("ssaet").skill:getMaxUseTime(player, Player.HistoryPhase, Fk:cloneCard("ssaet"))  -player:usedCardTimes("ssaet", Player.HistoryPhase) >0
  end,
  enabled_at_response = function(self, player, response) 
     return Fk:cloneCard("ssaet").skill:getMaxUseTime(player, Player.HistoryPhase, Fk:cloneCard("ssaet"))  -player:usedCardTimes("ssaet", Player.HistoryPhase) >0 
  end,
})


return kiamsmoac

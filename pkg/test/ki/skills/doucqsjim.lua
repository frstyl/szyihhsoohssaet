local doucqsjim = fk.CreateSkill{
  name = "doucqsjim",
}


Fk:loadTranslationTable{
  ["doucqsjim"] = "同心",
  [":doucqsjim"] = "自限:擁有技能｢結緣｣｡印牌:交与結緣脚色1紅/黑牌,虛擬起動演練殺/閃",

  ["#doucqsjim-invoke"] = "同心 選擇目幖",

  ["$doucqsjim1"] = "无物結同心",

}


doucqsjim:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh",  --,tsiuh,nziuk
  prompt = "#doucqsjim",
  -- mute_card = true,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh"}  --, "nziuk", "tsiuh"
    local names = player:getViewAsCardNames(doucqsjim.name, all_names)
    return  UI.CardNameBox {choices =  names, all_choices = all_names }
    -- return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  card_filter = function(self, player, to_select, selected)
    if  #selected ~= 0  then return end
    return 
     (self.interaction.data =="szjemh" and Fk:getCardById(to_select).color == Card.Black)
    or (self.interaction.data =="ssaet" and Fk:getCardById(to_select).color == Card.Red)
    -- (self.interaction.data =="nziuk" and Fk:getCardById(to_select).color == Card.Red)
    -- or (self.interaction.data =="szjemh" and Fk:getCardById(to_select).color == Card.Red)
    -- or (self.interaction.data =="ssaet" and Fk:getCardById(to_select).color == Card.Black)
    -- or (self.interaction.data =="tsiuh" and Fk:getCardById(to_select).color == Card.Black)
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local c = Fk:cloneCard(self.interaction.data)
    c.skillName = doucqsjim.name
    c:addFakeSubcards(cards)
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room
    local tos = table.map(player:getTableMark("@doucqsjim"),Util.Id2PlayerMapper)
    tos = table.filter(tos,function(p)return not p.dead end)

    if #tos>1 then 
    tos=room:askToChoosePlayers(player, {
      targets = tos,
      min_num = 1,
      max_num = 1,
      prompt = "#doucqsjim-choose",
      skill_name = doucqsjim.name,
      cancelable=false,
    })
    end
    room:moveCardTo(use.card.fake_subcards, Player.Hand, tos[1], fk.ReasonGive, doucqsjim.name, nil, false, player)

  end,
  enabled_at_play = function(self, player)
    local tos = table.filter(player:getTableMark("@doucqsjim"),function(p)
    return not Fk:currentRoom():getPlayerById(p).dead end)
    return #tos>0  
  end,
  enabled_at_response = function(self, player, response)  --終止旹機/流程條件 爲  --每旹機(用牌元因如瀕死)限1次
    local tos = table.filter(player:getTableMark("@doucqsjim"),function(p)
    return not Fk:currentRoom():getPlayerById(p).dead end)
    return #tos>0  
  end,
})


return doucqsjim

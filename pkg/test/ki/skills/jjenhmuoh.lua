local jjenhmuoh = fk.CreateSkill{
  name = "jjenhmuoh",
}


Fk:loadTranslationTable{
  ["jjenhmuoh"] = "演武",
  [":jjenhmuoh"] = "印牌:以伱1{♦️/♣️/♠️/♥️}起動或演練｢{殺/閃/肉/酒}｣",
  -- [":jjenhmuoh"] = "自限:擁有技能｢結緣｣｡印牌:交与結緣脚色1紅/黑牌,虛擬起動或演練殺/閃",

  ["#jjenhmuoh-invoke"] = "演武 選擇目幖",

  ["$jjenhmuoh1"] = "无物結演武",

}


jjenhmuoh:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh,tsiuh,nziuk",  --,
  prompt = "#jjenhmuoh",
  mute_card = true,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh","nziuk", "tsiuh"}  --, 
    local names = player:getViewAsCardNames(jjenhmuoh.name, all_names)
    return  UI.CardNameBox {choices =  names, all_choices = all_names }
    -- return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  include_equip=true,
  card_filter = function(self, player, to_select, selected)
    if  #selected ~= 0  then return end
    return 
    --  (self.interaction.data =="szjemh" and Fk:getCardById(to_select).color == Card.Black)
    -- or (self.interaction.data =="ssaet" and Fk:getCardById(to_select).color == Card.Red)
    (self.interaction.data =="nziuk" and Fk:getCardById(to_select).color == Card.Spade)
    or (self.interaction.data =="szjemh" and Fk:getCardById(to_select).color == Card.Club)
    or (self.interaction.data =="ssaet" and Fk:getCardById(to_select).color == Card.Diamon)
    or (self.interaction.data =="tsiuh" and Fk:getCardById(to_select).color == Card.Heart)
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local c = Fk:cloneCard(self.interaction.data)
    c.skillName = jjenhmuoh.name
    -- c:addFakeSubcard(cards[1])
    c:addSubcard(cards[1])
    return c
  end,
  -- before_use = function (self, player, use)
  --   local room = player.room
  --   local tos = table.map(player:getTableMark("@jjenhmuoh"),Util.Id2PlayerMapper)
  --   tos = table.filter(tos,function(p)return not p.dead end)

  --   if #tos>1 then 
  --   tos=room:askToChoosePlayers(player, {
  --     targets = tos,
  --     min_num = 1,
  --     max_num = 1,
  --     prompt = "#jjenhmuoh-choose",
  --     skill_name = jjenhmuoh.name,
  --     cancelable=false,
  --   })
  --   end
  --   room:moveCardTo(use.card.fake_subcards, Player.Hand, tos[1], fk.ReasonGive, jjenhmuoh.name, nil, false, player)

  -- end,
  -- enabled_at_play = function(self, player)
  --   local tos = table.filter(player:getTableMark("@jjenhmuoh"),function(p)
  --   return not Fk:currentRoom():getPlayerById(p).dead end)
  --   return #tos>0  
  -- end,
  -- enabled_at_response = function(self, player, response) 
  --   local tos = table.filter(player:getTableMark("@jjenhmuoh"),function(p)
  --   return not Fk:currentRoom():getPlayerById(p).dead end)
  --   return #tos>0  
  -- end,
})


return jjenhmuoh

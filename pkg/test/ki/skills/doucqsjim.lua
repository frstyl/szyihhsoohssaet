local doucqsjim = fk.CreateSkill{
  name = "doucqsjim",
}


Fk:loadTranslationTable{
  ["doucqsjim"] = "同心",
  [":doucqsjim"] = "印牌:以伱1{♦️/♣️/♠️/♥️}起動或演練｢{殺/閃/肉/酒}｣",
  -- [":doucqsjim"] = "自限:擁有技能｢結緣｣｡印牌:交与結緣脚色1紅/黑牌,虛擬起動或演練殺/閃",

  -- ["#doucqsjim-invoke"] = "演武 選擇目幖",

  ["$doucqsjim1"] = "无物結演武",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


doucqsjim:addEffect("viewas", {
  anim_type = "offensive",
  pattern = ".|.|.|.|ssaet,szjemh,tsiuh,nziuk",  --,
  prompt = "#doucqsjim",
  mute_card = true,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh", "nziuk", "tsiuh"}
    local names = player:getViewAsCardNames(doucqsjim.name, all_names)
    return  UI.CardNameBox {choices =  names, all_choices = all_names }
    -- return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  include_equip=true,
  card_filter = function(self, player, to_select, selected)
    if  #selected ~= 0  then return end
    return 
    --  (self.interaction.data =="szjemh" and Fk:getCardById(to_select).color == Card.Black)
    -- or (self.interaction.data =="ssaet" and Fk:getCardById(to_select).color == Card.Red)
    (self.interaction.data =="nziuk" and Fk:getCardById(to_select).suit == Card.Spade)
    or (self.interaction.data =="szjemh" and Fk:getCardById(to_select).suit == Card.Club)
    or (self.interaction.data =="ssaet" and Fk:getCardById(to_select).suit == Card.Diamon)
    or (self.interaction.data =="tsiuh" and Fk:getCardById(to_select).suit == Card.Heart)
  end,
  feasible = function(self, player, selected, selected_cards, card)
    return true
  end,
  on_cost = function(self, player, data, extra_data)
    player:drawCards(2)
    local room=player.room
    local tos = table.map(player:getTableMark("@doucqsjim"),Util.Id2PlayerMapper)
    tos = table.filter(tos,function(p)return not p.dead and not p:isNude() end)

    if #tos<=0 then return end
    if #tos >1 then
      tos=room:askToChoosePlayers(player, {
        targets = tos,
        min_num = 1,
        max_num = 1,
        prompt = "#doucqsjim-choose",
        skill_name = doucqsjim.name,
        cancelable=false,
      })
    end
    local cards= room:askToCards(tos[1],{
      min_num=1,
      max_num=1,
      pattern=".|.|^nosuit"
    })
    -- table.insert(data.cards, cards[1])
    local subsubcards={data.cards[1], cards[1]}
    local use =  room:askToUseVirtualCard(player,{
      name=self.interaction.data,
      subcards=subsubcards,
      extra_data=extra_data,
      skip=true,
      skill_name=self.name,
    })
    data.cards=subsubcards
    if use then data.tos=use.tos end
    return {}
    
  end,
  on_use = function(self, room, skillUseEvent, card, params)

      local c = Fk:cloneCard(self.interaction.data)
      c:addSubcards(skillUseEvent.cards)
      S.mixCard(c)
      c.skillName = self.name
          local new_use={
          from = skillUseEvent.from,
          tos = skillUseEvent.tos,
          card = c,
      }
      return new_use
  end,
  view_as = function(self, player, cards)
    return nil
    -- if not self.interaction.data then return nil end
    -- local c = Fk:cloneCard(self.interaction.data)
    -- c.skillName = doucqsjim.name
    -- -- c:addFakeSubcard(cards[1])
    -- c:addSubcard(cards[1])
    -- return c
  end,
  -- before_use = function (self, player, use)
  --   local room = player.room
  --   local tos = table.map(player:getTableMark("@doucqsjim"),Util.Id2PlayerMapper)
  --   tos = table.filter(tos,function(p)return not p.dead end)

  --   if #tos>1 then 
  --   tos=room:askToChoosePlayers(player, {
  --     targets = tos,
  --     min_num = 1,
  --     max_num = 1,
  --     prompt = "#doucqsjim-choose",
  --     skill_name = doucqsjim.name,
  --     cancelable=false,
  --   })
  --   end
  --   room:moveCardTo(use.card.fake_subcards, Player.Hand, tos[1], fk.ReasonGive, doucqsjim.name, nil, false, player)

  -- end,
  enabled_at_play = function(self, player)
    local tos = table.filter(player:getTableMark("@doucqsjim"),function(p)
    return not Fk:currentRoom():getPlayerById(p).dead end)
    return #tos>0  
  end,
  enabled_at_response = function(self, player, response) 
    local tos = table.filter(player:getTableMark("@doucqsjim"),function(p)
    return not Fk:currentRoom():getPlayerById(p).dead end)
    return #tos>0  
  end,
})


return doucqsjim

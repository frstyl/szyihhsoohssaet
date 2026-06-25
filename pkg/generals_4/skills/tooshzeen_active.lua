local tooshzeen_active = fk.CreateSkill({
  name = "tooshzeen_active",
})

tooshzeen_active:addEffect("active", {
  mute = true,
  interaction = function(self,player)
    all={"tooshzeen-get:"..self.from,"tooshzeen-show:::"..self.number}
    local choices={} 
    if Fk:currentRoom():getPlayerById(self.from).dead then choices ={"tooshzeen-show:::"..self.number} else choices=all end
    return UI.ComboBox {choices = choices,all_choices }
  end,
  card_num =  function(self)
    return self.interaction.data=="tooshzeen-get:"..self.from and 1 or 0
  end,
  target_num = 0,
  -- expand_pile = extra_data.extra_ids,

  card_filter = function (self, player, to_select, selected)
    return (self.interaction.data=="tooshzeen-get:"..self.from and  #selected == 0 and Fk:getCardById(to_select).suit==Card.Club)
    or false
  end,
  target_filter = Util.FalseFunc,
})


return tooshzeen_active

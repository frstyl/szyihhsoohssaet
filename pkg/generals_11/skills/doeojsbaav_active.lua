local doeojsbaav_active = fk.CreateSkill({
  name = "doeojsbaav_active",
})

doeojsbaav_active:addEffect("active", {  --代庖選牌
  mute = true,
  min_card_num = 1,
  -- max_card_num = function(self, player)
  --   return self.extra_data.n 
  -- end,
  target_num = 0,
  -- expand_pile = extra_data.extra_ids,
  card_filter = function (self, player, to_select, selected)
    if  player:prohibitDiscard(to_select)  then return end
    if #selected==0  then return Fk:getCardById(to_select).color ~=Card.NoColor end
    if  Fk:getCardById(to_select).color==Fk:getCardById(selected[1]).color then 
      return (Fk:getCardById(to_select).color==Card.Black and #selected <self.n) --??
      or (Fk:getCardById(to_select).color==Card.Red )
    end
  end,
})


return doeojsbaav_active

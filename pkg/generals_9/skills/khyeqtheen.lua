local khyeqtheen = fk.CreateSkill{
  name = "khyeqtheen",
}

Fk:loadTranslationTable{
  ["khyeqtheen"] = "窺天",
  [":khyeqtheen"] = "伱{預段/末段}始旹伱可發動｡伱觀看牌堆頂2牌,將之緟排序置于牌堆頂或牌堆底",

  ["$khyeqtheen1"] = "一眼望天謀定而後動",
  ["$khyeqtheen2"] = "略施小計可一通天下",
}
khyeqtheen:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(khyeqtheen.name) and
    (player.phase == Player.Start or player.phase == Player.Finish )
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local result = room:askToGuanxing(player, { cards = room:getNCards(2)})
  end,
})

return khyeqtheen

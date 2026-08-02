local loavhleens = fk.CreateSkill{
  name = "loavhleens",
}


Fk:loadTranslationTable{
["loavhleens"] = "老練",  --下藥
[":loavhleens"] = "一脚色起動酒肉旹伱可選擇1其它脚色發動.伱對其起動虛擬迷",  --任意脚色起動旹?

["#loavhleens-choose"] = "老練 選擇攻程內其他脚色 其不可起動打出殺閃",
}
loavhleens:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return   player:hasSkill(loavhleens.name) 
    -- and target == player
    and
      (data.card.trueName=="nziuk" or       data.card.trueName=="tsiuh")
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local tos = room:askToChoosePlayers(player,{
      targets=room:getOtherPlayers(player),
      min_num=1,
      max_num=1,
      cancelable=true,
      prompt = "#loavhleens-choose",
    })
    if #tos ~= 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- local room = player.room
    -- player:drawCards(1,loavhleens.name)
    player.room:useVirtualCard("meej", nil, player, event:getCostData(self).tos, loavhleens.name, true)
  end,
})




return loavhleens

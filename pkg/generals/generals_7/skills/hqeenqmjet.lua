local hqeenqmjet = fk.CreateSkill {
  name = "hqeenqmjet",
}

Fk:loadTranslationTable{
["hqeenqmjet"] = "湮滅",  --湮滅
[":hqeenqmjet"] = "伱受傷後,伱可指定1其它脚色發動,伱對其起動虛擬｢水攻｣.恆續,伱起動｢水攻｣改爲由伱選擇",

["#hqeenqmjet-choose"]="湮滅 對1其它脚色起動虛擬｢水攻｣",
}


hqeenqmjet:addEffect(fk.Damaged, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(hqeenqmjet.name) 
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
		local tos = room:askToChoosePlayers(player,{
      targets=room:getOtherPlayers(player),
      min_num=1,
      max_num=1,
      cancelable=true,
      prompt = "#hqeenqmjet-choose",
    })
    if #tos ~= 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:useVirtualCard("szyih_kouc", nil, player, event:getCostData(self).tos, hqeenqmjet.name, true)
  end,
})


hqeenqmjet:addEffect(fk.PreCardEffect, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(hqeenqmjet.name) and data.from == player and data.card.trueName == "szyih_kouc"
  end,
  on_trigger = function(self, event, target, player, data)
    local card = data.card:clone()
    local c = table.simpleClone(data.card)
    for k, v in pairs(c) do
      card[k] = v
    end
    card.skill = Fk.skills["hqeenqmjet__szyih_kouc_skill"]
    data.card = card
  end,
})

return hqeenqmjet

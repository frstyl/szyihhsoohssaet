local hzoojsddxins = fk.CreateSkill {
  name = "hzoojsddxins",
  -- tags = { Skill.Compulsory },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable {
  ["hzoojsddxins"] = "潰陳",
  [":hzoojsddxins"] = "一腳色A起動｢殺｣被旹,若伱在A攻程內且起動目幖不含伱,伱可發動｡伱抽1,選擇伱攻程至多x其它脚色,伱与所選脚色加入起動目幖(无視合理)",

  ["#hzoojsddxins-invoke"] = "潰陳 %src 起動 %arg",
  ["#hzoojsddxins-choose"] = "潰陳 選擇目幖",

  ["$hzoojsddxins1"] = "飛影漫天,必有一傷",
  ["$hzoojsddxins2"] = "昰一刀必昰要殺出血灮",
}


hzoojsddxins:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  
    data.card.trueName=="ssaet"
    and player:hasSkill(hzoojsddxins.name)
    and data.tos and not table.contains(data.tos,player)
    and (data.from:inMyAttackRange(player) or player==data.from)
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = hzoojsddxins.name,
      prompt = "#hzoojsddxins-invoke:"..data.from.id.."::"..data.card:toLogString(),
    })
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    player:drawCards(1)
    local tos = room:askToChoosePlayers(player, {
      min_num = 0,
      max_num = player.hp,
      targets = table.filter(room.alive_players,function(p)
        return  not table.contains(data.tos,p)
        and player:inMyAttackRange(p)
      end),
      skill_name = hzoojsddxins.name,
      prompt = "#hzoojsddxins-choose",
      cancelable = true,
    })
    -- table.insert(tos,player)
    table.insertTable(data.tos, tos)
    table.insert(data.tos,player)
  end,
})

return hzoojsddxins
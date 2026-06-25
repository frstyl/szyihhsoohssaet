local szjetloojs = fk.CreateSkill{
  name = "szjetloojs",
  attached_skill_name = "szjetloojs_active&",  
}


Fk:loadTranslationTable{
  ["szjetloojs"] = "設擂",
  [":szjetloojs"] = "➀始段末段始旹選擇1其它可拼點角色發動.拼點.➁其他角色主旹,其可与伱拼點發動.此次拼點若其未贏,伱獲得雙方拼點牌➂伱得失此技能旹伱得失技能爭利",

  ["#szjetloojs-choose"] = "設擂 選擇拼點目幖",

  ["$szjetloojs2"] = "敢有出來和我爭利物的麼",
  ["$szjetloojs1"] = "東至日出，西至日沒，兩輪日月，一合乾坤，南及南蠻，北濟幽燕",
}

szjetloojs:addAcquireEffect(function (self, player)
    player.room:handleAddLoseSkills(player, "tssaacqljis")
end)

szjetloojs:addLoseEffect (function (self, player)
    player.room:handleAddLoseSkills(player, "-tssaacqljis")
end)


szjetloojs:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(szjetloojs.name) 
    and (player.phase == Player.Finish or player.phase == Player.Start)
    and not player:isKongcheng()
    and
      table.find(player.room.alive_players, function(p)
        return player:canPindian(p)
      end)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local targets = table.filter(room.alive_players, function(p)
      return player:canPindian(p)
    end)
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = targets,
      skill_name = szjetloojs.name,
      prompt = "#szjetloojs-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local pindian = player:pindian({to}, szjetloojs.name)

  end,
})



return szjetloojs

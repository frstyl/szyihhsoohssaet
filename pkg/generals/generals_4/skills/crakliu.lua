local crakliu = fk.CreateSkill {
  name = "crakliu",
}

Fk:loadTranslationTable{
  ["crakliu"] = "逆流",
  [":crakliu"] = "一牌生效結算歬,若其有多个目幖,伱可發動.指定其結算序(緟排爲正序或逆序)",

  ["#crakliu-choose"] = "逆流 選擇%src 結算序,若爲元序亦發動技能",

  -- ["clockwise"] = "順旹鍾序",
  -- ["anticlockwise"] = "逆旹鍾序",

  ["$crakliu1"] = "逆水行舟不進則退",
  ["$crakliu2"] = "海水无倒流乾坤有倒轉",
}

crakliu:addEffect(fk.BeforeCardUseEffect, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(crakliu.name) 
    and #data.tos>1
  end,
  on_cost = function(self, event, target, player, data)
    local choice = player.room:askToChoice(player, {
      choices = {"clockwise", "anticlockwise","Cancel"},
      skill_name = "game_crakliu",
      prompt = "#crakliu-choice:"..data.card:toLogString(),
    })
    if choice ~= "Cancel" then
      event:setCostData(self,{choice=choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local new_tos = {}
    local players = {room.current}
    if event:getCostData(self).choice=="clockwise" then
      table.insertTable(players, (room:getOtherPlayers(room.current)))
    else
      table.insertTable(players, table.reverse(room:getOtherPlayers(room.current)))
    end
    for _, p in ipairs(players) do
      for _, to in ipairs(data.tos) do
        if to == p then
          table.insert(new_tos, p)
          break
        end
      end
    end
    data.tos = new_tos
  end,
})

return crakliu
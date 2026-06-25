local poosddxins = fk.CreateSkill {
  name = "poosddxins",
  tags = { Skill.Limited },
}

Fk:loadTranslationTable{
  ["poosddxins"] = "布陣",
  [":poosddxins"] = "每局限1.末段始旹,若伱有手牌,伱可選1項發動發動.➀連續任意次,伱可弃1手牌,交換2名角色座次➁弃全部緟排全部角色座次",

  ["#poosddxins-invoke"] = "布陣：緟排角色座次",
  ["$TaMo"] = "布陣",
  ["click to exchange"] = "點擊交換",

  ["#poosddxins-choose"] = "布陣 選擇1手牌与2角色 交換其座次",

  ["$poosddxins1"] = "天地爲盤,蒼生爲棋子,此舉,孤註一擲",

}

poosddxins:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player 
    and player:hasSkill(poosddxins.name) 
    and target.phase == Player.Finish
    and player:usedSkillTimes(poosddxins.name, Player.HistoryGame) == 0
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local choice = player.room:askToChoice(player, {
      choices = {"discard_all","discard1","Cancel"},
      skill_name = poosddxins.name,
      prompt = "#poosddxins-choose",
    })
    if choice=="Cancel" then return end
    if choice=="discard_all" then  
    
      local availablePlayerIds = table.map(room.players, Util.IdMapper)
      local disabledPlayerIds = {}

      local result = room:askToCustomDialog(player, {
        skill_name = poosddxins.name,
        qml_path = "packages/mobile/qml/TaMoBox.qml",
        extra_data = {
          availablePlayerIds,
          disabledPlayerIds,
          "$TaMo",
        },
      })
      if result ~= "" then
        event:setCostData(self, {choice = choice, extra_data = json.decode(result)})
        return true
      end
    else
        local tos, cards = room:askToChooseCardsAndPlayers(player, {
          min_card_num = 1,
          max_card_num = 1,
          min_num = 2,
          max_num = 2,
          targets = room.players,  --死者不可選 須用彈窗
          pattern = ".|.|.|hand",
          prompt = "#poosddxins-choose",
          skill_name = poosddxins.name,
          cancelable = true,
          will_throw =true,
        })
        if #tos==2 and #cards==1 then
        event:setCostData(self,{choice = choice, tos=tos,cards=cards})
        return true
        end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if event:getCostData(self).choice=="discard_all" then
      player:throwAllCards("h")


      local players = table.simpleClone(room.players)
      for seat, playerId in pairs(event:getCostData(self).extra_data) do
        players[seat] = room:getPlayerById(playerId)
      end
      room.players = players
      local player_circle = {}
      for i = 1, #room.players do
        room.players[i].seat = i
        table.insert(player_circle, room.players[i].id)
      end
      for i = 1, #room.players - 1 do
        room.players[i].next = room.players[i + 1]
      end
      room.players[#room.players].next = room.players[1]
      room:setCurrent(player)
      room:doBroadcastNotify("ArrangeSeats", json.encode(player_circle))
    
    else
          room:throwCard(event:getCostData(self).cards, poosddxins.name, player, player)
          room:swapSeat(event:getCostData(self).tos[1], event:getCostData(self).tos[2])
      while 1 do
        local tos, cards = room:askToChooseCardsAndPlayers(player, {
          min_card_num = 1,
          max_card_num = 1,
          min_num = 2,
          max_num = 2,
          targets = room.players,  --死者不可選 須用彈窗
          pattern = ".|.|.|hand",
          prompt = "#poosddxins-choose",
          skill_name = poosddxins.name,
          cancelable = true,
          will_throw =true,
        })
        if #tos==2 and #cards==1 then
          room:throwCard(cards, poosddxins.name, player, player)
          room:swapSeat(tos[1], tos[2])
        else
          break
        end
      end
    end
  end,
})

return poosddxins

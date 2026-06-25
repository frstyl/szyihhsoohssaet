local lvoansqun = fk.CreateSkill {
  name = "lvoansqun",
}

Fk:loadTranslationTable{
  ["lvoansqun"] = "亂雲",
  [":lvoansqun"] = "每輪始旹,至多體力上限次.伱可預弃1牌,預弃1角色區域1牌發動.不可連續選擇同1角色",

  ["#lvoansqun-choose"] = "亂雲： 選牌与角色",
  ["#lvoansqun-discard"] = "亂雲： 弃牌",

  ["$lvoansqun1"] = "奇人當有異術",
}

lvoansqun:addEffect(fk.RoundStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(lvoansqun.name) and not player:isNude()
    -- and  table.find(player.room.alive_players, function (p)
    --     return not p:isAllNude()
    --   end)
  end,
  trigger_times = function(self, event, target, player, data)
    return player.maxHp
  end,
  on_cost = function(self, event, target, player, data)
    local room=player.room
    local  targets = table.filter(room.alive_players, function(p)
        return not p:isAllNude() and not table.contains(player:getTableMark("lvoansqun-phase"),p.id)
      end)
    if #targets == 0 then return end
    local to ,card= room:askToChooseCardsAndPlayers(player, {
      targets = targets,
      min_card_num = 1,
      max_card_num = 1,
      min_num = 1,
      max_num = 1,
      prompt = "#lvoansqun-choose",
      skill_name = lvoansqun.name,
      will_throw = true,
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self,{tos=to, card=card})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    room:throwCard(event:getCostData(self).card, lvoansqun.name, player, player)
    local to = event:getCostData(self).tos[1]
    local    cards = room:askToChooseCards(player, {
          target = to,
          min = 1,
          max = 1,
          flag = "hej",
          skill_name = lvoansqun.name,
          prompt = "#lvoansqun-discard",
        })
    room:throwCard(cards, lvoansqun.name, to, player)
    room:setPlayerMark(player, "lvoansqun-phase",{to.id})  --待定
  end,
})


return lvoansqun

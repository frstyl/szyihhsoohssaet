local hzoojqkracs = fk.CreateSkill {
  name = "hzoojqkracs",
}

Fk:loadTranslationTable{
  ["hzoojqkracs"] = "回敬",
  [":hzoojqkracs"] = "其它脚色轉終,若其1轉內曾對伱起動牌,伱可選1項發動➀伱抽2,交予其1牌,➁視爲對其起動殺",


  ["#hzoojqkracs-choice"] = "回敬：你可以对 %dest 发动“回敬”，选择一项",
  ["hzoojqkracs_discard"] = "弃置%dest一张牌，视为对其起動【杀】",
  ["hzoojqkracs_give"] = "交给%dest一张牌，你摸两张牌",
  ["#hzoojqkracs-give"] = "回敬：请交给 %dest 一张牌",

  ["$hzoojqkracs1"] = "百步之內,取汝性命",
  ["$hzoojqkracs2"] = "著我玄天混元回敬",
  ["$hzoojqkracs3"] = "回敬破空",
}



hzoojqkracs:addEffect(fk.TurnEnd, {
  can_trigger = function(self, event, target, player, data)
    if not ( target~=player and player:hasSkill(hzoojqkracs.name)) then return end
    local tos ={}
      player.room.logic:getEventsOfScope(GameEvent.UseCard, 1, function (e)
        local dat=e.data
          if dat.from == data.who and table.contains(dat.tos,player) then
            event:setCostData(self,{tos=tos})
            return true
          end
      end, Player.HistoryTurn)
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local choices = {"hzoojqkracs_discard::"..target.id,  "hzoojqkracs_give::"..target.id, "Cancel"}

    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = hzoojqkracs.name,
      prompt = "#hzoojqkracs-choice::" .. target.id,
      detailed = false,
      all_choices = choices,
    })
    if choice ~= "Cancel" then
      event:setCostData(self, {to = {target}, choice = choice})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to =event:getCostData(self).to[1]
    player:broadcastSkillInvoke(hzoojqkracs.name)
    if event:getCostData(self).choice:startsWith("hzoojqkracs_give") then
      player:drawCards(2, hzoojqkracs.name)
      if player.dead then return end
      room:notifySkillInvoked(player, hzoojqkracs.name, "support")
      local cards = room:askToCards(player, {
        min_num = 1,
        max_num = 1,
        include_equip = true,
        skill_name = hzoojqkracs.name,
        cancelable = false,
        prompt = "#hzoojqkracs-give::" .. to.id,
      })
      room:obtainCard(to, cards, false, fk.ReasonGive, player, hzoojqkracs.name)

    else
      room:notifySkillInvoked(player, hzoojqkracs.name, "offensive")

      room:useVirtualCard("ssaet", nil, player, to, hzoojqkracs.name, false)
    end
  end,

})

return hzoojqkracs

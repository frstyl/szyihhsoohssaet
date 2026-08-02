local keetjyen = fk.CreateSkill{
  name = "keetjyen",
  related_skills={"doucqsjim"},
}


Fk:loadTranslationTable{
  ["keetjyen"] = "結緣",
  [":keetjyen"] = "伱/其它脚色A預段始旹,伱/A可發動.伱/A選擇1其它/伱(有此技能者).",

  ["#keetjyen-invoke"] = "結緣 選擇同心脚色",

  ["$keetjyen1"] = "无物結同心",

}
keetjyen:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target
    and target.phase == Player.Start
    and target == player
    and  table.find(target.room.alive_players,function(p) return p:hasSkill(keetjyen.name) end )

  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player:hasSkill(keetjyen.name) and player.room:getOtherPlayers(player) or table.filter(target.room.alive_players,function(p) return p:hasSkill(keetjyen.name) end ),
      skill_name = keetjyen.name,
      prompt = "#keetjyen-invoke",
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
    player.room:addTableMark(player,"@doucqsjim",to.id)
    room:handleAddLoseSkills(player, "doucqsjim", nil, false, true)
  end,
})


return keetjyen

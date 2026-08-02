local cweqdoeojh = fk.CreateSkill {
  name = "cweqdoeojh",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
["cweqdoeojh"] = "危殆",
[":cweqdoeojh"] = "伱受傷後必發,4次,伱選1脚色1牌,褈鑄之",

["#cweqdoeojh-invoke"]="危殆 對 %dest 發動  ",
}


cweqdoeojh:addEffect(fk.Damaged, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(cweqdoeojh.name) 
  end,
  on_cost = function(self, event, target, player, data)
    return true
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    for i=1,4,1 do

      if player.dead then return end
    local tos = table.filter(player.room.alive_players, function(p)
      return not p:isNude()
    end)      
    if #tos==0 then return end
      local  to =player.room:askToChoosePlayers(player, {
        targets = tos,
        min_num = 1,
        max_num = 1,
        prompt = "#cweqdoeojh-ask",
        skill_name = cweqdoeojh.name,
        cancelable=false,
      })[1]
    local cid = room:askToChooseCard(player, { target = to, flag = "hej", skill_name = cweqdoeojh.name })
    room:recastCard({cid}, to, cweqdoeojh.name)
    end
  end,
})
return cweqdoeojh

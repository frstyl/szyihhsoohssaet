local kxenhgi = fk.CreateSkill{
  name = "kxenhgi",
}

Fk:loadTranslationTable{
["kxenhgi"] = "搴旗",
[":kxenhgi"] = "伱對其它脚色致傷後,若此爲其當輪首次受傷,伱可發動,抽x.(x爲此技能發動次數)",


["$kxenhgi1"] = "等吾拿l頭攻再作打算",
["$kxenhgi2"] = "兄弟,吾先行一步",
}



kxenhgi:addEffect(fk.Damage, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if data.from~=player or not player:hasSkill(kxenhgi.name) or data.from==data.to or data.to:getMark("kxenhgi_damage-round")~=0  then return end

      player.room:setPlayerMark(data.to, "kxenhgi_damage-round", 1)
      local damage_events = player.room.logic:getActualDamageEvents(1, function (e)
        return e.data.to == data.to
      end, Player.HistoryRound)
      if #damage_events == 1 and damage_events[1].data == data then
          return true
      end
    
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player:usedSkillTimes(kxenhgi.name, Player.HistoryRound), kxenhgi.name)
    
  end,
})



return kxenhgi

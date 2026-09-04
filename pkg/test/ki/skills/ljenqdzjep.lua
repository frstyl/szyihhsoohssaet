local ljenqdzjep = fk.CreateSkill{
  name = "ljenqdzjep",
}

Fk:loadTranslationTable{
["ljenqdzjep"] = "連捷",  --功伐
[":ljenqdzjep"] = "伱對其它脚色致傷後,抽x.",


["$ljenqdzjep1"] = "等吾拿l頭攻再作打算",
["$ljenqdzjep2"] = "兄弟,吾先行一步",
}

ljenqdzjep:addEffect(fk.Damaged, {
  can_refresh= function(self, event, target, player, data)
    return data.from==player and player:hasSkill(ljenqdzjep.name)  and data.from~=data.to 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"ljenqdzjep",data.damage)
  end,
})
ljenqdzjep:addEffect(fk.Damaged, {
  can_refresh= function(self, event, target, player, data)
    return data.to==player and player:hasSkill(ljenqdzjep.name)  and data.from~=data.to 
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"ljenqdzjep",data.damage)
  end,
})

ljenqdzjep:addEffect(fk.Damaged, {

  can_trigger = function(self, event, target, player, data)
    return data.from==player and player:hasSkill(ljenqdzjep.name)  and data.from~=data.to and not table.contains(player:getTableMark("ljenqdzjep-round"))
  end,
  on_use = function(self, event, target, player, data)
    player:drawCards(player:getMark("ljenqdzjep"), ljenqdzjep.name)
    
  end,
})



return ljenqdzjep

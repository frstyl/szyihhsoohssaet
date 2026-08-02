local liakddxins = fk.CreateSkill {
  name = "liakddxins",
}

Fk:loadTranslationTable{
  ["liakddxins"] = "略陳",
  [":liakddxins"] = "預段,伱可選1其它脚色發動.其獲得金湯",  --同隊列?


  ["$liakddxins1"] = "吾昰陣勢固若金湯誰可破得",
}

liakddxins:addEffect(fk.EventPhaseStart, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(liakddxins.name)  and event.phase==Play.Start
  end,
  on_use = function(self, event, target, player, data)
    player.room:handleAddLoseSkills(event:getCostData(self).tos[1],"kximthoac&",nil,false,true)
  end,
})


return liakddxins

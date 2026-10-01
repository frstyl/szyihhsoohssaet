local szjetloojs = fk.CreateSkill{
  name = "szjetloojs",
  attached_skill_name = "szjetloojs_active&",  
}


Fk:loadTranslationTable{
  ["szjetloojs"] = "設擂",
  [":szjetloojs"] = "➁其它脚色主旹,其可与伱賭鬥｡➁伱賭鬥結果确定旹,若有贏家,其抽1",


  ["$szjetloojs2"] = "敢有出來和我爭利物的麼",
  ["$szjetloojs1"] = "東至日出，西至日沒，兩輪日月，一合乾坤，南及南蠻，北濟幽燕",
}

-- szjetloojs:addAcquireEffect(function (self, player)
--     player.room:handleAddLoseSkills(player, "szjetloojs")
-- end)

-- szjetloojs:addLoseEffect (function (self, player)
--     player.room:handleAddLoseSkills(player, "-szjetloojs")
-- end)


szjetloojs:addEffect(fk.PindianResultConfirmed, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(szjetloojs.name)  then return end
    if not (data.from == player or data.to ==player) then return end
    return data.winner~=nil
  end,
  on_trigger = function(self, event, target, player, data)
    data.winner:drawCards(1,szjetloojs.name)
  end,
})





return szjetloojs

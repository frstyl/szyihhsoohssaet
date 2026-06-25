local tssaacqljis = fk.CreateSkill{
  name = "tssaacqljis", 
  tags = { Skill.Compulsory },
}


Fk:loadTranslationTable{
  ["tssaacqljis"] = "爭利",
  [":tssaacqljis"] = "自限:擁有拼點技能.鎖定.伱所參与拼點終旹,若有贏家,必發.其抽1",



  ["$tssaacqljis2"] = "敢有出來和我爭利物的麼",
  ["$tssaacqljis1"] = "東至日出，西至日沒，兩輪日月，一合乾坤，南及南蠻，北濟幽燕",
}


tssaacqljis:addEffect(fk.PindianResultConfirmed, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    if not  player:hasSkill(tssaacqljis.name)  then return end
    if not (data.from == player or data.to ==player) then return end
    return data.winner~=nil
  end,
  on_use = function(self, event, target, player, data)
        data.winner:drawCards(1,tssaacqljis.name)
  end,
})



return tssaacqljis

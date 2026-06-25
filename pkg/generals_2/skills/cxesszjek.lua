local cxesszjek = fk.CreateSkill{
  name = "cxesszjek",
}

Fk:loadTranslationTable{
  ["cxesszjek"] = "義釋",
  [":cxesszjek"] = "伱使用牌确定目幖後,伱可選擇其中1目幖發動.伱迻除此目幖,弃其區域1牌,伱抽1",

  ["#cxesszjek-choose"] = "義釋 選擇目幖",

  ["$cxesszjek1"] = "事不宐遲,兄弟快走",
}

cxesszjek:addEffect(fk.AfterCardTargetDeclared, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(cxesszjek.name) 
    and #data.tos>0
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = data.tos,
      skill_name = cxesszjek.name,
      prompt = "#cxesszjek-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to=event:getCostData(self).tos[1]
    data:removeTarget(to)
    local cid = room:askToChooseCard(player, { target = to, flag = "hej", skill_name = cxesszjek.name })
    to:showCards({cid})
    room:throwCard({cid}, cxesszjek.name, to, player)
    player:drawCards(1,cxesszjek.name)
  end,
})



return cxesszjek

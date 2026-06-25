local muoqtseejs = fk.CreateSkill{
  name = "muoqtseejs",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["muoqtseejs"] = "无濟",
  [":muoqtseejs"] = "伱使用殺指定目幖後,若其有牌,伱可發動:目幖角色選擇一項➀交予伱2牌➁伱將其1牌轉化爲斷糧絕援置于其伏區",

  ["#muoqtseejs-invoke"] = "无濟 是否對 %src發動",

  ["$muoqtseejs1"] = "我欲行夏禹旧事，为天下人。",

}

muoqtseejs:addEffect(fk.TargetSpecified, {
  anim_type = "drawcard",
  can_trigger = function (self, event, target, player, data)
    return target==player and player:hasSkill(muoqtseejs.name) and data.to~=data.from and data.card.trueName=="ssaet" 
    and not data.to:isNude() --and not target.dead
  end,
  on_cost = function (self, event, target, player, data)
    return player.room:askToSkillInvoke(player, {
      skill_name = muoqtseejs.name,
      prompt = "#muoqtseejs-invoke:"..data.to.id,
    })
  end,
  on_use = function (self, event, target, player, data)
    if data.to:isNude() then return end
    local room = player.room
    local cards=  room:askToCards(data.to, {
          min_num = 2,
          max_num = 2,
          include_equip = true,
          skill_name = muoqtseejs.name,
          pattern = ".",
          prompt = "#muoqtseejs-choose",
          cancelable = true,
        })
        if #cards==2 then
          room:moveCardTo(cards, Player.Hand, player, fk.ReasonGive, muoqtseejs.name,nil,false,data.to)
        else
         cards = room:askToChooseCards(player, {
          min = 1,
          max = 1,
          target = data.to,
          flag = "he",
          skill_name = muoqtseejs.name,
        })
        if #cards~=1 then return end
          local card = Fk:cloneCard("tvoans_liac_dzyet_quan")
          card:addSubcard(cards[1])
          data.to:addVirtualEquip(card)
          room:moveCardTo(card, Player.Judge, data.to, fk.ReasonPut, muoqtseejs.name,nil,false,player)  --无视合法性检测
        end
  end,
})



return muoqtseejs

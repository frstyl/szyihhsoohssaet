local kaanqteev = fk.CreateSkill({
  name = "kaanqteev",
})


Fk:loadTranslationTable{
["kaanqteev"] = "姦刁",
[":kaanqteev"] = "伱受其它角色傷後,可選1項執行發動.➀抽x(x爲伱与其體力值大者)➁獲取其y牌(y爲伱与其體力值之差,至少爲1)",

["#kaanqteev-choice"] = "姦刁",
["kaanqteev-draw"] = "抽%arg",
["kaanqteev-prey"] = "獲取%src %arg 牌",
}

kaanqteev:addEffect(fk.Damaged, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return  target == player and player:hasSkill(kaanqteev.name) and data.from and data.from ~= player
  end,
  on_cost = function(self, event, target, player, data)
    local m=math.max( data.from.hp , player.hp)
    local n=math.max(math.abs(data.from.hp -player.hp),1)
    local all_names ={"kaanqteev-draw:::"..m,"kaanqteev-prey:"..data.from.id..":"..":"..n}
    local choices={}
    if data.from:isNude() then
      choices={"kaanqteev-draw:::"..m}
    else
      choices={"kaanqteev-draw:::"..m,"kaanqteev-prey:"..data.from.id..":"..":"..n}
    end
      local choice = player.room:askToChoice(player, {
          choices = choices,
          skill_name = kaanqteev.name,
          prompt = "#kaanqteev-choice",
          all_choices = all_names,
          cancelable=true,
        })
      if  choice~="Cancel" then
        event:setCostData(self,{choice=choice,n=n,m=m})
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local n=event:getCostData(self).n
    local m=event:getCostData(self).m
    if event:getCostData(self).choice=="kaanqteev-draw:::"..m then
            player:drawCards(m,kaanqteev.name)
    else
          local ids = room:askToChooseCards(player, {
        target = data.from,
        min = n,
        max = n,
        flag = "he",
        skill_name = kaanqteev.name,
      })
        room:obtainCard(player, ids, false, fk.ReasonPrey, player, kaanqteev.name)
    end
  end
})


return kaanqteev

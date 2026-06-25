local ttiacqszjer = fk.CreateSkill {
  name = "ttiacqszjer",
}

Fk:loadTranslationTable{
  ["ttiacqszjer"] = "張勢",
  [":ttiacqszjer"] = "➀當一其它角色死亾旹,伱可預展示一黑桃手牌發動.伱體力上限+1➁預段始旹,伱可發動.伱減1體力上限,抽x(x爲體力上限)",

  ["#ttiacqszjer-give"] = "运柩：将 %dest 的一张牌交给一名其他角色",

  ["$ttiacqszjer1"] = "此吾主之柩，请诸君勿扰。",
  ["$ttiacqszjer2"] = "故者为大，尔等欲欺大者乎？"
}

ttiacqszjer:addEffect(fk.Death, {
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(ttiacqszjer.name) 
    and not player:isNude() 
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    local ids = room:askToCards(player, {
      min_num = 1,
      max_num = 1,
      include_equip = false,
      skill_name = ttiacqszjer.name,
      pattern = ".|.|spade",
      prompt = "#ttiacqszjer-ask",
      cancelable = true,
    })

    if ids and #ids>0 then
      event:setCostData(self, {ids=ids})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    if player.dead then return end
    player:showCards(event:getCostData(self).ids)
    room:changeMaxHp(player, 1)
    if not player.dead and player:isWounded() then
      room:recover{
        who = player,
        num = 1,
        recoverBy = player,
        skillName = ttiacqszjer.name,
      }
    end
    end,
})


ttiacqszjer:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(ttiacqszjer.name) and player.phase == Player.Start
  end,
  on_use = function(self, event, target, player, data)
      player.room:changeMaxHp(player, -1)
      if player.dead then return end
      player:drawCards(player.maxHp, ttiacqszjer.name)
  end,
})

return ttiacqszjer

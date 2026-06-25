local leecqkveet = fk.CreateSkill({
  name = "leecqkveet",
})

Fk:loadTranslationTable{
  ["leecqkveet"] = "靈訣",
  [":leecqkveet"] = "當伱受到傷害非雷電屬旹,伱可選擇1其他角色發動,其判定,若花色爲非♥️,伱与其1雷電傷害,否則其受到相同傷害",

  ["#leecqkveet-choose"] = "靈訣：你可以令一名角色进行判定",

  ["$leecqkveet1"] = "金甲天神,現",
  ["$leecqkveet2"] = "飛沙走石,播土揚塵",
}
leecqkveet:addEffect(fk.DamageInflicted, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(leecqkveet.name) and data.damageType~=fk.ThunderDamage
  end,
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room:getOtherPlayers(player),
      skill_name = leecqkveet.name,
      prompt = "#leecqkveet-choose",
      cancelable = true,
    })
    if #to > 0 then
      event:setCostData(self, {tos = to})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- player:drawCards(1,leecqkveet.name)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    local judge = {
      who = to,
      reason = leecqkveet.name,
      pattern = ".|.|spade,club,diamond",
    }
    room:judge(judge)
    if not to.dead then
       if judge:matchPattern() then
          room:damage{
            from = player,
            to = to,
            damage = 1,
            damageType = fk.ThunderDamage,
            skillName = leecqkveet.name,
          }
          -- return
      elseif judge.card.suit==Card.Heart then
        room:damage{
          from = data.from,
          to = to,
          damage = data.damage,
          damageType = data.damageType,
          skillName = data.skillName,
          chain = data.chain,
          card = data.card,
        }
      end
    end

    -- if judge.card.suit == Card.Heart  then
    --   -- if not to.dead then
    --   --   room:askToDiscard(to, {
    --   --     min_num = 1,
    --   --     max_num = 1,
    --   --     include_equip = false,
    --   --     skill_name = leecqkveet.name,
    --   --     cancelable = false,
    --   --   })
    --   -- end
    --   data:preventDamage()
    --   if not player.dead then
    --     player:drawCards(1,leecqkveet.name)
    --   end
    -- end

  end,
})


return leecqkveet

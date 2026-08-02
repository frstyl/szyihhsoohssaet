local piktssaes = fk.CreateSkill {
  name = "piktssaes",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["piktssaes"] = "逼債",
  [":piktssaes"] = "锁定技，你始终处于横置状态；处于连环状态的脚色手牌上限+2；结束阶段开始时，你横置一名其他脚色。",

  ["#piktssaes-choose"] = "逼債：选择一名其他脚色，令其横置",

  ["$piktssaes1"] = "桃园结义，营一世之交。",
  ["$piktssaes2"] = "结草衔环，报兄弟大恩。",
}


piktssaes:addEffect(fk.CardEffecting, {
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and data.card.trueName=="ssaet"
  end,
  on_cost = function (self, event, target, player, data)
    local room=player.room
    local tos =room:askToChoosePlayers(player, {
      targets = data.tos,
      min_num = 1,
      max_num = 1,
      prompt = "#tuxi-ask",
      skill_name = piktssaes.name,
    })

    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room=player.room
    local to = event:getCostData(self).tos[1]
      -- local dat=CardEffectData:new(table.simpleClone(data))
        local cardEffectData = {
          to=to,
          from = data.from,
          tos = data.tos,
          subTos = data.subTos,
          card = data.card,
          toCard = data.toCard,
          use = data.use,
          responseToEvent = data.responseToEvent,
          additionalDamage = data.additionalDamage,
          additionalRecover = data.additionalRecover,
          cardsResponded = data.cardsResponded,
          prohibitedCardNames = data.prohibitedCardNames,
          extra_data = data.extra_data,

          additionalRecover=data.additionalRecover,
          additionalDamage=data.additionalDamage,
          disresponsive=data.disresponsive,
          unoffsetable=data.unoffsetable,
          nullified=data.nullified,
          fixedResponseTimesList=data.fixedResponseTimesList,
        }

        dat=table.simpleClone(data)
        dat.to=to
        dat.card=data.card
        -- player:drawCards(#dat,piktssaes.name)
    -- room:doCardEffect(CardEffectData:new(table.simpleClone(cardEffectData)))
    -- room:doCardEffect(data)
    room:useCard(data.use)
  end,
})


return piktssaes

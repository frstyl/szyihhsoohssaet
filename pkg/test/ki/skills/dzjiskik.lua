local dzjiskik = fk.CreateSkill {
  name = "dzjiskik",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["dzjiskik"] = "自棘",
  [":dzjiskik"] = "伱起動傷害牌後,若未致傷,必發,此牌對伱生效1次", --伱對伱起動虛擬牌(同名同花同點)

  ["#dzjiskik"] = "自棘 隨機獲得1此花色坐騎牌",

  ["$dzjiskik1"] = "好一匹棗紅馬",
}
-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzjiskik:addEffect(fk.CardUseFinished, {  --負面技 轉迻
  anim_type = "negative",
  can_trigger = function(self, event, target, player, data)
    return 
    target==player 
    and 
    player:hasSkill(dzjiskik.name) 
    and data.card.is_damage_card
    and (not data.damageDealt)
  end,
  -- on_cost = function(self, event, target, player, data)
  --   if player.room:askToSkillInvoke(player, { skill_name = dzjiskik.name }) then
  --     event:setCostData(self,{tos={target}})
  --     return true
  --   end
  -- end,
  on_use = function(self, event, target, player, data)

    -- local card = Fk:cloneCard(data.card.name, data.card.suit, data.card.number)
    -- card.color = data.card.color
    -- card.skillName = dzjiskik.name

    -- player.room:useCard{
    --   from = target,
    --   tos = {target},
    --   card = card,
    --   extraUse=true,
    --   bypase_times=true,
    --   bypase_distances=true,
    -- }
    local room=player.room
    local cardEffectData = {
          from = data.from,
          tos = data.tos,
          subTos = data.subTos,
          card = data.card,
          toCard = data.toCard,
          use = data,
          responseToEvent = data.responseToEvent,
          additionalDamage = data.additionalDamage,
          additionalRecover = data.additionalRecover,
          cardsResponded = data.cardsResponded,
          prohibitedCardNames = data.prohibitedCardNames,
          extra_data = data.extra_data,
        }
    cardEffectData.to=player
    cardEffectData.from=nil
    local curCardEffectEvent = CardEffectData:new(table.simpleClone(cardEffectData))
    room:doCardEffect(curCardEffectEvent)
  end,
})

return dzjiskik

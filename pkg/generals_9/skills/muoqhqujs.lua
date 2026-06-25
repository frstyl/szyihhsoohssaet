local muoqhqujs = fk.CreateSkill({
  name = "muoqhqujs",
  tags={Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["muoqhqujs"] = "无畏",
  [":muoqhqujs"] = "➀伱使用殺對目幖生效歬,若伱攻程大于攻程,或其裝僃防具,此殺不可被閃響應.➁其它角色使用殺對伱生效歬,若其攻程大于伱攻程,伱不可使用閃響應且伱獲得此殺(子牌)➂伱攻程+伱已損體力值",

  ["$muoqhqujs1"] = "百步穿杨！",
  ["$muoqhqujs2"] = "中！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

muoqhqujs:addEffect(fk.PreCardEffect, {--TargetSpecified
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(muoqhqujs.name) and
      data.card.trueName == "ssaet" 
      and (
        (data.from == player and (player:getAttackRange()>data.to:getAttackRange() or S.hasEquip(data.to,Card.SubtypeArmor)))
    or (data.to == player and player:getAttackRange()<data.from:getAttackRange())
  )
  end,
  on_use = function(self, event, target, player, data)
    if data.to==player and  player.room:getCardArea(data.card) == Card.Processing and not player.dead then
      player.room:obtainCard(player, data.card, true, fk.ReasonJustMove, player, muoqhqujs.name)
    end
    data.prohibitedCardNames = data.prohibitedCardNames or {}
    table.insertIfNeed(data.prohibitedCardNames,"szjemh")
  end,
})


muoqhqujs:addEffect("atkrange", {
  correct_func = function(self, player)
    if player:hasSkill(muoqhqujs.name) and player:getLostHp() > 0 then
      return  player:getLostHp()
    end
  end
})

return muoqhqujs

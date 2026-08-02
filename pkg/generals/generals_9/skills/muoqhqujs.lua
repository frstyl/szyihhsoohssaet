local muoqhqujs = fk.CreateSkill({
  name = "muoqhqujs",
  tags={Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["muoqhqujs"] = "无畏",
  [":muoqhqujs"] = "➀伱指定其它腳色爲｢殺｣目幖後,若伱攻程大于攻程或其裝僃防具必發,此殺不可被閃響應.➁伱成爲其它脚定｢殺｣目幖後,若其攻程大于伱攻程必發,伱不可起動閃響應且伱取得此殺(子牌)➂伱攻程+伱已損體力值",

  ["$muoqhqujs1"] = "百步穿杨！",
  ["$muoqhqujs2"] = "中！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

muoqhqujs:addEffect(fk.TargetSpecified, {--
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(muoqhqujs.name) and
      data.card.trueName == "ssaet" 
      and 
        (data.from == player and (player:getAttackRange()>data.to:getAttackRange() or S.hasEquip(data.to,Card.SubtypeArmor)))

  end,
  on_use = function(self, event, target, player, data)
    data.prohibitedCardNames = data.prohibitedCardNames or {}
    table.insertIfNeed(data.prohibitedCardNames,"szjemh")
  end,
})

muoqhqujs:addEffect(fk.TargetConfirmed, {--
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(muoqhqujs.name) and
      data.card.trueName == "ssaet" 
      and (data.to == player and player:getAttackRange()<data.from:getAttackRange())

  end,
  on_use = function(self, event, target, player, data)
    player.room:obtainCard(player, data.card, true, fk.ReasonPrey, player, muoqhqujs.name)
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

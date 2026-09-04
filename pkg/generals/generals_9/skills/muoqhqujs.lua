local muoqhqujs = fk.CreateSkill({
  name = "muoqhqujs",
  tags={Skill.Compulsory},
})

Fk:loadTranslationTable{
  ["muoqhqujs"] = "无畏",
  [":muoqhqujs"] = "➀伱指定其它腳色A爲｢殺｣目幖後,若伱攻程大于A攻程或A裝僃防具必發,此殺不可被閃響應,其自弃1非｢閃｣牌.➁伱成爲其它脚定｢殺｣目幖後,若其攻程大于伱攻程必發,伱不可抵消之且伱取得此殺(子牌)➂恆續,伱攻程+伱已損體力數",

  ["#muoqhqujs-discard"] = "无畏 %src 弃1非閃牌",

  ["$muoqhqujs1"] = "百步穿杨！",
  ["$muoqhqujs2"] = "中！",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

muoqhqujs:addEffect(fk.TargetConfirmed, {--
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
	player.room:askToDiscard(data.to, {
      min_num = 1,
      max_num = 1,
      include_equip = true,
      skill_name = muoqhqujs.name,
      cancelable = false,
      pattern = "^szjemh",
      prompt = "#muoqhqujs-discard::"..data.from.id, 
	  skip = true })
	  
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
	local cards= getSubcardsByRule(data.card, Card.Processing)
    player.room:obtainCard(player,cards , true, fk.ReasonPrey, player, muoqhqujs.name)
    data.unoffsetable=true
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

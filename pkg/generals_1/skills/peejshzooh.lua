
local peejshzooh = fk.CreateSkill{
  name = "peejshzooh",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["peejshzooh"] = "閉戶",
  [":peejshzooh"] = "當伱成爲其他角色所用進攻牌目標旹,若伱手牌數體力值不等,必發.迻除目幖.伱受傷後,若伱有手牌,必發.伱弃1手牌.",

  ["#peejshzooh-ask"] = "是否发动 閉戶，打出一张牌代替 %dest 的 %arg 判定",

  ["$peejshzooh1"] = "若斯必上門找我,我且躲它幾日",
  ["$peejshzooh2"] = "如今也止好躲進太尉府裏矣",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

peejshzooh:addEffect(fk.TargetConfirming, {
  peejshzooh = "control",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(peejshzooh.name)
    and data.from~=player
    and player:getHandcardNum()~=player.hp
    and  S.isAttackCard(data.card)  
  end,
  on_use = function(self, event, target, player, data)
      data:cancelTarget(target)
  end,
})

peejshzooh:addEffect(fk.Damaged, {
  peejshzooh = "control",
  can_trigger = function(self, event, target, player, data)
    return data.to == player and player:hasSkill(peejshzooh.name)
    and data.from~=player
    and not player:isKongcheng()
  end,
  on_use = function(self, event, target, player, data)
      player.room:askToDiscard(player, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = peejshzooh.name,
        cancelable = false,
        prompt = "#peejshzooh-discard::"..target.id..":" .. n,
        skip = false,
      })
  end,
})
return peejshzooh

local tszjechljet = fk.CreateSkill {
  name = "tszjechljet",
}

Fk:loadTranslationTable{
  ["tszjechljet"] = "整列",
  [":tszjechljet"] = "脚色A成爲｢殺｣目幖後,伱可發動｡伱令A抽2,手牌弃至體力值",
  -- [":tszjechljet"] = "脚色A成爲｢殺｣目幖後,若其在伱攻程內且其x{大于/小于}0,伱可發動.伱令其{弃x手牌此殺對其傷害基數-x/抽1}｡x爲其手牌數-體力數",

  ["#tszjechljet-invoke"] = "整列：伱可對 %dest 發動",
  ["#tszjechljet-discard"] = "%dest 對伱發動 整列, 伱需弃 %arg 牌",


  -- ["$tszjechljet1"] = "典将军，比比看谁杀敌更多！",
  -- ["$tszjechljet2"] = "父亲快走，有我殿后！"
}


tszjechljet:addEffect(fk.TargetConfirmed, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(tszjechljet.name) 
    and data.card.trueName == "ssaet"
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    if room:askToSkillInvoke(player, {
      skill_name = tszjechljet.name,
      prompt = "#tszjechljet-invoke::"..target.id,
    }) then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
      data.to:drawCards(2, tszjechljet.name)
      if  data.to.dead then return end

      local n = target:getHandcardNum() - math.max(0,target.hp)
      if n>0 then
        room:askToDiscard(target, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = tszjechljet.name,
        cancelable = false,
        prompt = "#tszjechljet-discard::"..player.id..":" .. n,
        skip = false
      })
    end
  end,
})

-- tszjechljet:addEffect(fk.TargetConfirmed, {
--   anim_type = "support",
--   can_trigger = function(self, event, target, player, data)
--     return player:hasSkill(tszjechljet.name) 
--     and data.card.trueName == "ssaet"
--     and (target==player or player:inMyAttackRange(target) )
--     and target:getHandcardNum()~= math.max(0,target.hp)
--   end,
--   on_cost = function (self, event, target, player, data)
--     local room = player.room
--     if room:askToSkillInvoke(player, {
--       skill_name = tszjechljet.name,
--       prompt = "#tszjechljet-invoke::"..target.id,
--     }) then
--       event:setCostData(self, {tos = {target},choice= target:getHandcardNum()>target.hp and true or false})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     if event:getCostData(self).choice==false then  --發動前定效果
--       data.to:drawCards(1, tszjechljet.name)
--     else
--       local n = target:getHandcardNum() - math.max(0,target.hp)
--       if n>0 then
--         room:askToDiscard(target, {
--         min_num = n,
--         max_num = n,
--         include_equip = false,
--         skill_name = tszjechljet.name,
--         cancelable = false,
--         prompt = "#tszjechljet-discard::"..player.id..":" .. n,
--         skip = false
--       })
--       data.additionalDamage = (data.additionalDamage or 0) - n
--     end
--   end
--   end,
-- })

return tszjechljet

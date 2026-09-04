local ex__bjevsgxes = fk.CreateSkill{
  name = "ex__bjevsgxes",
}

Fk:loadTranslationTable{
  ["ex__bjevsgxes"] = "驃騎",
  [":ex__bjevsgxes"] = "伱起動卽旹牌指定目幖後,若其爲僅存目幖且伱至其距離不大于1,伱可發動,此牌對其額外生效1次",

  ["#ex__bjevsgxes-invoke"] = "驃騎： %arg 對 %src 額外生效",

  ["$ex__bjevsgxes1"] = "狄获悬野，秋风扫之！",
  ["$ex__bjevsgxes2"] = "戎狄作乱，岂能坐视！",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ex__bjevsgxes:addEffect(fk.TargetConfirmed, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    if 
      data.from == player and player:hasSkill(ex__bjevsgxes.name) 
      and S.getCardUsageType(data.card.trueName)==1 
      -- and data:isOnlyTarget(data.to)
      and
      player:compareDistance(data.to, 1, "<=")
    then
        return true
    end
  end,
  on_cost = function(self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = ex__bjevsgxes.name,
      prompt = "#ex__bjevsgxes-invoke:"..data.to.id.."::"..data.card:toLogString(),
    }) 
    then
      event:setCostData(self, {tos = {data.to}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    -- data.use.additionalEffect = (data.use.additionalEffect or 0) + 1
	data.additionalEffectToPlayer = data.additionalEffectToPlayer or {}
	data.additionalEffectToPlayer[data.to]=(data.additionalEffectToPlayer[data.to] or 0) +1
  end,
})

return ex__bjevsgxes

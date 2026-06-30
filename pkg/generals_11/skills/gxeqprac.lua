local gxeqprac = fk.CreateSkill{
  name = "gxeqprac",
}

Fk:loadTranslationTable{
  ["gxeqprac"] = "奇兵",
  [":gxeqprac"] = "一角色A成爲B所用進攻牌C唯一目幖後,若伱至A距離不大于1且B不爲伱,伱可將1牌轉化爲C對B使用發動.",

  ["#gxeqprac-ask"] = "奇兵 是否對 %src 發動",
  ["#gxeqprac-choose"] = "奇兵 選擇1手牌",

  ["$gxeqprac1"] = "且慢",  --
  -- ["$gxeqprac1"] = "慢著,不要輕動",  --
  ["$gxeqprac2"] = "待俺尋思尋思",
  ["$gxeqprac3"] = "緟新開始夫",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 


-- Fk:addPoxiMethod{
--   name = "gxeqprac_discard",
--   prompt = "#gxeqprac-ask",
--   card_filter = function(to_select, selected, data)

--     return not (Self:prohibitResponse(Fk:getCardById(to_select)) and table.contains(data[1][2], to_select))
--   end,
--   feasible = function(selected)
--     return #selected == 1
--   end,
-- }
gxeqprac:addEffect(fk.TargetConfirmed, {  --TargetSpecifying TargetConfirming
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return 
    player:hasSkill(gxeqprac.name) --
    and S.isAttackCard(data.card.name)
    and data:isOnlyTarget(data.to)
    and player:compareDistance(data.to,1,"<=")
    and data.from ~=player
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local use = player.room:askToUseVirtualCard(player, {
      name = data.card.name,
      skill_name = gxeqprac.name,
      prompt = "#gxeqprac-use:"..data.from.id,
      cancelable = true,
      extra_data = {
        must_targets = {data.from.id},
        exclusive_targets = {data.from.id},
        bypass_distances = true,
        bypass_times = true,
      },
      card_filter = {
        n = 1,
        -- pattern=".|.|spade,club,nosuitblack",
        -- cards = cards,
      },
      skip = true,
    })
    if use then
      event:setCostData(self, { extra_data = use })
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    player.room:useCard(event:getCostData(self).extra_data)
  end,
})



return gxeqprac

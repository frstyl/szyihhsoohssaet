

local seenqtoeoc= fk.CreateSkill({
  name = "seenqtoeoc",
})

Fk:loadTranslationTable{
["seenqtoeoc"] = "先登",
[":seenqtoeoc"] = "➀一其它角色A轉始旹,伱可發動,伱可使用1手牌(无視距離),目幖須含A.此牌結算後,若對A致傷,伱抽2,此技能當輪內失效.",
["#seenqtoeoc-choose"] = "先登 對 %src 使用牌",

["#seenqtoeoc-choose"] = "先登 對 %src 使用牌",
}


seenqtoeoc:addEffect(fk.TurnStart,{
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target~=player and player:hasSkill(seenqtoeoc.name)
  end,
  on_cost = function(self, event, target, player, data)
    -- local use = player.room:askToUseCard(player, {
    --     skill_name = seenqtoeoc.name,
    --     pattern = ".", --
    --     prompt = "#seenqtoeoc-choose:"..target.id,
    --     cancelable = true,
    --     extra_data = {
    --       bypass_distances = true,
    --       bypass_times = false,
    --       must_targets={target.id},
    --       -- include_targets = {target.id},
    --       not_passive=true,
    --     },
    --   })
      local use = player.room:askToPlayCard(player, {
        skill_name = seenqtoeoc.name,
        pattern = ".", --
        -- cards=,
        prompt = "#seenqtoeoc-choose:"..target.id,
        cancelable = true,
        skip=true,
        extra_data = {
          bypass_distances = true,
          bypass_times = false,
          must_targets={target.id},
          -- include_targets = {target.id},
          not_passive=true,
        },
      })
      if not use then  return end
      event:setCostData(self,{use=use,tos={target}})
      return true
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local use = event:getCostData(self).use
    local to = event:getCostData(self).tos[1]
    room:useCard(use)
    if  use   and use.damageDealt and use.damageDealt[to] then
      player:drawCards(2,seenqtoeoc.name)
      room:invalidateSkill(player, seenqtoeoc.name, "-round")
    end
  end,
})

-- seenqtoeoc:addEffect("targetmod", {
--   bypass_distances =  function(self, player, skill, card, to)
--     return card and to==Fk:currentRoom().current
--   end,
-- })
return seenqtoeoc

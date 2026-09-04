local cooqkou = fk.CreateSkill {
  name = "cooqkou",
}

Fk:loadTranslationTable{
  ["cooqkou"] = "吳鉤",
  [":cooqkou"] = "其它脚色A起動牌被底消後後,若目幖不含伱,伱可預將1行動牌与A同色者轉化爲埋伏對A起動發動.",  --攻程

  ["#cooqkou-use"] = "吳鉤 對%src起動埋伏",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cooqkou:addEffect(fk.CardEffectCancelledOut, {
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.to ~= player and player:hasSkill(cooqkou.name) 
    and data.use
    and data.card.color ~= Card.NoColor 
    -- and player:inMyAttackRange(target)
    -- and not table.contains(data.tos or {}, player)
    and not player:isKongcheng()
  end,
  on_cost = function(self, event, target, player, data)
    local color =data.card.color
    local use = player.room:askToUseVirtualCard(player, {
      name = "mae_biuk",
      skill_name = cooqkou.name,
      prompt = "#cooqkou-use:"..target.id,
      cancelable = true,
      extra_data = {
        must_targets = {data.to.id},
        -- exclusive_targets = {data.to.id},
        -- bypass_distances = true,
        -- bypass_times = true,
        koarbiuk_rule=true,
      },
      card_filter = {
        n = 1,
        pattern=tostring(Exppattern{ id = table.filter(player:getCardIds("h"),function(cid)
          local card=Fk:getCardById(cid)
        return S.getCardSubtypeByName(card.trueName)==1 and card.color~=Card.NoColor and card.color==color --and card:compareColorWith(data.card)
        end) }) ,        -- cards = cards,
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


return cooqkou

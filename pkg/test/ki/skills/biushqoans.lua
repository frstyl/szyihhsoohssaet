Fk:loadTranslationTable{
  ["biushqoans"] = "覆案",
  [":biushqoans"] = "其它脚色聲明起動牌A後,伱可預打出1牌B發動.A視爲B.不改變目幖,A B需有目幖且卽旹",

  ["@biushqoans-turn"] = "覆案",

  ["$biushqoans1"] = "喝啊！",
  ["$biushqoans2"] = "今，必斩汝马下！",
}

local biushqoans = fk.CreateSkill{
  name = "biushqoans",
  -- tags = { Skill.Compulsory },
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 


biushqoans:addEffect(fk.AfterCardUseDeclared, {
  can_trigger= function(self, event, target, player, data)
    return --target ~= player and 
    player:hasSkill(biushqoans.name) 
    and S.getCardUsageType(data.card)==1
    and data.tos and #data.tos>0
  end,
  on_cost = function(self, event, target, player, data)
    local cards=player.room:askToCards(player, {
        skill_name = biushqoans.name,
        min_num = 1,
        max_num = 1,
        prompt = "#biushqoans-invoke::"..target.id,
        include_equip = true,
        cancelable = true,
        pattern = tostring(Exppattern{ id = table.filter(player:getHandlyIds(), function (id)
        local card = Fk:getCardById(id)
      return not player:prohibitResponse(card) and 
       S.getCardUsageType(card)==1 
       and   (
        S.isTargetedCard(card)
        -- (card.skill:getMinTargetNum(target)>0) or  not card.is_passive
        -- or (card.skill:fixTargets(target, card, {bypass_distances=true,bypass_times=true}) and #card.skill:fixTargets(target, card, {bypass_distances=true,bypass_times=true})>0)

      )
    end)}),
      })
      if #cards>0 then
      event:setCostData(self, {tos = tos, cards = cards})
      return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local card= Fk:getCardById(event:getCostData(self).cards[1])
      player.room:responseCard({
				card=card,
				from=player,
				attachedSkillAndUser={muteCard=true},
			})
    data:changeCard(card.name, card.suit, card.number, biushqoans.name)
    -- local newCard = data.card:clone()
    -- local c = table.simpleClone(data.card)
    -- for k, v in pairs(c) do
    --   card[k] = v
    -- end
    -- newCard.skill = card.skill
    -- data.card = newCard

end,
})



return biushqoans

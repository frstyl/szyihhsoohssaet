
local cardSkill = fk.CreateSkill{
  name = "kiat_koan_nzi_khih",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


cardSkill:addEffect("active", {
  prompt = "#kiat_koan_nzi_khih",
  can_use = function(self, player, card, extra_data)
        return 
     not player:prohibitResponse(card)
  end,
  target_filter = function(self, player, to_select, selected,selected_cards)
    return #selected == 0 and to_select ~= player and not to_select:isKongcheng()
  end,
  target_num = 1,
  on_use = function(self, room, effect)
    local player=effect.from
    -- room:throwCard(effect.cards, cardSkill.name, player, player)
    S.playCard(effect.cards,cardSkill.name,player)
    local to = effect.tos[1]
    local cards = room:askToDiscard(to, {
        min_num = 1,
        max_num = 1,
        include_equip = false,
        skill_name = cardSkill.name,
        cancelable = false,
        prompt = "#kiat_koan_nzi_khih-discard",
        skip = false,
      })
  end,


})


return cardSkill

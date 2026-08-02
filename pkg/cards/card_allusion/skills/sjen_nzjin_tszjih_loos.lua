
local cardSkill = fk.CreateSkill{
  name = "sjen_nzjin_tszjih_loos",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"

cardSkill:addEffect("active", {
  prompt = "#sjen_nzjin_tszjih_loos",
  target_filter = function(self, player, to_select, selected,selected_cards)
    return #selected == 0 and to_select ~= player and not to_select:isKongcheng()
    and not player:prohibitResponse(Fk:getCardById(selected_cards[1]))
  end,
  target_num = 1,
  on_use = function(self, room, effect)
    local player=effect.from
    -- room:throwCard(effect.cards, cardSkill.name, player, player)
    S.playCard(player,effect.cards,cardSkill.name)
    local to = effect.tos[1]
    local cid = room:askToChooseCard(effect.from, { target = to, flag = "h", skill_name = cardSkill.name })
    to:showCards(cid)
    room:obtainCard(effect.from, cid, true, fk.ReasonPrey, effect.from, cardSkill.name)
  end,


})


return cardSkill

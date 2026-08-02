local skill = fk.CreateSkill {
  name = "miu_skill&",
  attached_equip = "miu",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("viewas", {
  prompt = "#miu_skill&",
  pattern = "ssaet",
  mute_card = false,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected < 2 and table.contains(player:getHandlyIds(), to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ~= 2 then return nil end
    local c = Fk:cloneCard("ssaet")
    c.skillName = "miu"
    c:addSubcards(cards)
    S.mixCard(c)
    return c
  end,
  enabled_at_play = Util.TrueFunc,
  enabled_at_response =  Util.TrueFunc,
})

-- skill:addEffect("targetmod", {
--   bypass_times = function(self, player, skill, scope, card, to)
--     if not card then
--       return false
--     end
--     if #Card:getIdList(card)==0 and card.skillName==nil then return true end--bug
--   end,
-- })
skill:addAI(nil, "vs_skill", "miu_skill")

return skill

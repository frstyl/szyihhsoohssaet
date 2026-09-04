local cardSkill = fk.CreateSkill {
  name = "thoeoms_tsshaet_skill",
}
Fk:loadTranslationTable{
  ["#thoeoms_tsshaet_skill"] = "探察 選擇一其它脚色，觀看其手牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#thoeoms_tsshaet_skill",
  target_num = 1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select ~= player
  end,
  target_filter = Util.CardTargetFilter,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    -- room:viewCards(effect.from, 
    --  { cards = target:getCardIds("h"), 
    --  skill_name = cardSkill.name, 
    --  prompt = cardSkill.name,
    -- })
    local to = effect.to
    local from= effect.from
    room:addTableMark(from,"thoeoms_tsshaet-turn", effect.to.id)
    local cards = room:askToChooseCards(from, {
        target = to,
        min = 0,
        max = 1,
        -- flag = "he",
        flag = { card_data = {{ to.general, to:getCardIds("hej") }} },  --可見
        skill_name = cardSkill.name,
        prompt = "#thoeoms_tsshaet-discard",
      })
    if #cards==0 then return end
    room:showCards(cards)
    if cards[1] and table.contains(S.getPlayerKoarbiukCards(effect.to), cards[1]) then
      room:throwCard(cards,cardSkill.name, to, from)
    end
  end,
})


cardSkill:addEffect("visibility", {
  card_visible = function(self, player, card)
    local room=Fk:currentRoom()
    for _ ,pid in ipairs(player:getTableMark("thoeoms_tsshaet-turn")) do
      if table.contains(room:getPlayerById(pid):getCardIds("hej") ,card.id) then
        return true
      end
    end
  end,
})

return cardSkill

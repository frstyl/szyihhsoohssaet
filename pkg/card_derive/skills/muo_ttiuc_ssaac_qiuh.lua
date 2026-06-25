local muo_ttiuc_ssaac_qiuh = fk.CreateSkill {
  name = "muo_ttiuc_ssaac_qiuh_skill",
}

Fk:loadTranslationTable{

  ["#muo_ttiuc_ssaac_qiuh"] = "无中生有：令一名角色对你使用殺，否則額定手牌數-1",
  ["#muo_ttiuc_ssaac_qiuh-use"] = "无中生有：对 %src 使用殺，否則額定手牌數-1",

}

muo_ttiuc_ssaac_qiuh:addEffect("cardskill", {
  prompt = "#muo_ttiuc_ssaac_qiuh",
  offset_func= Util.FalseFunc,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player 
  end,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  on_effect = function(self, room, effect)
    local player = effect.from
    local target = effect.to
    local cards = player:drawCards(2, muo_ttiuc_ssaac_qiuh.name)  --id
    local use = room:askToUseCard(target, {
      skill_name = muo_ttiuc_ssaac_qiuh.name,
      pattern = "ssaet",
      prompt = "#muo_ttiuc_ssaac_qiuh-use:"..player.id,
      extra_data = {
        exclusive_targets = {player.id},
        bypass_times = false,
      }
    })
    if use then
      room:useCard(use)
    end
    if  use and use.damageDealt then ---player?  --傷害後?
      table:filter(cards, function(cid)
        return table.contains(player:getCardIds("h"),cid)
      end)
      room:throwCard(cards, muo_ttiuc_ssaac_qiuh.name, player, player)
    else
      room:addPlayerMark(target,MarkEnum.MinusMaxCards,1)
    end
  end,
})

return muo_ttiuc_ssaac_qiuh

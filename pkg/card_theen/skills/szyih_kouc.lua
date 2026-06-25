local skill = fk.CreateSkill {
  name = "szyih_kouc_skill",
}
Fk:loadTranslationTable{
  -- ["#szyih_kouc_skill"] = "",
  ["#szyih_kouc_skill"] = "水攻 選擇一其他角色，其需選擇1項➀弃全部裝僃(无裝僃不可選),➁伱予其1傷",
  ["#szyih_kouc_use"] = "是否對 %src 使用水攻",
  ["#szyih_kouc_discard"] = "%src 對伱使用水攻 是否弃裝僃",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

skill:addEffect("cardskill", {
  prompt = "#szyih_kouc_skill",
  target_num = 1,
  can_use = function(self, player, card, extra_data)
    if player:prohibitUse(card) then return end
    return (extra_data and extra_data.koarbiuk_rule)
  end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player 
  end,
  -- fix_targets = function (self, player, card, extra_data)
  --   if extra_data and extra_data.szyih_kouc then return extra_data.szyih_kouc end
  --   return nil
  -- end,
  offset_func= Util.FalseFunc,
  target_filter = Util.CardTargetFilter,
  -- mod_target_filter = Util.TrueFunc,
  on_effect = function(self, room, effect)
    local from = effect.from
    local to = effect.to
    if #to:getCardIds("e") == 0 or
      not room:askToSkillInvoke(to, {
      skill_name = skill.name,
      prompt = "#szyih_kouc_discard:"..from.id,
      }) then
      room:damage({
        from = from,
        to = to,
        card = effect.card,
        damage = 1,
        damageType = fk.NormalDamage,
        skillName = skill.name,
      })
    else
      to:throwAllCards("e")
    end
  end,
})

-- --PreCardEffect閃歬 BeforeCardEffect CardUseFinished
-- skill:addEffect(fk.PreCardEffect, {
--   priority = 0,
--   -- global = true,
--   can_trigger = function(self, event, target, player, data)
--     return  data.card.trueName == "ssaet"  and data.to == player 
--     and not (data.disresponsive or data:isDisresponsive(player) or table.contains(data.disresponsiveList or {}, data.to)) 
--     and #S.getPlayerKoarbiukCards(player)>0
--     -- and
--     --   table.find(player:getHandlyIds(), function(id)
--     --     return Fk:getCardById(id).trueName == "szyih_kouc"

--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room = player.room
--     local cards = S.getPlayerKoarbiukCards(player)
      
--     local use = room:askToUseRealCard(data.tos[1], { --S.askToUseKoarbiukCard
--       pattern = tostring(Exppattern{ id = cards }),
--       skill_name = "szyih_kouc",  --提示
--       prompt = "#szyih_kouc_use:"..data.from.id,
--       expand_pile = cards,
--       cancelable = true,
--       skip = true,
--       extra_data = {
--         must_targets = {data.from.id},
--         exclusive_targets = {data.from.id},
--         bypass_distances = true,  --渻?
--         bypass_times = true,
--         extraUse = true,
--         szyih_kouc_response=true,
--       }
--     })
--     if use then
--       -- use.tos = {data.from}
--       room:useCard(use)
--     end
--   end,
-- })

return skill


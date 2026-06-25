local cardSkill = fk.CreateSkill {
  name = "theem_prac_kaemh_tsoavs_skill",
}
Fk:loadTranslationTable{
  ["theem_prac_kaemh_tsoavs_skill"] = "添兵減竈",

  ["#theem_prac_kaemh_tsoavs_skill"] = "添兵減竈 抵消此殺",
  ["#theem_prac_kaemh_tsoavs-use"] = "%src 對伱使用殺誘  是否使用 添兵減竈",
  ["#theem_prac_kaemh_tsoavs-ssaet"] = "添兵減竈 對 %src 使用殺",
  ["#theem_prac_kaemh_tsoavs_delay"] = "添兵減竈 效果, %tos 需對 %from 使用殺 "
}

cardSkill:addEffect("cardskill", {
  prompt = "#theem_prac_kaemh_tsoavs_skill",
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)

    if not effect.responseToEvent then return end
      effect.responseToEvent.isCancellOut = true  --應該插入旹機
      local newTarget = effect.responseToEvent.to
      newTarget:drawCards(1,cardSkill.name)  --使用者 目幖?
      effect.responseToEvent.extra_data = effect.responseToEvent.extra_data or {}
      effect.responseToEvent.extra_data.theem_prac_kaemh_tsoavs=newTarget.id
      room:addSkill("theem_prac_kaemh_tsoavs_delay")

  end,
})

-- cardSkill:addEffect(fk.PreCardEffect, {
--   global = true,
--   mute = true,
--   priority = 0,  --同旹自選 用牌?
--   can_trigger = function(self, event, target, player, data)
--     return       data.card.trueName == "ssaet" 
--       and not data.isCancellOut
--       and data.to == player 
--       and not (data.unoffsetable or data:isDisresponsive(player) or table.contains(data.unoffsetableList or {}, data.to)) 
--       and
--       table.find(player:getCardIds("h"), function(id) return Fk:getCardById(id).trueName == "theem_prac_kaemh_tsoavs" end)
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room=player.room
--     local use = room:askToUseCard(player, {
--         skill_name = cardSkill.name,
--         pattern = "theem_prac_kaemh_tsoavs",
--         prompt = "#theem_prac_kaemh_tsoavs-use:"..data.from.id,
--         cancelable = true,
--         extra_data = {
--           theem_prac_kaemh_tsoavs = true,
--         }
--       })
--     if not use then return end
--     use.toCard = data.card
--     use.responseToEvent = data  --能傳信息??
--     player.room:useCard(use)
--     -- if use.responseToEvent.isCancellOut then
--     --   return true
--     -- end
--   end,
-- })

return cardSkill

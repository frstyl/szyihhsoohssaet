local cardSkill = fk.CreateSkill {
  name = "hzvoans_tsiacs_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- function transformGeneral(room, player, isMain, isHidden, num)
--   local data = {
--     isMain = isMain,
--     isHidden = isHidden,
--     num = num,
--   }
--   if room.logic:trigger("fk.GeneralTransforming", player, data) then return false end
--   isMain = data.isMain
--   isHidden = data.isHidden
--   num = data.num
--   local orig = isMain and player.general or player.deputyGeneral
--   num = num or 3
--   if not orig then return false end
--   if orig == "anjiang" then
--     player:revealGeneral(not isMain, true)
--     orig = isMain and player.general or player.deputyGeneral
--   end
--   local existingGenerals = {}
--   for _, p in ipairs(room.players) do
--     table.insert(existingGenerals, H.getActualGeneral(p, false))
--     table.insert(existingGenerals, H.getActualGeneral(p, true))
--   end
--   local kingdom = player:getMark("__heg_kingdom")
--   if kingdom == "wild" then
--     kingdom = player:getMark("__heg_init_kingdom")
--   end
--   local generals = room:findGenerals(function(g)
--     return Fk.generals[g].kingdom == kingdom or Fk.generals[g].subkingdom== kingdom
--   end, num)
--   local general = room:askToChooseGeneral(player, {generals = generals, n = 1, no_convert = true}) ---@type string
--   table.removeOne(generals, general)
--   table.insert(generals, orig)
--   room:returnToGeneralPile(generals)
--   room:changeHero(player, general, false, not isMain, not isHidden, false, false)
--   --暗置变更
--   if isHidden then
--     player:hideGeneral(not isMain)
--     room:sendLog{
--       type = "#ChangeHiddenGeneral",
--       from = player.id,
--       toast = true,
--     }
--   end
--   room:setPlayerMark(player, isMain and "__heg_general" or "__heg_deputy", general)
--   room.logic:trigger("fk.GeneralTransformed", player, orig)
-- end

-- Fk:loadTranslationTable{
--   ["#ChangeHiddenGeneral"] = "%from 变更了 副将（暗置）",
-- }

cardSkill:addEffect("cardskill", {
  prompt = "#hzvoans_tsiacs_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = function(self, player, card, extra_data)
    return  S.magicCanUse(player, card, extra_data)
  end,
  target_num=1,
  target_filter = function(self, player, to_select, selected, _, card, extra_data)
    return S.useToSelfFilter(self, player, to_select, selected, _, card, extra_data)
  end,
  offset_func= Util.FalseFunc,
  on_use = function(self, room, cardUseEvent)
    S.magicOnUse(cardUseEvent.from, cardUseEvent)
    end,
  on_effect = function(self, room, effect)
    local player=effect.to
    local generals  = room:getNGenerals(3,"top")
    local general = room:askToChooseGeneral(player, {generals = generals, n = 1, no_convert = true}) ---@type string
    table.removeOne(generals, general)

    local isDeputy=false
    if player.deputyGeneral and player.deputyGeneral~="" then
      isDeputy=room:askToChoice(player, {choices = {"mainGeneral", "deputyGeneral"}, skill_name = cardSkill.name}) == "deputyGeneral"
    end
    local orig = isDeputy and   player.deputyGeneral or player.general
    table.insert(generals, orig)
    room:returnToGeneralPile(generals)
    room:changeHero(player, general, false,  isDeputy, true, false, true)
  end,
})

return cardSkill

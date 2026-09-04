local skill = fk.CreateSkill {
  name = "tsjek_tshoavh_doon_liac_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- Fk:loadTranslationTable{ 
--   ["#tsjek_tshoavh_doon_liac_skill"] = "積艸屯糧 延旹 越過撤段" ,
-- }

skill:addEffect("cardskill", {
  prompt = "#tsjek_tshoavh_doon_liac_skill",
  can_use = Util.CanUse,
  mod_target_filter = Util.TrueFunc,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not (effect.extar_data and  effect.extar_data.phase_data) then return end
    local to = effect.to
    local judge = {
      who = to,
      reason = "tsjek_tshoavh_doon_liac",
      pattern = ".|.|heart,spade,club",
    }
    room:judge(judge)
    if  judge.card then
      if room:getCardArea(judge.card)==Card.DiscardPile and not to.dead then
        room:obtainCard(to, judge.card , true, fk.ReasonPrey, player, self.name)
      end
      if judge.card.getSuitString ~= Card.Diamond then
      -- to:skip(Player.Discard)
        -- S.skipPhase(to.id , Player.Discard)
        effect.extar_data.phase_data.skipped=true
      end
    else 
      to:skip(Player.Discard)  --占卜有果且爲♦️无效
    end
    
    self:onNullified(room, effect)
  end,
  on_nullified = function(self, room, effect)
    room:moveCards{
      ids = room:getSubcardsByRule(effect.card, { Card.Processing }),
      toArea = Card.DiscardPile,
      moveReason = fk.ReasonUse,
    }
  end,
})

return skill


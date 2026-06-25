local skill = fk.CreateSkill {
  name = "tsjek_tshoavh_doon_liac_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{ 
  ["#tsjek_tshoavh_doon_liac_skill"] = "積艸屯糧 延旹類 越弃段" ,
}

skill:addEffect("cardskill", {
  prompt = "#tsjek_tshoavh_doon_liac_skill",
  can_use = Util.CanUse,
  mod_target_filter = Util.TrueFunc,
  target_filter = Util.CardTargetFilter,
  target_num = 1,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local to = effect.to
    local judge = {
      who = to,
      reason = "tsjek_tshoavh_doon_liac",
      pattern = ".|.|heart,spade,club",
    }
    room:judge(judge)
    if  judge.card then
        room:obtainCard(to, judge.card , true, fk.ReasonJustMove, player, self.name)
        if judge.card.getSuitString ~= Card.Diamond then
        -- to:skip(Player.Discard)
         S.skipPhase(to.id , Player.Discard)
        end
    else 
      to:skip(Player.Discard)  --判定有果且爲♦️无效
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


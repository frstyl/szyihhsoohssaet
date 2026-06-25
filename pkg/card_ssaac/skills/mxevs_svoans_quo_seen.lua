local cardSkill = fk.CreateSkill {
  name = "mxevs_svoans_quo_seen_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#mxevs_svoans_quo_seen_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = Util.CanUseToSelf,
  on_effect = function(self, room, effect)
    room:setPlayerMark(effect.to,"@@mxevs_svoans_quo_seen-turn",1)
    local ids= S.getKhouc(room,1)
    local names={"dzzuoh_dzziach_khoeoj_hsfa","tsjas_toav_ssaet_nzjin","buak_koavh_qwe_nzjin","muo_ttiuc_ssaac_qiuh"}
    local name=room:askToChoice(effect.to, { choices = names, skill_name = "mxevs_svoans_quo_seen_skill", prompt = "#mxevs_svoans_quo_seen_skill-choose" })
    room:setCardMark(Fk:getCardById(ids[1]),"@@khouc_filter_view_as",name)
    room:moveCards({
      ids = ids,
      to = effect.to,
      toArea = Card.PlayerHand,
      moveReason = fk.ReasonJustMove,
      proposer = effect.from,
      skillName = cardSkill.name,
      moveVisible = true,
    })
    Fk:filterCard(ids[1], effect.to)
    room:addSkill("mxevs_svoans_quo_seen_buff")
  end,
})


return cardSkill

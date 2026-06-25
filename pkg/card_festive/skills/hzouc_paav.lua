local cardSkill = fk.CreateSkill {
  name = "hzouc_paav_skill",
}

Fk:loadTranslationTable{
  ["hzouc_paav_skill"] = "紅包",
  ["#hzouc_paav-choose:"] = "紅包 選擇牌類",

}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt = "#hzouc_paav_skill",
  -- mod_target_filter = function(self, player, to_select)
  --   return to_select:getMark("hzouc_paav")==0
  -- end,
  can_use = Util.CanUseToSelf,
  mod_target_filter = Util.TrueFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local player=effect.to
    if effect.to.dead then return end
    local choices={"basic","trick","equip","magic","allusion"}  --S.
    local choice = room:askToChoice(player, {
      choices = choices,
      skill_name = cardSkill.name,
      prompt = "#hzouc_paav-choose",
    })

    local pattern  =tostring(Exppattern{ name=S.getCardTypeByName(table.indexOf(choices,choice),true)})
    local n=1
    if math.random(1,4)==1 then n=2 end
    local cards=room:getCardsFromPileByRule(pattern,n)
    room:moveCards({
        ids = cards,
        to = player,
        toArea = Card.PlayerHand,
        moveReason = fk.ReasonJustMove,  --Prey?
        proposer = player,
        skillName = cardSkill.name,
      })
  end,
})

return cardSkill

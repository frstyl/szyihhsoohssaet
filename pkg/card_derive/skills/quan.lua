local cardSKill = fk.CreateSkill {
  name = "quan_skill",
}

cardSKill:addEffect("cardskill", {
  prompt = "#quan_skill",
  mod_target_filter = Util.TrueFunc,
  can_use = Util.CanUseToSelf,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    local n=player.maxHp-player:getHandcardNum()
    if n>0 then
      effect.to:drawCards(n, cardSKill.name)
    end
  end,
})

return cardSKill

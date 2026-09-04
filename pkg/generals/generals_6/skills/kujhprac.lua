local kujhprac = fk.CreateSkill {
  name = "kujhprac",
}

Fk:loadTranslationTable{
["kujhprac"] = "鬼兵",
[":kujhprac"] = "印牌:虛擬起動或演練｢殺｣｡發動後伱占卜,若占卜牌爲♥️,中止且此技能1段失效",
["#kujhprac"] = "鬼兵:  占卜 若占卜牌不爲♥️ 伱起動或演練虛擬殺",
}

kujhprac:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "ssaet|0|nosuit|none",  --
  prompt = "#kujhprac",
  mute_card = true,
  view_as = function(self, player, cards)
    local c = Fk:cloneCard("ssaet")
    c.skillName = kujhprac.name
    -- player.room:setCardArea(c.id,Card.PlayerHand, player.id)
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room
    local judgeData = {
      who = player,
      reason = kujhprac.name,
      pattern = ".|.|^heart",
    }
    room:judge(judgeData)
    if not judgeData:matchPattern() then 
      room:invalidateSkill(player, kujhprac.name,"-phase")  --待改
      return kujhprac.name
    end
  end,
})


return kujhprac

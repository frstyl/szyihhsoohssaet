local kujhprac = fk.CreateSkill {
  name = "kujhprac",
}

Fk:loadTranslationTable{
["kujhprac"] = "鬼兵",
[":kujhprac"] = "當伱可使用打出殺旹,伱可預視爲于元機虛擬執行,發動,執行前伱判定,若判定牌爲♥️,中止使用且此技能當段失效",
["#kujhprac"] = "鬼兵:  判定 若判定牌无花色或花色非紅桃 視若伱使用打出殺",
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

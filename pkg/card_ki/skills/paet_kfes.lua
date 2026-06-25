local paet_kfes = fk.CreateSkill {
  name = "paet_kfes",
}

Fk:loadTranslationTable{
["paet_kfes"] = "鬼兵",
[":paet_kfes"] = "當伱可使用打出(虛无色无點无屬)殺旹,伱可發動.伱判定,若判定牌无花色或花色非紅桃,視爲伱(于元旹機)執行之,否則此技能本轉失效",
["#paet_kfes"] = "鬼兵:  判定 若判定牌无花色或花色非紅桃 視若伱使用打出殺",
}

paet_kfes:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "szjemh",  --
  prompt = "#paet_kfes",
  mute_card = true,
  -- handly_pile = true,
  -- card_filter = function(self, player, to_select, selected)
  --   return #selected == 0 and Fk:getCardById(to_select).color == Card.Red
  -- end,
  view_as = function(self, player, cards)
    local c = Fk:cloneCard("szjemh")
    c.skillName = paet_kfes.name
    return c
  end,
  before_use = function (self, player, use)
    local room = player.room
    local judgeData = {
      who = player,
      reason = paet_kfes.name,
      pattern = ".|.|diamond,heart,nosuitred",
    }
    room:judge(judgeData)
    if not judgeData:matchPattern() then 
      room:invalidateSkill(player, paet_kfes.name,"-turn")  --待改
      return ""
    end
  end,
})


return paet_kfes

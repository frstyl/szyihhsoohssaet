local meejqtsyis = fk.CreateSkill{
  name = "meejqtsyis",
}

Fk:loadTranslationTable{
  ["meejqtsyis"] = "迷醉",
  [":meejqtsyis"] = "印牌:以伱n♥️手牌轉起動｢酒｣｡起動後伱爲至多n其它腳色附加｢魅影｣",

  ["#meejqtsyis"] = "迷醉：♥️手牌當酒",

  ["$meejqtsyis1"] = "人扶醉 月依牆",

}

meejqtsyis:addEffect("viewas", {
  anim_type = "offensive",
  pattern = "tsiuh",
  prompt = "#meejqtsyis",
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return  Fk:getCardById(to_select).suit == Card.Heart and
      table.contains(player:getCardIds("h"),to_select)
  end,
  view_as = function(self, player, cards)
    if #cards ==0  then return nil end
    local c = Fk:cloneCard("tsiuh")
    c.skillName = meejqtsyis.name
    c:addSubcards(cards)
    return c
  end,
  after_use = function(self, player, use)
    
    use.extar_data =use.extar_data or {}
    use.extar_data.meejqtsyis=#use.card.subcards
  end,
  after_use = function(self, player, use)
    local room=player.room
     local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = player.room:getOtherPlayer(player),
      skill_name = meejqtsyis.name,
      prompt = "#meejqtsyis-choose",
      cancelable = true,
    })
    if #tos > 0 then
      for _,p in iparis(tos) do
        if not p.daed then
          S.addTsziukzzyitBuff(p,  "mxishqrach",player) 
        end
      end
    end
  end,
})



return meejqtsyis
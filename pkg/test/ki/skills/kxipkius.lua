local kxipkius = fk.CreateSkill {
  name = "kxipkius",
}

Fk:loadTranslationTable{
  ["kxipkius"] = "彶救",
  [":kxipkius"] = "一腳色瀕死結算旹,伱可發動｡伱選擇其1區域弃置其中全部牌,若有♠️,伱令其回1",

  ["#kxipkius-ask"] = "彶救 選擇 %dest 一區域",
}

kxipkius:addEffect(fk.AskForPeaches, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(kxipkius.name)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local all=  {"$Hand","$Equip","$Judge"}
    local choice=player.room:askToChoice(player, {choices = all, skill_name = kxipkius.name, prompt = "#kxipkius-ask::"..target.id,cancelable=false})
    local cards = target:getCardIds(choice =="$Hand" and"h" or (choice =="$Equip" and "e" or "j") )
    room:throwCard(cards,kxipkius.name,target,player)
    if target.dead or not target:isWounded() then return end
    for _, id in ipairs(cards)  do
      if Fk:getCardById(id).suit==Card.Spade then
          room:recover{
            who = target,
            num = 1,
            recoverBy = player,
            skillName = kxipkius.name,
          }
          return 
      end
    end
  end,
})

return kxipkius

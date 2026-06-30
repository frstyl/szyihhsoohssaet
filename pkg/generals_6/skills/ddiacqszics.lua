local ddiacqszics = fk.CreateSkill{
  name = "ddiacqszics",
}

Fk:loadTranslationTable{
  ["ddiacqszics"] = "常勝",
  [":ddiacqszics"] = "伱拼點旹,若伱拼點牌爲{♠️/♥️}伱可發動,伱令伱拼點牌{加/減}1至多點",

  ["#ddiacqszics-invoke"] = "常勝 %arg 點數",

  ["$ddiacqszics1"] = "应天合人，岂非天心人意乎？",
  ["$ddiacqszics2"] = "非以权势取之，实天命所归也！",
}

ddiacqszics:addEffect(fk.PindianCardsDisplayed, {
  can_trigger = function(self, event, target, player, data)
    if player:hasSkill(ddiacqszics.name) 
      and (
      (player == data.from and table.contains({Card.Heart,Card.Spade}, data.fromCard.suit))
      or (player==data.to and table.contains({Card.Heart,Card.Spade}, data.toCard.suit))
      )
    then
      return true
    end
  end,
  on_cost = function(self, event, target, player, data)
      local choices = {}
      for i = 1, 13 do
        table.insert(choices, tostring(i))
      end
      table.insert(choices,"Cancel")

    local card=player == data.from  and data.fromCard or data.toCard
    local number = player.room:askToChoice(player, {
        choices = choices,
        skill_name = ddiacqszics.name,
        prompt = "#ddiacqszics-invoke:"..card:toLogString()
      })
      if number~="Cancel" then

        local symbol = card.suit==Card.Spade and 1 or  -1
        event:setCostData(self,{n=symbol * tonumber(number),cid=card.id })
        return true
      end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:changePindianNumber(data, player, event:getCostData(self).n, ddiacqszics.name)
  end,
})

return ddiacqszics

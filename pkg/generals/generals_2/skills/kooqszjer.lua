

local kooqtsjins= fk.CreateSkill({
  name = "kooqtsjins",
})

Fk:loadTranslationTable{
["kooqtsjins"] = "孤進",
[":kooqtsjins"] = "印牌:起動或演練虛擬｢{殺/閃}｣｡須手牌數不爲x可發動,起動前將手牌抽或弃至x,x爲伱已損體力數",
["#kooqtsjins"] = "孤進 手牌調爲1以起動殺閃",

["#kooqtsjins"] = "孤勢 起動或演練殺閃",
}

kooqtsjins:addEffect("viewas", {
  pattern = "ssaet,szjemh|0|nosuit|none",
  anim_type = "defensive",
  prompt = "kooqtsjins",
  card_filter = Util.FalseFunc,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh"}

    return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local card = Fk:cloneCard(self.interaction.data)
    card.skillName = kooqtsjins.name
    return card
  end,
  enabled_at_play = function(self, player) 
    return  #player:getCardIds("h")~=player:getLostHp()
  end,
  enabled_at_response = function(self, player, response) 
    return   #player:getCardIds("h")~=player:getLostHp()
  end,
  before_use = function(self, player, use)
    local n = #player:getCardIds("h")-player:getLostHp()
    if n<0 then
      player:drawCards(-n,kooqtsjins.name)
    else
      player.room:askToDiscard(player, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = kooqtsjins.name,
        cancelable = false,
      })
    end
  end,
})

return kooqtsjins

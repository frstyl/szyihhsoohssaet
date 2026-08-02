

local kooqszjer= fk.CreateSkill({
  name = "kooqszjer",
})

Fk:loadTranslationTable{
["kooqszjer"] = "孤勢",
[":kooqszjer"] = "印牌:起動演練虛擬{殺/閃}｡將手牌抽弃至1發動",
["#kooqszjer"] = "先登 手牌調爲1以起動殺閃",

["#kooqszjer"] = "孤勢 起動演練殺閃",
}

kooqszjer:addEffect("viewas", {
  pattern = "ssaet,szjemh|0|nosuit|none",
  anim_type = "defensive",
  prompt = "kooqszjer",
  card_filter = Util.FalseFunc,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh"}

    return UI.CardNameBox {choices = all_names, all_choices = all_names }
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data then return nil end
    local card = Fk:cloneCard(self.interaction.data)
    card.skillName = kooqszjer.name
    return card
  end,
  enabled_at_play = function(self, player) 
    return  #player:getCardIds("h")~=1
  end,
  enabled_at_response = function(self, player, response) 
    return   #player:getCardIds("h")~=1
  end,
  before_use = function(self, player, use)
    local n = #player:getCardIds("h")-1
    if n<0 then
      player:drawCards(-n,kooqszjer.name)
    else
      player.room:askToDiscard(player, {
        min_num = n,
        max_num = n,
        include_equip = false,
        skill_name = kooqszjer.name,
        cancelable = false,
      })
    end
  end,
})

return kooqszjer

local seenhliak = fk.CreateSkill {
  name = "seenhliak",
}

Fk:loadTranslationTable{
  ["seenhliak"] = "洗掠",
  [":seenhliak"] = "主旹,取得其它脚色區域全部牌",

  ["#seenhliak"] = "洗掠 選擇脚色",

  ["$seenhliak1"] = "人人爲公,天下大同",
  ["$seenhliak2"] = "有福同享,有難同當",
}

seenhliak:addEffect("active", {
  anim_type = "control",
  min_target_num = 1,
  max_target_num = 999,
  prompt = "#seenhliak",
  can_use = function(self, player)
    return true
  end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
      return   to_select~=player
  end,
  on_use = function(self, room, effect)
    local cards ={}
    for _,p in ipairs(effect.tos) do
      table.insertTableIfNeed(cards,p:getCardIds("hej") )
    end
    room:obtainCard(effect.from, cards, false, fk.ReasonPrey, effect.from,seenhliak.name,nil,nil)
  end,
})


return seenhliak

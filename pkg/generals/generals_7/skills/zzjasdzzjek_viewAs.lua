local zzjasdzzjek_view = fk.CreateSkill{
  name = "zzjasdzzjek_view&",
}

Fk:loadTranslationTable{
["zzjasdzzjek_view"] = "射石",  --沒鉃
[":zzjasdzzjek_view"] = "射石 將記錄花色轉化爲殺",
["#zzjasdzzjek_view-active"] = "射石 將記錄花色轉化爲殺",


["$zzjasdzzjek_view1"] = "伱可知我飛石手段",
["$zzjasdzzjek_view2"] = "飛蝗如雨,看伱等翻成畫餅",
}



zzjasdzzjek_view:addEffect("viewas", {
  anim_type = "offensive",
  -- pattern = "ssaet",
  prompt = "#zzjasdzzjek_view-active",
  mute_card = true,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getTableMark("@zzjasdzzjek_view-turn"), Fk:getCardById(to_select):getSuitString(true) )
  end,
  view_as = function(self, player, cards)
    if #cards ~= 1 then return end
    local c = Fk:cloneCard("ssaet")
    c.skillName = zzjasdzzjek_view.name
    c:addSubcard(cards[1])
    return c
  end,
  enabled_at_response = function(self, player, response) --響應
    return  not response  --此response为投出 不能用于投出 
  end,
})

return zzjasdzzjek_view

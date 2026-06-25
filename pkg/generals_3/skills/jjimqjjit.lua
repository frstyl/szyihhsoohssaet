local jjimqjjit = fk.CreateSkill {
  name = "jjimqjjit",
}

Fk:loadTranslationTable{
["jjimqjjit"] = "淫泆",
[":jjimqjjit"] = "主旹,限1次.伱指定1其它角色發動.其聲明一花色,伱可交与其所聲明花色之牌,視爲伱使用酒(无視次數)",

["#jjimqjjit"] = "淫泆: 指定1其它角色發動.其聲明一花色,伱可交与其所聲明花色之牌,視爲伱使用酒(无視次數)",
["#jjimqjjit-choose"] = "淫泆 令%src交与伱某花色牌",
["#jjimqjjit-ask"] = "交与%src %arg 牌",
}

jjimqjjit:addEffect("active", {
  anim_type = "control",
  card_num = 0,
  target_num = 1,
  prompt = "#jjimqjjit",
  max_phase_use_time=1,

  -- card_filter = function(self, player, to_select, selected)
  -- end,
  target_filter = function(self, player, to_select, selected, selected_cards)
      return to_select~=player
  end,
  on_use = function(self, room, effect)
    local player=effect.from
    local choices={"log_spade", "log_club", "log_heart", "log_diamond"}
    local suit = room:askToChoice(effect.tos[1], {
      skill_name = "jjimqjjit", 
      prompt = "#jjimqjjit-choose:"..effect.from.id,
      choices = choices,
    })

    local suit=suit:split("_")[2]
    local cid=room:askToCards(player, {
      skill_name = jjimqjjit.name,
      min_num = 0,
      max_num = 1,
      pattern = ".|.|"..suit,
      include_equip=true,
      prompt = "#jjimqjjit-ask:"..effect.tos[1].id.."::"..suit,
    })
    if #cid>0 then
      room:moveCardTo(cid, Player.Hand, effect.tos[1], fk.ReasonGive, jjimqjjit.name, nil, false, player.id)
        player.room:useVirtualCard("tsiuh", nil, player, player,jjimqjjit.name,true)
    end
  end,
})
return jjimqjjit

local jinhkeens = fk.CreateSkill {
  name = "jinhkeens",
}

Fk:loadTranslationTable{
  ["jinhkeens"] = "引見",
  [":jinhkeens"] = "主段限1.主旹,伱可選1至多手牌与1其它角色發動,將牌交予該角色.得牌者可再次執行引見,不可選當次流程已選目幖,所選牌數至多爲得牌數-1",  --規則技?


  ["#jinhkeens-invoke"] = "引見 交予其它角色1至x手牌,其可再傳遞x-1牌",
  ["#jinhkeens-choose"] = "引見 交予其它角色至多 %arg 牌",


  ["$jinhkeens1"] = "今进退两难，势若引見，魏王必当罢兵而还。",
  ["$jinhkeens2"] = "汝可令士卒收拾行装，魏王明日必定退兵。",
}

jinhkeens:addEffect("active", {
  anim_type = "support",
  prompt = "#jinhkeens-active",
  min_card_num = 1,
  target_num = 1,
  max_phase_use_time=1,
  card_filter = function(self, player, to_select, selected)
    return table.contains(player:getCardIds("h"), to_select)
  end,
  target_filter = function(self, player, to_select, selected)
    return #selected == 0 and to_select ~= player
  end,
  on_use = function(self, room, effect)
    local target = effect.tos[1]
    local player = effect.from
    local cards = effect.cards
    local n = #cards
    room:moveCardTo(cards, Player.Hand, target, fk.ReasonGive, jinhkeens.name, nil, false, player.id)
    if n<=1 then return end
    local tos =table.filter(room.alive_players,function(p)
    return p~=player and p~=target
    end)
    n=n-1
    while true do
      local to, ids = room:askToChooseCardsAndPlayers(target, {
        min_card_num = 1,
        max_card_num = n,
        min_num = 1,
        max_num = 1,
        targets =tos,
        skill_name = jinhkeens.name,
        prompt = "#jinhkeens-choose:::"..n,
        cancelable = true,
      })
      if #to==0 or #ids==0 then return end
      room:moveCardTo(ids, Player.Hand, to[1], fk.ReasonGive, jinhkeens.name, nil, false, target.id)
      if n<=1 or #tos<=1 then return end
      target=to[1]
      n=n-1
      table.removeOne(tos,to[1])
    end
  end,
})

return jinhkeens

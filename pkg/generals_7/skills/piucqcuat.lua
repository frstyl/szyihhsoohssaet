Fk:loadTranslationTable{
  ["piucqcuat"] = "風月",
  [":piucqcuat"] = "末段發動.伱抽1,若有其它存活女角色,改爲抽2,伱選1牌交与1女角色",

  ["$piucqcuat1"] = "惹得煙花三兩支",
  ["#piucqcuat-give-choose"] = "風月 選擇 1 牌交与1其它女角色",

}

local piucqcuat = fk.CreateSkill{
  name = "piucqcuat",
}

piucqcuat:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(piucqcuat.name) and player.phase == Player.Finish
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local ps={}
    for _,p in ipairs(room:getOtherPlayers(player)) do
      if p:isFemale() then
        table.insert(ps,p)
      end
    end
    if #ps==0 then
      player:drawCards(1, piucqcuat.name)
      return 
    end
      player:drawCards(2, piucqcuat.name)
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        min_num = 1,
        max_num = 1,
        targets = ps,
        skill_name = piucqcuat.name,
        prompt = "#piucqcuat-give-choose",
        cancelable = flase,  --theemh
        will_throw = false,
      })
      if #tos>0 and #cards>0 then
        room:moveCardTo(cards, Player.Hand, tos[1], fk.ReasonGive, piucqcuat.name, nil, false, tos[1].id)
      end
    
    

  end,
})


return piucqcuat

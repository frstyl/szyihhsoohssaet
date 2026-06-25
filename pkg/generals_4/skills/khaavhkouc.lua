
local khaavhkouc = fk.CreateSkill {
  name = "khaavhkouc",
}

Fk:loadTranslationTable{
  ["khaavhkouc"] = "巧工",
  [":khaavhkouc"] = "主旹,伱可選➀一角色裝僃區1裝僃牌發動.伱復刻之(同名无花无點),將復刻牌置入一角色裝僃區.復刻牌進入弃牌堆銷毀.➁2角色裝僃區牌數差不大于伱已選體力值者發動,交換其裝僃區內牌",

  ["#khaavhkouc"] = "巧工：選一名角色裝僃區內一裝僃復刻之,或選2角色,裝僃區牌數差不大于 %arg 者 交換其裝僃區牌",
  ["#khaavhkouc-choose_target"] = "巧工",
  ["#khaavhkouc-choose_card"] = "巧工",

  ["@@khaavhkouc"] = "巧工",

  ["$khaavhkouc1"] = "昰細巧手段如何。",
  ["$khaavhkouc2"] = "粗中有細",
}
-- khaavhkouc:addEffect(fk.EventPhaseStart, {
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(khaavhkouc.name) and player.phase == Player.Start 
--   end,
--   on_cost = function(self, event, target, player, data)
--     local tos = room:askToChoosePlayers(player, {
--       min_num = 1,
--       max_num = 2,
--       targets = room.alive_players,
--       skill_name = khaavhkouc.name,
--       prompt = "#khaavhkouc-choose",
--       cancelable = true,
--     })
--     if #tos>0 then 
--       event:setCostData(slef,{tos=tos})
--       return true
--     end
--   end,
--   on_use = function(self, event, target, player, data)
--   end,
-- })

khaavhkouc:addEffect("active", {
  anim_type = "control",
  prompt = function(self, player)
    return "#khaavhkouc:::"..player:getLostHp()
  end,
  card_num = 0,
  min_target_num = 2,
  max_target_num = 2,
  max_phase_use_time=1,
  -- can_use = function(self, player)
  --   return player:usedSkillTimes(khaavhkouc.name, Player.HistoryPhase) == 0
  -- end,
  card_filter = Util.FalseFunc,
  target_filter = function(self, player, to_select, selected)
    if #selected == 0 then
      return true
    elseif #selected == 1 then
      return math.abs(#to_select:getCardIds("e") - #selected[1]:getCardIds("e")) <= player:getLostHp() 
      -- and
      --   not (#to_select:getCardIds("e") == 0 and #selected[1]:getCardIds("e") == 0)
    end
  end,
  feasible = function (self, player, selected, selected_cards)
    return #selected==1 and #selected[1]:getCardIds("e")>0 
    or (#selected==2)
  end,
  on_use = function(self, room, effect)
    local player=effect.from
    if #effect.tos==1 then
      local c=Fk:getCardById(room:askToChooseCard(player,{
        target = effect.tos[1],
          -- flag ="e",
        flag = { card_data = {{ effect.tos[1].general, table.filter(effect.tos[1]:getCardIds("e"), function(id )return Fk:getCardById(id).type==Card.TypeEquip end) }} },  --可見
        skill_name = "khaavhkouc",
        prompt = "#khaavhkouc-choose_card",
        }))
    -- local card = room:printCard(c.name, c.suit, c.number)
    local card = room:printCard(c.name)
    room:setCardMark(card, MarkEnum.DestructIntoDiscard, 1)
    room:setCardMark(card, "@@khaavhkouc", 1)
    -- card.extra_data=card.extra_data or {}
    -- card.extra_data.khaavhkouc=true
    local tos = room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = room.alive_players,
      skill_name = khaavhkouc.name,
      prompt = "#khaavhkouc-choose_tartget",
      cancelable = true,
    })
    if #tos==0  then tos = {player} end
    -- room:moveCardTo(card, Card.PlayerHand, tos[1], fk.ReasonGive, khaavhkouc.name, nil, false, player)
    room:moveCardIntoEquip(tos[1], {card.id}, khaavhkouc.name, true, player)
    else 
    room:swapAllCards(effect.from, effect.tos, khaavhkouc.name, "e")
    end
  end,
})

return khaavhkouc

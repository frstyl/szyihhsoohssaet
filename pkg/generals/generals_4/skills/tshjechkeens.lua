local tshjechkeens = fk.CreateSkill {
  name = "tshjechkeens",
}

Fk:loadTranslationTable{
  ["tshjechkeens"] = "請見",
  [":tshjechkeens"] = "伱額定抽牌後,選2手牌与1其它脚色A發動.伱將所選牌交予A,其抽2展示之,若同色,伱令其回1,若同花,其令伱回1",

  -- ["#tshjechkeens"] = "請見 選擇脚色計謀",
  ["#tshjechkeens-invoke"] = "請見 選擇2牌脚色計謀",

  ["$tshjechkeens1"] = "昰般禮物 此封家書 需与我送至",
  ["$tshjechkeens2"] = "星夜走去一遭 不可沿途耽擱",

  ["$tshjechkeens3"] = "厽承厚意 何已克當",
  ["$tshjechkeens4"] = "此乃今上之恩 自當獻酬百拜",

  ["$tshjechkeens5"] = "恭喜早晚必有榮除之慶",
  ["$tshjechkeens6"] = "家尊早晚奏過今上 通判必會昇擢高任",
}


tshjechkeens:addEffect(fk.AfterDrawNCards, {  --EventPhaseStart
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(tshjechkeens.name)
     and player:getHandcardNum()>1
  end,
  on_cost = function(self, event, target, player, data)
    local tos, cards = room:askToChooseCardsAndPlayers(player, {
      min_num = 1,
      max_num = 1,
      min_card_num = 2,
      max_card_num = 2,
      targets = player.room:getOtherPlayers(player),
      pattern = ".",
      skill_name = tshjechkeens.name,
      prompt = "#tshjechkeens-invoke",
      cancelable = true,
    })
    if #tos > 0 and #cards > 1 then
      event:setCostData(self, {tos = tos, cards = cards})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room=player.room
    local from=player
    local to=event:getCostData(self).tos[1]
    room:moveCardTo(event:getCostData(self).cards, Player.Hand, to, fk.ReasonGive, tshjechkeens.name, nil, false, from.id)
    local cards=to:drawCards(2,tshjechkeens.name)
    local card1 = Fk:getCardById(cards[1])
    local card2 = Fk:getCardById(cards[2])
    to:showCards(cards)  --死了也執行
    if card1:compareColorWith(card2) and not from.dead then 
      room:recover({
        who = to,
        num = 1,
        recoverBy = from,
        skillName = tshjechkeens.name,
      })
    end
    if card1:compareSuitWith(card2) and not to.dead then
      room:recover({
        who = from,
        num = 1,
        recoverBy = to,
        skillName = tshjechkeens.name,
      })
    end
  end,
})
-- tshjechkeens:addEffect("active", {
--   anim_type = "control",
--   target_num = 1,
--   card_num = 2,
--   prompt = "#tshjechkeens",
--   can_use = function(self, player)
--     return player:usedSkillTimes(tshjechkeens.name, Player.HistoryPhase) == 0
--   end,
--   card_filter = function(self, player, to_select, selected)
--     return #selected < 2
--   end,
--   -- target_filter = function(self, player, to_select, selected, selected_cards)
--   --     return #selected == 0 
--   -- end,
--   target_filter = function(self, player, to_select, selected)
--     return   to_select~=player
--   end,
--   on_use = function(self, room, effect)
--     local from=effect.from
--     local to=effect.tos[1]
--     room:moveCardTo(effect.cards, Player.Hand, to, fk.ReasonGive, tshjechkeens.name, nil, false, from.id)
--     local cards=to:drawCards(2,tshjechkeens.name)
--     local card1 = Fk:getCardById(cards[1])
--     local card2 = Fk:getCardById(cards[2])
--     to:showCards(cards)  --死了也執行
--     if card1:compareColorWith(card2) and not from.dead then 
--       room:recover({
--         who = to,
--         num = 1,
--         recoverBy = from,
--         skillName = tshjechkeens.name,
--       })
--     end
--     if card1:compareSuitWith(card2) and not to.dead then
--       room:recover({
--         who = from,
--         num = 1,
--         recoverBy = to,
--         skillName = tshjechkeens.name,
--       })
--     end
--   end,
-- })

return tshjechkeens

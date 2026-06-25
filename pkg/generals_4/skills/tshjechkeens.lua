local tshjechkeens = fk.CreateSkill {
  name = "tshjechkeens",
}

Fk:loadTranslationTable{
  ["tshjechkeens"] = "請見",
  [":tshjechkeens"] = "主旹,預選2手牌与1其他角色發動.伱將所選牌交予該角色,其抽2展示之,若同色,伱令其回1,若同花,其令伱回1",

  ["#tshjechkeens"] = "請見 選擇角色錦囊",

  ["$tshjechkeens1"] = "昰般禮物此封家書需与我送至",
  ["$tshjechkeens2"] = "星夜走去一遭不可沿途耽擱",

  ["$tshjechkeens3"] = "厽承厚意何已克當",
  ["$tshjechkeens4"] = "此乃今上之恩自當獻酬百拜",

  ["$tshjechkeens2"] = "恭喜早晚必有榮除之慶",
  ["$tshjechkeens2"] = "家尊早晚奏過今上 通判必會昇擢高任",
}

tshjechkeens:addEffect("active", {
  anim_type = "control",
  target_num = 1,
  card_num = 2,
  prompt = "#tshjechkeens",
  can_use = function(self, player)
    return player:usedSkillTimes(tshjechkeens.name, Player.HistoryPhase) == 0
  end,
  card_filter = function(self, player, to_select, selected)
    return #selected < 2
  end,
  -- target_filter = function(self, player, to_select, selected, selected_cards)
  --     return #selected == 0 
  -- end,
  target_filter = function(self, player, to_select, selected)
    return   to_select~=player
  end,
  on_use = function(self, room, effect)
    local from=effect.from
    local to=effect.tos[1]
    room:moveCardTo(effect.cards, Player.Hand, to, fk.ReasonGive, tshjechkeens.name, nil, false, from.id)
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

return tshjechkeens

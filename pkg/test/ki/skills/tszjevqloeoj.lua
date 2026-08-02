Fk:loadTranslationTable{
  ["tszjevqloeoj"] = "招徠",
  [":tszjevqloeoj"] = "主旹,伱可展示2手牌發動｡自牌堆弃牌堆隨機檢索3牌點數処于所展示牌點數之閒者,伱選擇其1獲得",

  ["#tszjevqloeoj-active"] = "招徠  展示2手牌發動",

  ["#tszjevqloeoj-discard"] = "招徠 ",

  ["tszjevqloeoj_liak"] = "略",
  ["damage"] = "致傷 ",
}

local tszjevqloeoj = fk.CreateSkill{
  name = "tszjevqloeoj",
}


tszjevqloeoj:addEffect("active", {
  anim_type = "offensive",
  prompt = "#tszjevqloeoj-active",
  target_num = 0,
  -- min_card_num = 3,
  -- max_card_num = 4,
  card_num=2,
  expand_pile = "tszjevqloeoj_liak",
  max_phase_use_time = 1,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"damage","discard"},
  --   }
  -- end,
  card_filter = function(self, player, to_select, selected)--5 -< 7
    return
      table.contains(player:getCardIds("h"), to_select)
      --  and not player:prohibitDiscard(to_select) 
      -- and Fk:getCardById(to_select).suit~=Card.NoSuit
      and Fk:getCardById(to_select).number>0
    --   and 
    --   table.every(selected, function (id)
    --   return Fk:getCardById(to_select):compareNumberWith(Fk:getCardById(id), true)
    -- end)
  end,
  -- target_filter = function(self, player, to_select, selected, selected_cards)
  --     return #selected == 0 and to_select~=player
  -- end,
  on_use = function(self, room, effect)
    local cards=effect.cards
    local player=effect.from
    player:showCards(cards)
    if player.dead then return end
    -- local number = 0
    -- for _, id in ipairs(cards) do
    --   number = number Fk:getCardById(id).number
    -- end
    -- number = number % 13
    -- number = number == 0 and 13 or number
    local n = Fk:getCardById(cards[1]).number
    local m = Fk:getCardById(cards[2]).number
    local p =""
    if n>m then p = tostring(m).."~"..tostring(n) else p = tostring(n).."~"..tostring(m) end
    local cards = room:getCardsFromPileByRule(".|" ..p, 3,  "allPiles")
    if #cards > 0 then
      cards = room:askToChooseCards( player, {
        target = player,
        min = 1,
        max = 1,
        -- flag = "he",
        flag = { card_data = {{ tszjevqloeoj.name, cards }} },  --可見
        skill_name = tszjevqloeoj.name,
        prompt = "#tszjevqloeoj-discard",
      })
      room:obtainCard(player, cards, true, fk.ReasonJustMove, player, tszjevqloeoj.name)
    end
  end,
})
return tszjevqloeoj

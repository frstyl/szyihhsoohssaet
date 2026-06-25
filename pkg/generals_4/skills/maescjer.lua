
local maescjer = fk.CreateSkill{
  name = "maescjer",
}

Fk:loadTranslationTable{
  ["maescjer"] = "賣藝",
  [":maescjer"] = "主旹,弃3有花且各異花牌或2裝僃牌發動.伱令其它角色各抽1,肰後其各可交与伱至少1牌令伱抽2,伱自交予伱牌數至多者選1令其本轉後執行1額外轉",

  ["#maescjer-active"] = "賣藝  弃牌",
  ["#maescjer-give"] = "賣藝  是否交予 %src 牌",
  ["#maescjer-active"] = "賣藝  選擇1角色執行額外轉",
}


maescjer:addEffect("active", {
  anim_type = "offensive",
  prompt = "#maescjer-active",
  -- min_target_num = 1,
  -- max_target_num = 3,
  min_card_num = 2,
  max_card_num = 3,
  max_phase_use_time = 1,
  -- interaction = function(self, player)
  --   return UI.ComboBox {
  --     choices = {"damage","discard"},
  --   }
  -- end,
  card_filter = function(self, player, to_select, selected)
    if player:prohibitDiscard(to_select) then return end
    if #selected <1 then 
      local c=Fk:getCardById(to_select)
      return c.type==Card.TypeEquip 
      or c.suit~=Card.NoSuit
    end
    -- if #selected >=3 then return false end
    if #selected ==2 then
      local c1= Fk:getCardById(selected[1])
      local c2= Fk:getCardById(selected[2])
      if c1.suit~=c2.suit  then
        local c3=Fk:getCardById(to_select)
        return c3.suit~=Card.NoSuit and c1.suit~=c3.suit and c2.suit~=c3.suit
      end
    end

    if #selected ==1 then
      local c1= Fk:getCardById(selected[1])
      local c2= Fk:getCardById(to_select)
      return c1.type==Card.TypeEquip and c2.type==Card.TypeEquip
      or (c2.suit~=Card.NoSuit and c1.suit~=c2.suit)
    end
  end,
  -- target_filter = function(self, player, to_select, selected, selected_cards)
  --     return #selected <2 
  -- end,
  on_use = function(self, room, effect)
    local player = effect.from
    room:throwCard(effect.cards, maescjer.name, player, player)

    local targets = room:getOtherPlayers(player)
    for _,p in ipairs(targets) do
      p:drawCards(1,maescjer.name)
    end
    if player.dead then return end

    local tos={}
    local n=0
    for _, p in ipairs(targets) do
      if not p.dead then
        local card = room:askToCards(p, {
          min_num = 1,
          max_num = 999,
          include_equip = true,
          skill_name = maescjer.name,
          cancelable = true,
          prompt = "#maescjer-give:"..player.id,
        })
        if #card > 0 then
          if #card==n then
            n=#card
            table.insert(tos,p)
          elseif #card>n then
            n=#card
            tos={p}
          end
          room:moveCardTo(card, Card.PlayerHand, player, fk.ReasonGive, maescjer.name, nil, false, p)
          if player.dead then return end
          player:drawCards(2,maescjer.name)
        end
        if player.dead then return end
      end
    end
    if #tos==0 then return end
    if #tos>1 then
    tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = tos,
      skill_name = maescjer.name,
      prompt = "#maescjer-choose",
      cancelable = false,
    })
    end
    tos[1]:gainAnExtraTurn(true, maescjer.name)
  end,
})
return maescjer

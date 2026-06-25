local jiakmaah = fk.CreateSkill{
  name = "jiakmaah",
}

Fk:loadTranslationTable{
  ["jiakmaah"] = "躍馬",
  [":jiakmaah"] = "當伱可使用打出{殺/閃}旹,伱可預將伱1坐騎牌自伱{手牌區/裝僃區}迻至{裝僃區/手牌區},于元旹機虛擬執行,發動",

  ["@jiakmaah_cards"] = "演武",
  -- ["$jiakmaah1"] = "",

}

jiakmaah:addEffect("viewas", {
  pattern = "ssaet,szjemh|0|nosuit|none",
  anim_type = "defensive",
  prompt = "jiakmaah",
  card_filter = Util.FalseFunc,
  handly_pile = false,
  include_equip=true,
  interaction = function(self, player)
    local all_names = {"ssaet", "szjemh"}
    local names = player:getViewAsCardNames(jiakmaah.name, all_names)
    if #names == 0 then return end
    return UI.CardNameBox {choices = names, all_choices = all_names }
  end,
  card_filter = function(self, player, to_select, selected)
    if not self.interaction.data then return nil end
    if #selected ~= 0  then return nil end
    return table.contains({Card.SubtypeDefensiveRide, Card.SubtypeOffensiveRide}, Fk:getCardById(to_select).sub_type)
    and (
      (self.interaction.data == "ssaet"
        and table.contains(player:getCardIds("h"), to_select)
        -- and player:canMoveCardInBoardTo(player, to_select)--未有禁迻動-- 
        and player:hasEmptyEquipSlot(Fk:getCardById(to_select).sub_type)
      )
      or 
      (
        self.interaction.data == "szjemh" 
        and table.contains(player:getCardIds("e"), to_select)
    )
  )
  end,
  view_as = function(self, player, cards)
    if not self.interaction.data or #cards==0 then return nil end
    local card = Fk:cloneCard(self.interaction.data)
    card:addFakeSubcard(cards[1])
    card.skillName = jiakmaah.name
    return card
  end,
  before_use = function(self, player, use)
    local cid=use.card.fake_subcards[1]
    if not table.contains(player:getCardIds("he"), cid) then return end  --過檢測後不能執行不打斷用牌
    if use.card.trueName=="ssaet" and   table.contains(player:getCardIds("h"), cid)
    --  and player:canMoveCardInBoardTo(player, cid)
            and player:hasEmptyEquipSlot(Fk:getCardById(cid).sub_type)
    then
      player.room:moveCardTo({cid}, Card.PlayerEquip, player, fk.ReasonJustMove, jiakmaah.name, nil, true, player)  --置入?
      return
    end
    if use.card.trueName=="szjemh" and   table.contains(player:getCardIds("e"), cid) then
      player.room:moveCardTo({cid}, Card.PlayerHand, player, fk.ReasonJustMove, jiakmaah.name, nil, true, player)  --置入?
      return
    end
    
  end,
})



return jiakmaah

local szyihloav = fk.CreateSkill {
  name = "szyihloav",
}
Fk:loadTranslationTable{
  ["szyihloav"] = "水牢",
  [":szyihloav"] = "主動任意次.選擇1裝僃牌与1其它角色發動.將此裝僃牌轉化爲掎挈伺詐(離開伏區失效)置于目幖角色伏區",

  ["#szyihloav"] = "水牢：選擇裝僃牌与裝僃牌与目幖",
  ["@@szyihloav-inarea"] = "水牢",

  ["$szyihloav1"] = "浸伱个三天三夜",
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- szyihloav:addEffect("viewas", {
--   anim_type = "control",
--   pattern = "khxes_kheet_sis_tssaas",
--   prompt = "#szyihloav",
--   handly_pile = true,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and Fk:getCardById(to_select).type==Card.TypeEquip
--   end,
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     local c = Fk:cloneCard("khxes_kheet_sis_tssaas")  --usecard addVirtual
--     c.skillName = szyihloav.name
--     c:addSubcard(cards[1])
--     return c
--   end,
--   enabled_at_response = function (self, player, response)
--     return not response
--   end,
-- })

-- szyihloav:addEffect("viewas", {
--   anim_type = "control",
--   pattern = "khxes_kheet_sis_tssaas",
--   prompt = "#szyihloav",
--   handly_pile = true,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and Fk:getCardById(to_select).type==Card.TypeEquip
--   end,
--   view_as = function(self, player, cards)
--     if #cards ~= 1 then return end
--     local card =Fk:getCardById(cards[1])
--     card:setMark("@@szyihloav",1)  --摸過就上幖記
--     return card
--   end,
--   enabled_at_response = function (self, player, response)
--     return not response
--   end,
-- })

szyihloav:addEffect("active", {  --viewas 加彊req response
  mute = true,
  prompt = "#szyihloav",
  card_num = 1,
  target_num = 1,
  handly_pile = true,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and Fk:getCardById(to_select).type == Card.TypeEquip
  end,
  target_filter = function(self, player, to_select, selected)
    return to_select~=player
  end,
  -- feasible = function (self, player, selected, selected_cards)
  --   if #selected_cards == 1 then
  --     if #selected == 0 then
  --       return table.contains(player:getCardIds("h"), selected_cards[1])
  --     else
  --       local card = Fk:cloneCard("iron_chain")
  --       card:addSubcard(selected_cards[1])
  --       card.skillName = szyihloav.name
  --       return card.skill:feasible(player, selected, {}, card)
  --     end
  --   end
  -- end,
  on_use = function(self, room, effect)
    local player =effect.from
    -- local card=Fk:getCardById(effect.cards[1])
  -- room:setCardMark(card,"@@szyihloav-inarea",{Card.PlayerJudge})
  -- player:filterHandcards()
  -- room:moveCardTo(card, Player.Judge, effect.tos[1], fk.ReasonPut, szyihloav.name, nil, false)

          local card = Fk:cloneCard("khxes_kheet_sis_tssaas")
          card:addSubcard(effect.cards[1])
          effect.tos[1]:addVirtualEquip(card)
          room:moveCardTo(card, Player.Judge, effect.tos[1], fk.ReasonPut, szyihloav.name,nil,false,player)  --无视合法性检测
  end,
})

-- szyihloav:addEffect("filter", {
--   card_filter = function(self, card, player)
--     -- return #card:getTableMark("@@szyihloav-inarea")>0
--     return #card:getTableMark("@@szyihloav-inarea")>0
--   end,
--   view_as = function(self, player, card)
--     local card = Fk:cloneCard("khxes_kheet_sis_tssaas", card.suit, card.number)
--     card.skillName = szyihloav.name
--     return card
--   end,
-- })

return szyihloav

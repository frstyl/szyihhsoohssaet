Fk:loadTranslationTable{
  ["pracqkij"] = "兵僃",
  [":pracqkij"] = "輪始旹,伱可發動.伱抽4,連續4次:選擇手牌中1{裝備/延旹}牌置入1脚色{對應裝備欄/伏區},或1主動卽旹牌葢伏于1脚色伏區",

  ["#pracqkij-give"] = "兵僃：将至多%arg张手牌分配给其它脚色",


}

local pracqkij = fk.CreateSkill{
  name = "pracqkij",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
    on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(4, pracqkij.name)

    for i=1,4,1 do
      if player.dead or player:isKongcheng() or #room:getOtherPlayers(player, false) == 0 then return end
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        min_num = 1,
        max_num = 1,
        targets = room.alive_players,
        skill_name = pracqkij.name,
        prompt = "#pracqkij-choose",
        cancelable = true,
        include_equip=false,
        pattern = tostring(Exppattern{ id = table.filter(player:getCardIds("h"), function (id)
        return not Fk:getCardById(id).is_passive
      end)}),
      })
      if #tos > 0 and #cards > 0 then
        local to = tos[1]
        local n =S.getCardUsageType(cards[1])
        if n==3 then
          room:moveCardIntoEquip(to, cards[1], pracqkij.name, true, player)
        elseif n==2 then
          room:moveCardTo(cards, Card.PlayerJudge, to, fk.ReasonPut, pracqkij.name, nil, true, player)
        else
          S.koarbiuk(to,cards[1], pracqkij.name, player)
          -- player.room:moveCardTo(cards, Player.Hand, to, fk.ReasonPut, pracqkij.name, nil, false, player)
        end
      end
    end
    -- room:askToyiji(player, {
    --   cards = player:getCardIds("h"),
    --   targets = room:getOtherPlayers(player, false),
    --   skill_name = pracqkij.name,
    --   min_num = 0,
    --   max_num = 2,
    -- })
  end
}
-- pracqkij:addEffect(fk.Damaged, {
--   anim_type = "masochism",
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:hasSkill(pracqkij.name)
--   end,
--   trigger_times = function(self, event, target, player, data)
--     return data.damage
--   end,
--   on_use=spec.on_use,
-- })

pracqkij:addEffect(fk.RoundStart, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(pracqkij.name)
  end,
  on_use=spec.on_use,
})
return pracqkij

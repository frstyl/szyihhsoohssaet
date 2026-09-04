Fk:loadTranslationTable{
  ["pracqbxis"] = "兵僃",
  [":pracqbxis"] = "輪始旹,伱可發動.伱抽4,連續4次:選擇手牌中1{裝備/延旹}牌置入1脚色{對應裝備欄/伏區},或1主動卽旹牌葢伏于1脚色伏區",

  ["#pracqbxis-give"] = "兵僃：将至多%arg张手牌分配给其它脚色",

  ["$pracqbxis1"] = "锦囊妙策，终定社稷。",
  ["$pracqbxis2"] = "依此计行，辽东可定。",
}

local pracqbxis = fk.CreateSkill{
  name = "pracqbxis",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

local spec={
    on_use = function(self, event, target, player, data)
    local room = player.room
    player:drawCards(4, pracqbxis.name)

    for i=1,4,1 do
      if player.dead or player:isKongcheng() or #room:getOtherPlayers(player, false) == 0 then return end
      local tos, cards = room:askToChooseCardsAndPlayers(player, {
        min_card_num = 1,
        max_card_num = 1,
        min_num = 1,
        max_num = 1,
        targets = room.alive_players,
        skill_name = pracqbxis.name,
        prompt = "#pracqbxis-choose",
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
          room:moveCardIntoEquip(to, cards[1], pracqbxis.name, true, player)
        elseif n==2 then
          room:moveCardTo(cards, Card.PlayerJudge, to, fk.ReasonPut, pracqbxis.name, nil, true, player)
        else
          S.koarbiuk(to,cards[1], pracqbxis.name, player)
          -- player.room:moveCardTo(cards, Player.Hand, to, fk.ReasonPut, pracqbxis.name, nil, false, player)
        end
      end
    end
    -- room:askToyiji(player, {
    --   cards = player:getCardIds("h"),
    --   targets = room:getOtherPlayers(player, false),
    --   skill_name = pracqbxis.name,
    --   min_num = 0,
    --   max_num = 2,
    -- })
  end
}
-- pracqbxis:addEffect(fk.Damaged, {
--   anim_type = "masochism",
--   can_trigger = function(self, event, target, player, data)
--     return target==player and player:hasSkill(pracqbxis.name)
--   end,
--   trigger_times = function(self, event, target, player, data)
--     return data.damage
--   end,
--   on_use=spec.on_use,
-- })

pracqbxis:addEffect(fk.RoundStart, {
  anim_type = "masochism",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(pracqbxis.name)
  end,
  on_use=spec.on_use,
})
return pracqbxis

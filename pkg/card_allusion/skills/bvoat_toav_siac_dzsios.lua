
local cardSkill = fk.CreateSkill{
  name = "bvoat_toav_siac_dzsios",
}

Fk:loadTranslationTable{
  ["#bvoat_toav_siac_dzsios"] = "拔刀相助 打出此牌与1其它角色伏區1延旹牌",
  ["#bvoat_toav_siac_dzsios-choose"] = "拔刀相助 選擇目幖",
  ["#bvoat_toav_siac_dzsios"] = "拔刀相助 打出牌",
}

local S = require "packages/szyihhsoohssaet/szyih_guos"


cardSkill:addEffect("active", {  --歬轉終
  prompt = "#bvoat_toav_siac_dzsios",
  target_num = 1,
  target_filter = function(self, player, to_select, selected)
    return 
     not player:prohibitResponse(Fk:getCardById(selected_cards[1]))
    and
     p~=player 
    and
       table.find(to_select:getCardIds("j"), function(cid)
          return(not to_select:getVirualEquip(cid) or to_select:getVirualEquip(cid).name~="koarbiuk_card") and Fk:getCardById(cid).name~="koarbiuk_card"
          end)
      

  end,
  on_use = function(self, room, effect)
    -- if effect.extra_data and effect.extra_data.bvoat_toav_siac_dzsios then
    local player=effect.from
    local to= effect.tos[1]
    -- room:throwCard(effect.cards, cardSkill.name, player, player)
    S.playCard(player,effect.cards,cardSkill.name)
     local cards = room:askToChooseCards( player, {
        target = to,
        min = 1,
        max = 1,
        -- flag = "he",
        flag = { card_data = {{to.general, table.filter(to:getCardIds("j"), function(cid)
    return not to:getVirualEquip(cid) or to:getVirualEquip(cid).name~="koarbiuk_card" and Fk:getCardById(cid).name~="koarbiuk_card"
    end)}} },  --可見
        skill_name = cardSkill.name,
        prompt = "#bvoat_toav_siac_dzsios-discard",
      })
      room:throwCard(cards, cardSkill.name, to, player)

    -- end
  end,


})


return cardSkill

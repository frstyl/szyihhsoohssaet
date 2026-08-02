local cardSkill = fk.CreateSkill {
  name = "dzzi_tshjen_doavs_kaap_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#li_mxev_kiuh_pxens", --
  target_num=1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select~=player and to_select:getEquipment(Card.SubtypeArmor)
  end,
  target_filter = Util.CardTargetFilter,
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local cards = effect.to:getEquipments(Card.SubtypeArmor)
    if #cards >1 then
      cards = room:askToChooseCards(effect.from, {
      target = effect.to,
      min = 1,
      max = 1,
      flag = { card_data = {{ "Bottom", cards }} },
      skill_name = "li_mxev_kiuh_pxens",
      prompt = "#li_mxev_kiuh_pxens-choose",
    })
    end
    if #cards==1 then
      room:obtainCard(effect.from, cards, false, fk.ReasonPrey, effect.from, "li_mxev_kiuh_pxens")
    end
  end,
})

cardSkill:addEffect(fk.CardUseFinished, {
  -- global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    if  target~=player 
      or data.card.trueName~="hqjin_deek_qwe_tsji"
    then return end

      local tos = table.filter(player.room.alive_players,
          function(p)
          return 
            p:getEquipment(Card.SubtypeArmor)
        end)
      local players=S.getHolders("dzzi_tshjen_doavs_kaap")
      if #tos>0 and #players>0 then
        event:setCostData(self,{players=players,tos=tos})
        return true 
      end

  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

      local params={
      skill_name = "li_mxev_kiuh_pxens",
      pattern="dzzi_tshjen_doavs_kaap",
      cancelable=true,
      prompt="#li_mxev_kiuh_pxens",
      skip=true,
      extra_data = {
        -- must_targets = {data.from.id},
        -- exclusive_targets = table.map(event:getCostData(self).tos, Util.IdMapper),
        li_mxev_kiuh_pxens = true,
      }
    }
      local use = room:askToNullification(event:getCostData(self).players, params) 
      if use then
        use.extra_data = use.extra_data or {}
        use.extra_data.li_mxev_kiuh_pxens = true   
        room:useCard(use)
      end

  end,
})

return cardSkill

local cardSkill = fk.CreateSkill {
  name = "ttxes_tshuoh_ssaac_dzzjin_koac_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#tshjit_seec_dzuoh_cxes", --
  target_num=1,
  mod_target_filter = function(self, player, to_select, selected, card)
    return to_select:hasDelayedTrick("ssaac_dzzjin_koac")
  end,
  target_filter = Util.CardTargetFilter,
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local cards = table.filter(effect.to:getCardIds("j"),
        function(id)
          return Fk:getCardById(id).trueName == "ssaac_dzzjin_koac" or  effect.to:getVirualEquip(id).trueName == "ssaac_dzzjin_koac"
        end)
    if #cards >1 then
      cards = room:askToChooseCards(effect.from, {
      target = effect.to,
      min = 1,
      max = 1,
      flag = { card_data = {{ "Bottom", cards }} },
      skill_name = "tshjit_seec_dzuoh_cxes",
      prompt = "#tshjit_seec_dzuoh_cxes-choose",
    })
    end
    if #cards==1 then
      room:moveCardTo(id,Card.DiscardPile,nil,fk.ReasonPutIntoDiscardPile,"tshjit_seec_dzuoh_cxes",nil,true,effect.from)
      effect.from:drawCards(5,"ssaac_dzzjin_koac")
    end
  end,
})

cardSkill:addEffect(fk.CardUseFinished, {
  -- global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    if  target~=player 
      or data.card.trueName~="meej"
    then return end

      local tos = table.filter(player.room.alive_players,
          function(p)
          return 
            p:hasDelayedTrick("ssaac_dzzjin_koac")
        end)
      local players=S.getHolders("ttxes_tshuoh_ssaac_dzzjin_koac")
      if #tos>0 and #players>0 then
        event:setCostData(self,{players=players,tos=tos})
        return true 
      end

  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

      local params={
      skill_name = "tshjit_seec_dzuoh_cxes",
      pattern="ttxes_tshuoh_ssaac_dzzjin_koac",
      cancelable=true,
      prompt="#tshjit_seec_dzuoh_cxes",
      skip=true,
      extra_data = {
        -- must_targets = {data.from.id},
        -- exclusive_targets = table.map(event:getCostData(self).tos, Util.IdMapper),
        tshjit_seec_dzuoh_cxes = true,
      }
    }
      local use = room:askToNullification(event:getCostData(self).players, params) 
      if use then
        use.extra_data = use.extra_data or {}
        use.extra_data.tshjit_seec_dzuoh_cxes = true   
        room:useCard(use)
      end

  end,
})

cardSkill:addEffect(fk.Damaged, {
  global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    if  target==player 
    and data.from 
    and data.from~=data.to
    and not data.from.dead
    then
      return #table.filter(player:getCardIds("h"),
        function(id)
          local card = Fk:getCardById(id)
          return card.name == "ttxes_tshuoh_ssaac_dzzjin_koac" and not player:prohibitResponse(card)
        end)>0
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    local n =math.max(1,math.abs(player.hp-data.from.hp))
    -- n=1
    -- local cards = room:askToDiscard(player, { 
    --   min_num = 1,
    --   max_num = 1,
    --   include_equip = false,
    --   pattern="ttxes_tshuoh_ssaac_dzzjin_koac",
    --   skill_name = "giac_tshuoh_hzoav_dvoat",
    --   prompt = "#giac_tshuoh_hzoav_dvoat-invoke:"..data.from.id..":::"..n,
    --   cancelable = true,
    --   skip = true,
    -- })
    local params = {
			min_num=1,
			max_num=1,
			include_equip=false,
			pattern="ttxes_tshuoh_ssaac_dzzjin_koac",
      prompt = "#giac_tshuoh_hzoav_dvoat-invoke:"..data.from.id..":::"..n,
			cancelable = true,
      skill_name = "giac_tshuoh_hzoav_dvoat",
      skip = true,
		}
    local  cards = S.askToPlayCard(player, params)
    if #cards>0 then
        -- room:throwCard(cards,"giac_tshuoh_hzoav_dvoat",player,player)
        S.playCard(player,cards,"giac_tshuoh_hzoav_dvoat")
        local ids = room:askToChooseCards(player, {
            target = data.from,
            min = n,
            max = n,
            flag = "he",
            skill_name = "giac_tshuoh_hzoav_dvoat",
          })
        room:obtainCard(player, ids, false, fk.ReasonPrey, player, "giac_tshuoh_hzoav_dvoat")
      end

  end,
})
return cardSkill

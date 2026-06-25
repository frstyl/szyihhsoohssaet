local cardSkill = fk.CreateSkill {
  name = "hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac_skill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#leen_hsiac_sjek_ciok",
  target_num=1,
  mod_target_filter = Util.TrueFunc,
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    local cards = room:askToDiscard(effect.to, {
      min_num = 2,
      max_num = 2,
      include_equip = false,
      skill_name = "leen_hsiac_sjek_ciok",
      prompt = "#leen_hsiac_sjek_ciok-discard",--leen_hsiac_sjek_ciok
      cancelable = false,
      skip = false,
    })
  end,
})

cardSkill:addEffect(fk.DamageCaused, {
  -- global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    if  target==player 
      and data.to
      and  target:compareGenderWith(data.to, true) 
    then
      local players = S.getHolders("hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac")
       if #players> 0  then
        event:setCostData(self,{players=players})
        return  true
      end
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

      local params={
      skill_name = "leen_hsiac_sjek_ciok",
      pattern="hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac",
      cancelable=true,
      prompt="#leen_hsiac_sjek_ciok:"..data.from.id,
      skip=true,
      extra_data = {
        fix_targets={data.from.id},
        leen_hsiac_sjek_ciok = true,
      }
    }
      local use = room:askToNullification(event:getCostData(self).players, params) 
      if use then
        use.extra_data=use.extra_data or{}
        use.extra_data.fix_targets={player.id}
        room:useCard(use)
      end

  end,
})

cardSkill:addEffect(fk.Damage, {
  global = true,
  mute = true,
  priority = 0,  --同旹自選 用牌?
  can_trigger = function(self, event, target, player, data)
    if  target==player 
    and data.to 
    then
      return #table.filter(player:getCardIds("h"),
        function(id)
          local card = Fk:getCardById(id)
          return card.name == "hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac" and not player:prohibitResponse(card)
        end)>0
    end
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room

    local params = {
      min_num = 1,
      max_num = 1,
      -- include_equip = true,
      cancelable = true,
      pattern="hsfa_hzova_ddiacs_thoucs_toah_sjevh_paas_quac",
      skill_name = "hqjit_tshoak_tsoeojs_tshoak",
      prompt = target:compareGenderWith(data.to) and "#hqjit_tshoak_tsoeojs_tshoak-same:"..data.to.id or "#hqjit_tshoak_tsoeojs_tshoak-n:::"..data.damage,
      skip=true,
    }
    local  cards = S.askToPlayCard(player, params)

      if #cards>0 then
        S.playCard(player,cards,"hqjit_tshoak_tsoeojs_tshoak")
        if  target:compareGenderWith(data.to)  then
          local cid = room:askToChooseCard(player, { target = data.to, flag = "he", skill_name = "hqjit_tshoak_tsoeojs_tshoak" })
          room:throwCard({cid},  "hqjit_tshoak_tsoeojs_tshoak" , data.to, player)
        else
          player:drawCards(data.damage,"hqjit_tshoak_tsoeojs_tshoak")
        end
      end

  end,
})
return cardSkill

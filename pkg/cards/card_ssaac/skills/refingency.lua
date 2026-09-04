local refingency = fk.CreateSkill{
  name = "refingency_skill",
}

Fk:loadTranslationTable{
  ["refingency"] = "轉景",
  [":refingency"] = "應動轉移",
  ["refingency_skill"] = "轉景",
  [":refingency_skill"] = "轉移牌目幖",

  ["#refingency-use"] = "轉景 轉移 %arg ",

}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

refingency:addEffect("cardskill", {
  prompt="#khfar_hzvoat_ljim",
  -- prompt = function(self, _, _, _, extra_data)
  --   return extra_data.khfar_hzvoat_ljim and "#khfar_hzvoat_ljim"  
  -- or "#muo_tsiuh_piu_hsvoan"  --extra?
  -- end,
  mod_target_filter = function(self, player, to_select, selected, card, extra_data)
    return to_select ~= player
  end, 
  target_num=1,  --多目幖?
  target_filter = Util.CardTargetFilter,
  can_use =Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if not effect.extra_data and effect.extra_data.refingency then return end
    local data= effect.extra_data.refingency
    if data:cancelCurrentTarget() then
      data:addTarget(effect.to)
    end
  end,
})

refingency:addEffect(fk.TargetConfirming, {
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    return data.to == player 
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local params={
      skill_name = "refingency_skill",
      pattern = "refingency",
      prompt = "#refingency-use:::"..data.card:toLogString(),
      cancelable = true,
      skip=true,
        extra_data = {  --不計次?
          -- refingency = data,
        }
    }
    local use = S.askToUseKoarbiukCard(data.to, params, nil, nil, #S.getHolders("refingency",{data.from})==0, true)
    if use then
      use.extra_data=use.extra_data or{}
      use.extra_data.refingency=data
      room:useCard(use)
    end
  end,

})

return refingency

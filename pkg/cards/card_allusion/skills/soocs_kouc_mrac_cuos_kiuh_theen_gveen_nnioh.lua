local cardSkill = fk.CreateSkill {
  name = "soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh_skill",
}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  can_use = Util.FalseFunc,
  offset_func= Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.responseToEvent then
      effect.responseToEvent:preventDamage()
    end
  end,
})

cardSkill:addEffect(fk.DamageInflicted, {
  -- global = true,
  -- mute = true,
  priority = 0,  --同旹自選 用牌?/
  can_trigger = function(self, event, target, player, data)
    return  data.to==player 
    and      
    #S.getHolders("soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh",data.to)>0  --單體露信
  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
      local params={
      skill_name = "zzjin_dzzius_theen_szio",
      pattern="soocs_kouc_mrac_cuos_kiuh_theen_gveen_nnioh",
      cancelable=true,
      prompt="#zzjin_dzzius_theen_szio",
      skip=true,
      extra_data = {
        zzjin_dzzius_theen_szio = true,
      }
    }
      local use = room:askToUseCard(player, params)
      if use then
        use.toCard = use.card  --无目幖
        use.responseToEvent = data
        room:useCard(use)
      end

  end,
})

return cardSkill

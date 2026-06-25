local cardSkill = fk.CreateSkill {
  name = "zjim_jiac_lou_deej_puad_szi_skill",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

cardSkill:addEffect("cardskill", {
  prompt="#sjevs_hzvoac_dzaav",
  -- prompt = function(self, _, _, _, extra_data)
  --   return extra_data.sjevs_hzvoac_dzaav and "#sjevs_hzvoac_dzaav"  
  -- or "#muo_tsiuh_piu_hsvoan"  --extra?
  -- end,
  mod_target_filter = Util.TrueFunc,
  fix_targets=function(self,player,card,extra_data) --on_use?
    return {player}
  end,
  on_use = function(self, room, effect)
    effect.to=effect.from
  end,
  can_use =Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end
    effect.to:drawCards(S.getRebelNumber(room), cardSkill.name)
  end,
})


cardSkill:addEffect(fk.CardEffectFinished, {
  -- priorit=1,
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    return target == player
    and data.card
    and data.card.trueName=="analeptic"
    and #S.getHolders("zjim_jiac_lou_deej_puad_szi",{data.to})>0
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room

    local use = room:askToUseCard(player, {
      skill_name = "sjevs_hzvoac_dzaav",
      pattern = "zjim_jiac_lou_deej_puad_szi",
      prompt = "#sjevs_hzvoac_dzaav:"..tostring(S.getRebelNumber(room)),
      cancelable = true,
      skip=true,
        extra_data = {  --不計次?
          sjevs_hzvoac_dzaav = true,
          fix_targets={player.id}
        }
    })
    if use then
      use.extra_data=use.extra_data or{}
      use.extra_data.fix_targets={player.id}
      room:useCard(use)
    end
  end,
})


return cardSkill



local cardSkill = fk.CreateSkill {
  name = "zjim_jiac_lou_deej_puad_szi_skill",
}


local S = require "packages/szyihhsoohssaet/szyih_guos" 

local getRebelNumber=function(room)
  local n =0

  for _, p in ipairs(room.alive_players) do
    if p.role=="Rebel" then n =n+1 end
  end
  return math.max(1,n)
end

cardSkill:addEffect("cardskill", {
  prompt="#sjevs_hzvoac_dzaav",
  -- prompt = function(self, _, _, _, extra_data)
  --   return extra_data.sjevs_hzvoac_dzaav and "#sjevs_hzvoac_dzaav"  
  -- or "#muo_tsiuh_piu_hsvoan"  --extra?
  -- end,
  mod_target_filter = Util.TrueFunc,
  target_num=1,
  -- on_use = function(self, room, effect)
  --   effect.to=effect.from
  -- end,
  can_use =Util.FalseFunc,
  on_effect = function(self, room, effect)
    if effect.to.dead then return end

    effect.to:drawCards(getRebelNumber(room), cardSkill.name)
  end,
})


cardSkill:addEffect(fk.CardUseFinished, {
  -- priorit=1,
  -- global = true,
  can_trigger = function(self, event, target, player, data)
    return data.from == player
    and table.contains(data.tos,player)  --起動无效
    and data.card
    and data.card.trueName=="tsiuh"
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room

    local params={
      skill_name = "sjevs_hzvoac_dzaav",
      pattern = "zjim_jiac_lou_deej_puad_szi",
      prompt = "#sjevs_hzvoac_dzaav:"..tostring(getRebelNumber(room)),
      cancelable = true,
      skip=true,
        extra_data = {  --不計次?
          sjevs_hzvoac_dzaav = true,
          -- fix_targets={player.id}
        }
    }
    while true do
      local use = S.askToUseKoarbiukCard(data.from, params, nil, nil, #S.getHolders("zjim_jiac_lou_deej_puad_szi",{data.from})==0, true) 

      if use then
        use.extra_data=use.extra_data or{}
        use.extra_data.fix_targets={player.id}
        room:useCard(use)
      else
        return 
      end
    end
  end,
})


return cardSkill



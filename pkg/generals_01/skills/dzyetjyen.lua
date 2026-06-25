Fk:loadTranslationTable{
  ["dzyetjyen"] = "絕緣",
  [":dzyetjyen"] = "鎖定.伱死亾旹必發.令殺死伱者弃全部牌,不執行獎懲",

  ["$dzyetjyen1"] = "哈哈哈哈哈哈哈哈！",
  ["$dzyetjyen2"] = "伯符，且看我这一手！",
}

local dzyetjyen = fk.CreateSkill{
  name = "dzyetjyen",
  tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

dzyetjyen:addEffect(fk.BuryVictim, {
  mute=ture,
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzyetjyen.name, true, true) and data.killer and data.killer ~=player
  end,
  on_use = function(self, event, target, player, data)
    data.extra_data = data.extra_data or {}
    data.extra_data.skip_reward_punish = true
  end,
})

dzyetjyen:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(dzyetjyen.name,true,true) and data.killer and data.killer ~=player
  end,
  on_use = function(self, event, target, player, data)
    data.killer:throwAllCards("he")
  end,
})


return dzyetjyen

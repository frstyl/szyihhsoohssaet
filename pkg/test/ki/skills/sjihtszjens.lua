local sjihtszjens = fk.CreateSkill {
  name = "sjihtszjens",
}

Fk:loadTranslationTable{
  ["sjihtszjens"] = "死戰",
  [":sjihtszjens"] = "一腳色瀕死結算後,若其體力值小于1,伱可發動,其不執行死亾",

  ["#sjihtszjens-invoke"] = "死戰 ",

}


local S = require "packages/szyihhsoohssaet/szyih_guos" 


sjihtszjens:addEffect(fk.AskForPeachesDone, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return  player:hasSkill(sjihtszjens.name) and target.hp < 1
  end,

  on_use = function(self, event, target, player, data)
    data.ignoreDeath=true
  end,
})


return sjihtszjens

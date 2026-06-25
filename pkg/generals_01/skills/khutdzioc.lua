Fk:loadTranslationTable{
  ["khutdzioc"] = "屈從",
  [":khutdzioc"] = "伱主段始旹,若伱未有黴運,伱可發動.伱爲附加黴運",


  ["#khutdzioc-invoke"] = "屈從",

  ["$khutdzioc1"] = "出門睬狗屎 放屁砸後跟",
  ["$khutdzioc2"] = "遇到伱 算我倒楣",
}

local khutdzioc = fk.CreateSkill{
  name = "khutdzioc",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

khutdzioc:addEffect(fk.EventPhaseStart, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
  return player==target and player:hasSkill(khutdzioc.name) and data.phase==Player.Play and not S.hasTsziukzzyit(player,"mxiqquns")
  end,
  on_cost = function(self, event, target, player, data)
      return player.room:askToSkillInvoke(player, { skill_name = khutdzioc.name ,prompt="#khutdzioc-invoke",}) 
  end,
  on_use = function(self, event, target, player, data)
    S.addTsziukzzyitBuff(player,  "mxiqquns",player)
    player.room.logic:breakTurn()
  end,
})


return khutdzioc

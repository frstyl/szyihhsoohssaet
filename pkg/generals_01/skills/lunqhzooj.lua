Fk:loadTranslationTable{
  ["lunqhzooj"] = "輪回",
  [":lunqhzooj"] = "鎖定.伱死亾旹必發.令殺死伱者體力上限-1,獲得技能輪回",

  ["$lunqhzooj1"] = "哈哈哈哈哈哈哈哈！",
  ["$lunqhzooj2"] = "伯符，且看我这一手！",
}

local lunqhzooj = fk.CreateSkill{
  name = "lunqhzooj",
  tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

lunqhzooj:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(lunqhzooj.name,true,true) and data.killer and data.killer ~=player
  end,
  on_use = function(self, event, target, player, data)
    player.room:changeMaxHp(data.killer,-1)
    player.room:handleAddLoseSkills(data.killer, lunqhzooj.name)
  end,
})


return lunqhzooj

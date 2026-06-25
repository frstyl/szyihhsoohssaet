Fk:loadTranslationTable{
  ["koushzaems"] = "構陷",
  [":koushzaems"] = "鎖定.伱死亾旹必發.令殺死伱者獲得技能入彀",

  ["$koushzaems1"] = "哈哈哈哈哈哈哈哈！",
  ["$koushzaems2"] = "伯符，且看我这一手！",
}

local koushzaems = fk.CreateSkill{
  name = "koushzaems",
  tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

koushzaems:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(koushzaems.name,true,true) and data.killer and data.killer ~=player
  end,
  on_use = function(self, event, target, player, data)
    player.room:handleAddLoseSkills(data.killer, "nzjipkous")
  end,
})


return koushzaems

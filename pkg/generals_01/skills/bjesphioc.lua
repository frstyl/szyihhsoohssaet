Fk:loadTranslationTable{
  ["bjesphioc"] = "避鋒",
  [":bjesphioc"] = "鎖定.伱死亾旹必發.全體有咒術{狂虣/命中}者流失1體力,抽2",



  ["$bjesphioc1"] = "哈哈哈哈哈哈哈哈！",
  ["$bjesphioc2"] = "伯符，且看我这一手！",
}

local bjesphioc = fk.CreateSkill{
  name = "bjesphioc",
  tags = { Skill.Compulsory,Skill.Permanent },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

bjesphioc:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(bjesphioc.name,false,true)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    for _, p in ipairs(room:getOtherPlayers(player)) do
      if not p.dead and (S.hasTsziukzzyit(p, "guacqboavs") or S.hasTsziukzzyit(p, "mracsttiucs")) then
        room:loseHp(p,1, bjesphioc.name)
        if not p.dead then
        p:drawCards(2,bjesphioc.name)
        end
      end
    end
  end,
})


return bjesphioc

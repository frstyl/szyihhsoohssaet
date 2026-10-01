Fk:loadTranslationTable{
  ["sziksmuj"] = "式微",
  [":sziksmuj"] = "伱死亾旹必發:女腳色或与伱同勢力腳色各回1",



  ["$sziksmuj1"] = "哈哈哈哈哈哈哈哈！",
  ["$sziksmuj2"] = "伯符，且看我这一手！",
}

local sziksmuj = fk.CreateSkill{
  name = "sziksmuj",
  tags = { Skill.Compulsory},
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

sziksmuj:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(sziksmuj.name,false,true)
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local kingdom=player.kingdom
    for _, p in ipairs(room:getOtherPlayers(player)) do
      if not p.dead and p:isWouned()  and (p.kingdom==kingdom or S.isFemale(p) )then 
        room:reCover({who=p,recoverBy=player,skillName=sziksmuj.name,num=1})
      end
    end


  end,
})


return sziksmuj

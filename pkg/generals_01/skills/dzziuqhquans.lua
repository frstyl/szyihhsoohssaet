local dzziuqhquans = fk.CreateSkill{
  name = "dzziuqhquans",
  -- tags = { Skill.Compulsory },
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["dzziuqhquans"] = "讎怨",
  [":dzziuqhquans"] = "伱死亾旹,伱可發動:伱爲全體存活角色附加咒術詛咒",

  ["#dzziuqhquans-invoke:"] = "咒謾 是否對 %src發動",

  ["$dzziuqhquans1"] = "我欲行夏禹旧事，为天下人。",

}

dzziuqhquans:addEffect(fk.AfterDying, {
  anim_type = "drawcard",
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(dzziuqhquans.name,true,true)
  end,
  on_use = function (self, event, target, player, data)
    for _,p in ipairs(player.room.alive_players) do
      S.addTsziukzzyitBuff(p,"tssiostsziuk",player)
    end
  end,
})



return dzziuqhquans

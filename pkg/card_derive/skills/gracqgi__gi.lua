local equipSKill = fk.CreateSkill{
  name = "#gracqgi__gi_skill",
  tags = { Skill.Compulsory },
  attached_equip = "gracqgi__gi",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSKill:addEffect("atkrange", {
  correct_func = function (self, from, to)
    if from and to then
      return #table.filter(Fk:currentRoom().alive_players, function(p)
        return S.isSameSquad(p,from) and p:hasSkill(equipSKill.name)
      end
      )
    end
  end,
})
--同一角色裝僃同名裝僃 止生效1?
Fk:loadTranslationTable{
  ["gracqgi__gi_skill"] = "杏黃旗",
  [":gracqgi__gi_skill"] = "鎖，与伱同陣營(隊列)角色攻程+1。",
}

equipSKill:addEffect("active", {
  prompt = "#role__wooden_ox",
  card_num = 1,
  card_filter = function(self, player, to_select, selected)
    return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
  end,
  target_num = 0,
  on_use = function(self, room, effect)
   effect.from:drawCards(2,equipSKill.name)
  end,
})
return equipSKill

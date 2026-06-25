Fk:loadTranslationTable{
  ["jiokhsoak"] = "欲壑",
  [":jiokhsoak"] = "伱死亾旹,伱可選1其它女角色非主公發動.令其卽死",

  ["$jiokhsoak1"] = "哈哈哈哈哈哈哈哈！",
  ["$jiokhsoak2"] = "伯符，且看我这一手！",
}

local jiokhsoak = fk.CreateSkill{
  name = "jiokhsoak",
  -- tags = { Skill.Compulsory,Skill.Permanent },
}

-- local S = require "packages/szyihhsoohssaet/szyih_guos" 

jiokhsoak:addEffect(fk.Death, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target==player and player:hasSkill(jiokhsoak.name,true,true)
  end,
  on_cost= function(self, event, target, player, data)
    local tos = player.room:askToChoosePlayers(player, {
      min_num = 1,
      max_num = 1,
      targets = table.filter(player.room.alive_players, function(p)
      return p.gender == General.Female and (p.role ~= "lord" )
      end),  --
      skill_name = jiokhsoak.name,
      prompt = "#jiokhsoak-choose",
      cancelable = true,
    })
    if #tos > 0 then
      event:setCostData(self, {tos = tos})
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    player.room:killPlayer{
      who = event:getCostData(self).tos[1],
      killer = player,
    }
  end,
})


return jiokhsoak

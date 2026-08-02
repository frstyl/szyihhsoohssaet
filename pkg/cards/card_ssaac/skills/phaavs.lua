local phaavs_skill = fk.CreateSkill {
  name = "#phaavs_skill",
  tags = { Skill.Compulsory },
  attached_equip="phaavs",
}

-- Fk:loadTranslationTable{
-- }

local S = require "packages/szyihhsoohssaet/szyih_guos" 



phaavs_skill:addEffect(fk.Damage, {
  -- globle=true,
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    return data.from == player and player:hasSkill(phaavs_skill.name)
    and data.card 
    and data.card.trueName=="ssaet"
    and table.contains({ fk.ThunderDamage ,fk.FireDamage },data.damageType) 
  end,
  on_trigger= function(self, event, target, player, data)
    local tos={}
    table.insert(tos,S.getNextOne(data.to,-1))
    table.insert(tos,S.getNextOne(data.to))  --上下家同人則兩次

    -- table.insertIfNeed(tos,S.getNextOne(data.to,-1))
    -- if tos[1]==data.to then return end

    for _,p in ipairs(tos) do
      if not p.dead then
        S.addTsziukzzyitBuff(p,"qunshzveen",player)
      end
    end
  end,
})
return phaavs_skill


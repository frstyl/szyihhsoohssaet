local ciosmaah = fk.CreateSkill {
  name = "ciosmaah",
  tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["ciosmaah"] = "御馬",
  [":ciosmaah"] = "鎖定.伱至其他角色距離-1.若伱至角色A距離等于1,伱視爲擁有其全部坐騎效果", --視爲有其它角色坐騎技能
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

ciosmaah:addEffect("distance", {
  correct_func = function(self, from, to)
    if from:hasSkill(ciosmaah.name) then
      return -1
    end
  end,
})


ciosmaah:addEffect("filter", {
  skill_filter = function (self, player)
    if table.contains(player:getSkillNameList(), ciosmaah.name) and
      Fk.skills[ciosmaah.name]:isEffectable(player) then
      local skills = {}
      for _, p in ipairs(Fk:currentRoom().alive_players) do
        if p~=player  then --player:compareDistance(p,1,"==")
          for _, card in ipairs(p:getEquipCards()) do
            if (card.sub_type == Card.SubtypeDefensiveRide or card.sub_type == Card.SubtypeOffensiveRide)
            and  card:getEquipSkills(p) 
            then
              table.insertTableIfNeed(skills, table.map(card:getEquipSkills(p), function (s)
                return s.name
              end))
            end
          end
        end
      end
      return skills
    end
  end,
})
return ciosmaah

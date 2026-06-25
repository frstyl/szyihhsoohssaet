local addCardSkill = fk.CreateSkill {
  name = "addCardSkill",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 
--getAllCardNames
--Fk:currentRoom().disabled_packs,
addCardSkill:addEffect(fk.GamePrepared, {
  global = true,
  mute = true,
  priority = 0,
  can_trigger = function(self, event, target, player, data)
    return (target == player) or (target == nil)
  end,
  on_trigger = function(self, event, target, player, data)
    local room = player.room
    local yes =false
    for _, pkname in ipairs(Fk.package_names) do
      -- if pkname:startsWith('szyih') then
      --   yes =true
        local package = Fk.packages[pkname]
        if package.type==Package.CardPack         
        and not table.contains(Fk:currentRoom().disabled_packs, pkname)  
        and package.extensionName=="szyihhsoohssaet"   
        then
          yes =true
          for _, skill in ipairs(package:getSkills()) do
            room:addSkill(skill)
          end
        end
  
      -- end
    end

    if yes then
        local package = Fk.packages["szyih_mechanism"]
        for _, skill in ipairs(package:getSkills()) do
          room:addSkill(skill)
        end
    end

  end,
})


-- extension:loadSkillSkels(addCardSkill)
return addCardSkill
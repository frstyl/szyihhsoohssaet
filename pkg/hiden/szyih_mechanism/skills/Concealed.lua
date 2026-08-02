local concealed = fk.CreateSkill {
  name = "concealed",
}

Skill.Concealed="Concealed" --global

local  spec={
  -- global=true,  --旹機
  mute=true,
  can_trigger = function(self, event, target, player, data)
      local room = player.room
      local general = player.general
      local deputy = player.deputyGeneral
      local skills = Fk.generals[general]:getSkillNameList()
      if Fk.generals[deputy] then
        table.insertTable(skills, Fk.generals[deputy]:getSkillNameList())
      end

      if table.find(skills, function (s) return Fk.skills[s]:hasTag(Skill.Concealed) end) then
        return true
      end

  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    if player.deputyGeneral and player.deputyGeneral ~= "" and player.deputyGeneral ~= "anjiang"  then player:hideGeneral(true) end
    if player.general and player.general ~= ""  and  player.general ~= "anjiang" then player:hideGeneral() end
    player.kingdom="unknown"
    -- room:broadcastProperty(player, "kingdom")
  end,
}
concealed:addEffect(fk.GamePrepared, spec)

concealed:addEffect(fk.AfterPropertyChange, spec)

-- concealed:addEffect(fk.BeforePropertyChange, {
--   mute=true,
--   can_trigger = function(self, event, target, player, data)
--     if not player~=target then return end
--       local room = player.room

--       local general = data.general
--       local deputy = data.deputyGeneral
--       local skills = Fk.generals[general]:getSkillNameList()
--       if Fk.generals[deputy] then
--         table.insertTable(skills, Fk.generals[deputy]:getSkillNameList())
--       end

--       if table.contains(skills, concealed.name) then
--         return true
--       end

--   end,
--   on_trigger = function(self, event, target, player, data)
--     local room=player.room
--     if player.deputyGeneral and player.deputyGeneral ~= "" and player.deputyGeneral ~= "anjiang"  then player:hideGeneral(true) end
--     if player.general and player.general ~= ""  and  player.general ~= "anjiang" then player:hideGeneral() end
--     return true 
--   end,
-- })



return concealed

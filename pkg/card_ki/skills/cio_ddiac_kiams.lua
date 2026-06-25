local equipSkill = fk.CreateSkill {
  name = "#cio_ddiac_kiams_skill",
  tags = { Skill.Compulsory },
  attached_equip = "cio_ddiac_kiams",
}

equipSkill:addAcquireEffect (function (self, player)  --作爲技能而非效果 不使用ignoreArmor 攷慮技能失效
  player.room:addTableMark(player,"ssaetIgnoreArmorBySkills",equipSkill.name) --殺无視防具 止殺流程有效,含選擇目幖.
end)
equipSkill:addLoseEffect (function (self, player)
  player.room:removeTableMark(player,"ssaetIgnoreArmorBySkills",equipSkill.name) 
end)

equipSkill:addEffect(fk.CardUsing, {
  can_trigger= function (self, event, target, player, data)
    return target == player  and player:hasSkill(equipSkill.name)
      and data.card
      and data.card.trueName=="ssaet" 
 end,
  on_use = function (self, event, target, player, data)
    -- player.room:addCardMark(data.card, "@@ignoreArmor",1)
    -- player.room.logic:getCurrentEvent():findParent(GameEvent.UseCard, true):addCleaner(function()
    --     player.room:removeCardMark(data.card, "@@ignoreArmor",1)
    -- end)
    data.extra_data=data.extra_data or {}
    data.extra_data.ignoreArmorTo=table.simpleClone(player.room.players)
  end
})


-- equipSkill:addEffect(fk.TargetSpecified, {
--   can_trigger = function(self, event, target, player, data)
--     return target == player and player:hasSkill(equipSkill.name) and data.card and data.card.trueName == "ssaet" and not data.to.dead
--   end,
--   -- on_cost = function(self, event, target, player, data)
--   --   event:setCostData(self, { tos = { data.to.id } })
--   --   return true
--   -- end,
--   on_use = function(self, event, target, player, data)
--     -- data.to:addQinggangTag(data)
--     data.use.extra_data=data.use.extra_data or {}
--     data.use.extra_data.qinggang_tag=data.use.extra_data.qinggang_tag or {}
--     table.insertIfNeed(data.use.extra_data.qinggang_tag,data.to.id)
--   end,
-- })
return equipSkill

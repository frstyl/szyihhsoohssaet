local doucqtsziu = fk.CreateSkill {
  name = "doucqtsziu",
  tags={Skill.Compulsory}
}

Fk:loadTranslationTable{
  ["doucqtsziu"] = "同舟",
  [":doucqtsziu"] = "恆續一角色A受傷旹,若A同隊列角色有此技能,其它A同隊角色各選擇是否流失1體力,令傷害值-1",

  ["#doucqtsziu-invoke"] = "同舟效果",
  ["#doucqtsziu-ask"] = "同舟 流失1體力,令 %src 所受傷-1",

  ["$doucqtsziu1"] = "帥其卽軍心",--大旗在此軍心不亂
  ["$doucqtsziu2"] = "大其飄揚軍威雄壯",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

-- doucqtsziu:addEffect(fk.DamageInflicted, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     local room=player.room
--     if not player:hasSkill(doucqtsziu.name) or data.damage<2 then return end
--     local ps=S.getSquad(player)
--     table.removeOne(ps,player.id)
--     if data.extra_data and data.extra_data.doucqtsziu then
--       for _, p in ipairs(data.extra_data.doucqtsziu)
--       table.removeOne(ps,p)
--     end
--     if #ps<1 then return end
--     ps=table.map(ps,function(id)
--       return room:getPlayerById(id)  --中途入隊?
--     end)
--     room:sortByAction(ps)  --自選序?
--     event:setCostData(self,{to=ps[1]})
--     return       true     
--   end,
--   on_trigger = function(self, event, target, player, data)
--     local n = data.damage//2  --下整  --轉迻傷害 无DamageInflicted前時機
--     data:changeDamage(-n)
--     local extra_data=data.extra_data or {}
--     extra_data.doucqtsziu=extra_data.doucqtsziu or {data.to.id}
--     room:damage{
--         from = data.from,
--         to = to,
--         damage = n,
--         damageType = data.damageType,
--         skillName = data.skillName,
--         chain = data.chain,
--         card = data.card,
--         data.extra_data=extra_data,
--       }
--   end,
-- })

-- doucqtsziu:addEffect(fk.DamageInflicted, {
--   anim_type = "defensive",
--   can_trigger = function(self, event, target, player, data)
--     return player:hasSkill(doucqtsziu.name) and S.isSameSquad(player,data.to)
--   end,
--   on_cost= function(self, event, target, player, data)
--     return player.room:askToSkillInvoke(player, { skill_name = doucqtsziu.name,prompt="#doucqtsziu-ask:"..data.to.id })
--   end,
--   on_use = function(self, event, target, player, data)
--     data.to=player
--     target = player
--     room.logic:trigger(fk.DamageInflicted, player, data)
--   end,
-- })

doucqtsziu:addEffect(fk.DamageInflicted, {
  anim_type = "defensive",
  can_trigger = function(self, event, target, player, data)
    if player~=data.to or data.damage<1 then return end --一次
    local room=player.room
    for _, id in ipairs (S.getSquad(target.id)) do
      p=room:getPlayerById(id)
      if p:hasSkill(doucqtsziu.name) then 
        room:sendLog{ type = "#doucqtsziu-invoke", from = player.id, arg = doucqtsziu.name }
        return true
      end
    end
  end,
  -- on_cost= function(self, event, target, player, data)
  --   return player.room:askToSkillInvoke(player, { skill_name = doucqtsziu.name,prompt="#doucqtsziu-ask:"..data.to.id })
  -- end,
  on_trigger = function(self, event, target, player, data)
    local t = S.getSquad(target.id)
    table.removeOne(t,player.id)
    local room=player.room
    for _, id in ipairs (t) do
      p=room:getPlayerById(id)
      if room:askToSkillInvoke(p, { skill_name = doucqtsziu.name,prompt="#doucqtsziu-ask:"..data.to.id }) then
        room:loseHp(p,1,doucqtsziu.name,player)
	    S.changeDamage({damageData=data,num=-1,skillName=doucqtsziu.name})
      if data.damage<1 then return end
      end
    end
  end,
})

return doucqtsziu

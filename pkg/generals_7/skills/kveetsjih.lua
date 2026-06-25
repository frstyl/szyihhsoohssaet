local kveetsjih = fk.CreateSkill({
  name = "kveetsjih",
  tags = {Skill.Compulsory},
})

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["kveetsjih"] = "決死",
  [":kveetsjih"] = "鎖定.伱對一角色傷旹,若其已損必發,傷害值+x｡伱使用牌指定目幖旹,若其已損,必發,其當轉不可使用打出牌,若其半損(上取整),其非鎖定技當轉失效",

  ["$kveetsjih1"] = "寶刀未老 壯气長存",

  ["@@kveetsjih-prohibit-turn"] = "決死",
}

kveetsjih:addEffect(fk.DamageCaused, {
  can_trigger = function(self, event, target, player, data)
    return target == player and player:hasSkill(kveetsjih.name) 
    --and data.to.hp<2
    and data.to:getLostHp()>0
  end,
  on_use = function(self, event, target, player, data)
    S.changeDamage({damageData=data,num=data.to:getLostHp(),skillName=kveetsjih.name})
  end,
})

kveetsjih:addEffect(fk.TargetSpecifying, {
  can_trigger= function(self, event, target, player, data)
    return target == player 
    and player:hasSkill(kveetsjih.name) 
    and data.to:isWounded()
  end,
  on_use= function(self, event, target, player, data)
    player.room:addPlayerMark(data.to,"@@kveetsjih-prohibit-turn", 1)
    if data.to.hp <= (data.to.maxHp+1)//2 then
    player.room:addPlayerMark(data.to,MarkEnum.UncompulsoryInvalidity .. "-turn", 1)
    end
  end,
})

kveetsjih:addEffect("prohibit", {
  prohibit_use = function(self, player, card)
    if player:getMark("@@kveetsjih-prohibit-turn")~=0 then return true end
  end,
  prohibit_response = function(self, player, card)
    if player:getMark("@@kveetsjih-prohibit-turn")~=0 then return true end
  end,
})
-- kveetsjih:addEffect(fk.CardUsing, {
--   can_trigger= function(self, event, target, player, data)
--     return target == player and player:hasSkill(kveetsjih.name) 
--   end,
--   on_use= function(self, event, target, player, data)
--     data.disresponsiveList=data.disresponsiveList or {}
--     for _,p in ipairs(player.room:getOtherPlayers(player,false)) do
--       if p.hp <= (p.maxHp+1)//2 and table.contains(data.tos,p) then
--         table.insertIfNeed(data.disresponsiveList, p)
--       end
--     end
--   end,
-- })

-- kveetsjih:addEffect("targetmod", {
--   -- bypass_times = function(self, player, skill, scope, card)
--   --   return card --and scope == Player.HistoryPhase 
--   --   and table.contains(card.skillNames, pjecskrak.name)
--   --   and Fk:getCardById(card.subcards[1]).type==Card.TypeTrick
--   -- end,
--   bypass_distances = function(self, player, skill, card,to)
--     return card and player:hasSkill(kveetsjih.name)  and to:isWounded()
--   end,
-- })

return kveetsjih

local equipSKill = fk.CreateSkill{
  name = "#gracqgi_gi_skill",
  tags = { Skill.Compulsory },
  attached_equip = "gracqgi_gi",
}
Fk:loadTranslationTable{
  ["#gracqgi_gi_skill"] = "旗",
  ["#gracqgi_gi_skill-invoke"] = "旗 是否將其置入 %src 裝僃區",

}
local S = require "packages/szyihhsoohssaet/szyih_guos" 

equipSKill:addAcquireEffect(function (self, player)
    player.room:addPlayerMark(player, "@add_attack_range",1) 
    player.room:addPlayerMark(player, MarkEnum.AddMaxCards,1) 
    player.room:addPlayerMark(player, "@add_phase_draw",1) 
end)

equipSKill:addLoseEffect (function (self, player)
    player.room:removePlayerMark(player, "@add_attack_range",1) 
    player.room:removePlayerMark(player, MarkEnum.AddMaxCards,1) 
    player.room:removePlayerMark(player, "@add_phase_draw",1) 
end)

equipSKill:addEffect(fk.AskForPeaches, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(equipSKill.name)  --必有牌?
    and  data.who~=player
  end,
  on_cost = function(self, event, target, player, data)
    local cards = table.filter(player:getEquipCards(Card.SubtypeTreasure), function(card)
       return card.trueName=="gracqgi_gi" 
       and data.who:canMoveCardIntoEquip(card, true)
    end)  --
    if #cards==0  then  return end
    if #cards>1 then 
      local ids = player.room:askToChooseCards(player, {
          target = data.to,
          flag = { card_data = { { "equip", table.map(cards,function(card)return card:getEffectiveId() end) } } },
          skill_name = kouqljem.name,
          cancelable=true,
          max=1,
          min=0,
          prompt="#gracqgi_gi_skill-invoke:"..data.who.id
        })

        if #ids>0 then
          event:setCostData(self,{tos={data.who},card=ids})
          return true
        end
    else
      if player.room:askToSkillInvoke(player, { skill_name = equipSKill.name,prompt="#gracqgi_gi_skill-invoke:"..data.who.id }) then
        event:setCostData(self,{tos={data.who},card=cards})
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    room:moveCardIntoEquip(data.who, event:getCostData(self).card, equipSKill.name, true, player)
    if data.who:isWounded() and not data.who.dead then
      room:recover{
        who = data.who,
        num = 1,
        recoverBy = player,
        skillName = equipSKill.name,
      }
    end 
  end,
})

-- equipSKill:addEffect("atkrange", {
--   correct_func = function (self, from, to)
--     if from and to then
--       return #table.filter(Fk:currentRoom().alive_players, function(p)
--         return S.isSameSquad(p,from) and p:hasSkill(equipSKill.name)
--       end
--       )
--     end
--   end,
-- })
-- --同一脚色裝僃同名裝僃 止生效1?
-- Fk:loadTranslationTable{
--   ["gracqgi_gi_skill"] = "杏黃旗",
--   [":gracqgi_gi_skill"] = "鎖，与伱同陣營(隊列)脚色攻程+1。",
-- }

-- equipSKill:addEffect("active", {
--   prompt = "#role__wooden_ox",
--   card_num = 1,
--   card_filter = function(self, player, to_select, selected)
--     return #selected == 0 and table.contains(player:getCardIds("h"), to_select)
--   end,
--   target_num = 0,
--   on_use = function(self, room, effect)
--    effect.from:drawCards(2,equipSKill.name)
--   end,
-- })
return equipSKill

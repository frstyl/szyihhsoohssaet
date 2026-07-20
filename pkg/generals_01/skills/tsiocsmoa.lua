local tsiocsmoa = fk.CreateSkill{
  name = "tsiocsmoa",
  -- tags = { Skill.Compulsory },
}

Fk:loadTranslationTable{
  ["tsiocsmoa"] = "縱魔",
  [":tsiocsmoa"] = "應動｡伱使用｢殺｣指定目幖旹,伱可發動｡伱抽2,迻除此目幖,虛擬使用｢猛虎下山｣,此牌效果:目幖可打出屬性｢殺｣若打出伱抽1,否則伱予目幖1傷,目幖隨機自弃1牌",

  ["#tsiocsmoa-invoke"] = "縱魔 是否對 %src發動",

  ["$tsiocsmoa1"] = "遇洪而開 分明就是叫我開",

}

tsiocsmoa:addEffect(fk.TargetSpecifying, {
  anim_type = "offensive",
  can_trigger = function (self, event, target, player, data)
    return target==player and player:hasSkill(tsiocsmoa.name) and data.to~=data.from and data.card.trueName=="ssaet" 
  end,
  on_cost = function (self, event, target, player, data)
    if player.room:askToSkillInvoke(player, {
      skill_name = tsiocsmoa.name,
      prompt = "#tsiocsmoa-invoke:"..data.to.id,
    })
    then
      event:setCostData(self,{tos={data.to}}) --???
      return true
    end
  end,
  on_use = function (self, event, target, player, data)
    local room = player.room

    player:drawCards(2,tsiocsmoa.name)
    data:cancelTarget(data.to)
    if player.dead then return end

    local card = Fk:cloneCard("maach_hsooh_hzaah_ssaen")
    card.skill=Fk.skills["tsiocsmoa__maach_hsooh_hzaah_ssaen_skill"]
    card.skillName = tsiocsmoa.name

    room:useCard{  --bypase times
      from = player,
      tos = card:getDefaultTarget(player),
      card = card,
      -- extraUse=true,
    }
  end,
})


-- tsiocsmoa:addEffect(fk.HandleAskForPlayCard, {  --眞止問ask AskForCardData extraData eventData
--   can_refresh = function(self, event, target, player, data)  --雙向?
--     return  data.eventData 
--     and  data.eventData.card
--     and data.eventData.card.skillNames
--     and  table.contains(data.eventData.card.skillNames, tsiocsmoa.name)
--   end,
--   on_refresh = function(self, event, target, player, data)
--     local room = player.room
--     if not data.afterRequest then
--       room:setBanner("tsiocsmoa_banner", true)
--     else
--       room:setBanner("tsiocsmoa_banner", nil)
--     end
--   end,
-- })

-- tsiocsmoa:addEffect(fk.AskForCardUse, {--trigger技用牌 會封其它結算
--   can_refresh = function(self, event, target, player, data)  --雙向?
--     return  data.eventData 
--     and  data.eventData.card
--     and data.eventData.card.skillNames
--     and  table.contains(data.eventData.card.skillNames, tsiocsmoa.name)
--   end,
--   on_refresh = function(self, event, target, player, data)
--     player.room:setBanner("tsiocsmoa_banner", true)
--   end,
-- })

-- tsiocsmoa:addEffect("prohibit", {
--   prohibit_use = function(self, player, card)
--     local color = Fk:currentRoom():getBanner("tsiocsmoa_banner")
--     return color
--   end,
--   prohibit_response = function(self, player, card)
--     local color = Fk:currentRoom():getBanner("tsiocsmoa_banner")
--     if not color then return end 
    
--     if card and not table.contains({"fire__ssaet","thunder__ssaet"} , card.name ) then return true end
--   end,
-- })

-- tsiocsmoa:addEffect(fk.Damaged, {
--   anim_type = "offensive",
--   can_trigger = function(self, event, target, player, data)
--     return  target==player 
--     and data.card
--     and table.contains(data.card.skillNames, tsiocsmoa.name) 
--     and not player:isNude()
--     and data.by_user
--   end,
--   on_trigger = function(self, event, target, player, data)
--     player.room:throwCard(table.random(player:getCardIds("he")), tsiocsmoa.name, player, player)
--   end,
-- })
return tsiocsmoa

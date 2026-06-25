local ljephzfak = fk.CreateSkill{
  name = "ljephzfak",
}

Fk:loadTranslationTable{
  ["ljephzfak"] = "爉獲",
  [":ljephzfak"] = "{伱使用殺指定目幖後/伱使用打出牌響應其它角色後},若其有手牌,伱可發動.伱獲取其1手牌",

  ["#ljephzfak-invoke"] = "爉獲 獲取%src手牌",

  ["$ljephzfak"] = "伱跑不掉已",
}



local spec = {
  anim_type = "offensive",
  on_cost = function(self, event, target, player, data)
    local room = player.room
    local to = event:getCostData(self).tos[1]
    if room:askToSkillInvoke(player, {
      skill_name = ljephzfak.name,
      prompt = "#ljephzfak-invoke:"..to.id,
    }) then
      event:setCostData(self, {tos = {to}})
      return true
    end
  end,

  on_use = function(self, event, target, player, data)
    local room = player.room
    local to= event:getCostData(self).tos[1]
    local cid = room:askToChooseCard(player, { target = to, flag = "h", skill_name = ljephzfak.name })
    room:obtainCard(player, {cid}, false, fk.ReasonPrey, player, ljephzfak.name)
  end,
}

ljephzfak:addEffect(fk.TargetSpecified,{
  can_trigger = function(self, event, target, player, data)
    if target == player and player:hasSkill(ljephzfak.name) 
    and  data.to~=player
    and  data.card.trueName=="ssaet"
    and not data.to:isKongcheng()
    then
      event:setCostData(self, {tos = {data.to}})
      return true
    end
  end,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

local reponse_sepc={
    can_trigger = function(self, event, target, player, data)
    if target ~= player or not  player:hasSkill(ljephzfak.name) then return end
      local to =player
    if (data.responseToEvent and data.responseToEvent.from ) then
       to =data.responseToEvent.from
    else
      -- local SkillEffect= player.room.logic:getCurrentEvent():findParent(GameEvent.SkillEffect, false)
      local SkillEffect= player.room.logic:getCurrentEvent().parent
      if SkillEffect and SkillEffect.event == GameEvent.SkillEffect  and SkillEffect.data and SkillEffect.data.skill 
      and table.contains({"khoucqhqrach"},SkillEffect.data.skill.name) then  --額外轉算?
        to=SkillEffect.data.who  --視爲使用 彊制使用
      end
    end

      if to and to~=player and not to.dead and not to:isKongcheng() then
        event:setCostData(self, {tos = {to}})
      return true
      end
    
  end,
}
ljephzfak:addEffect(fk.CardUsing, {
  anim_type = "offensive",
  can_trigger=reponse_sepc.can_trigger,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})

ljephzfak:addEffect(fk.CardResponding, {
  can_trigger=reponse_sepc.can_trigger,
  on_cost = spec.on_cost,
  on_use = spec.on_use,
})
return ljephzfak

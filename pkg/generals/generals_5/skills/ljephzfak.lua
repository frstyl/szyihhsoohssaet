local ljephzfak = fk.CreateSkill{
  name = "ljephzfak",
}

Fk:loadTranslationTable{
  ["ljephzfak"] = "爉獲",
  [":ljephzfak"] = "伱{起動效果生效前前/演練旹},若目幖或被響應者 不爲伱且有手牌且手牌不小于伱,伱可對其發動.伱取得其1手牌",
  -- [":ljephzfak"] = "伱{起動｢殺｣指定目幖/起動或打出牌響應其它脚色}後,若其有手牌,伱可發動.伱取得其1手牌",

  ["#ljephzfak-invoke"] = "爉獲 取得%src手牌",
  ["#ljephzfak-ask"] = "爉獲 選擇1目幖 取得其1手牌",

  ["$ljephzfak"] = "伱跑不掉已",
}



-- local spec = {
--   anim_type = "offensive",
--   on_cost = function(self, event, target, player, data)
--     local room = player.room
--     local to = event:getCostData(self).tos[1]
--     if room:askToSkillInvoke(player, {
--       skill_name = ljephzfak.name,
--       prompt = "#ljephzfak-invoke:"..to.id,
--     }) then
--       event:setCostData(self, {tos = {to}})
--       return true
--     end
--   end,

--   on_use = function(self, event, target, player, data)
--     local room = player.room
--     local to= event:getCostData(self).tos[1]
--     local cid = room:askToChooseCard(player, { target = to, flag = "h", skill_name = ljephzfak.name })
--     room:obtainCard(player, {cid}, false, fk.ReasonPrey, player, ljephzfak.name)
--   end,
-- }

-- ljephzfak:addEffect(fk.TargetConfirming,{
--   can_trigger = function(self, event, target, player, data)
--     if data.from  == player and player:hasSkill(ljephzfak.name) 
--     and  data.to~=player
--     and  data.card.trueName=="ssaet"
--     and not data.to:isKongcheng()
--     then
--       event:setCostData(self, {tos = {data.to}})
--       return true
--     end
--   end,
--   on_cost = spec.on_cost,
--   on_use = spec.on_use,
-- })

-- local reponse_sepc={
--     can_trigger = function(self, event, target, player, data)
--     if target ~= player or not  player:hasSkill(ljephzfak.name) then return end
--       local to =player
--     if (data.responseToEvent and data.responseToEvent.from ) then
--        to =data.responseToEvent.from
--     else
--       -- local SkillEffect= player.room.logic:getCurrentEvent():findParent(GameEvent.SkillEffect, false)
--       local SkillEffect= player.room.logic:getCurrentEvent().parent
--       if SkillEffect and SkillEffect.event == GameEvent.SkillEffect  and SkillEffect.data and SkillEffect.data.skill 
--       and table.contains({"khoucqhqrach"},SkillEffect.data.skill.name) then  --額外轉算?
--         to=SkillEffect.data.who  --視爲起動 彊制起動
--       end
--     end

--       if to and to~=player and not to.dead and not to:isKongcheng() then
--         event:setCostData(self, {tos = {to}})
--       return true
--       end 
--   end,
-- }

local spec={
  anim_type = "offensive",
  can_trigger = function(self, event, target, player, data)
    return data.from==player and player:hasSkill(ljephzfak.name)
  end,
  on_cost = function(self, event, target, player, data)
    local targets={}
    if data.to then targets={data.to} end
    if (data.responseToEvent and data.responseToEvent.from ) then
       table.insertIfNeed(targets, data.responseToEvent.from)
    end
    if data.extra_data and data.extra_data.skill_effect_event and data.extra_data.skill_effect_event.who then  --不會同旹有 skill card
       table.insertIfNeed(targets, data.extra_data.skill_effect_event.who)
    end
    targets = table.filter(targets,function(p)
    return p~=player and p:getHandcardNum()>= player:getHandcardNum()
    end)
    if #targets== 0 then return end
    if #targets== 1 then
      if  
      player.room:askToSkillInvoke(player, {
        skill_name = ljephzfak.name,
        prompt = "#ljephzfak-invoke:"..targets[1].id,
      }) then
        event:setCostData(self, {tos = targets})
        return true
      end
    else
      local tos = player.room:askToChoosePlayers(player, {
        targets = targets,
        min_num = 1,
        max_num = 1,
        prompt = "#ljephzfak-ask",
        skill_name = ljephzfak.name,
        cancelable=true
      })
      if #tos > 0 then
        event:setCostData(self, { tos = tos })
        return true
      end
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    local to= event:getCostData(self).tos[1]
    local cid = room:askToChooseCard(player, { target = to, flag = "h", skill_name = ljephzfak.name })
    room:obtainCard(player, {cid}, false, fk.ReasonPrey, player, ljephzfak.name)
  end,  
}
ljephzfak:addEffect(fk.PreCardEffect, spec)
ljephzfak:addEffect(fk.CardResponding, spec)

return ljephzfak

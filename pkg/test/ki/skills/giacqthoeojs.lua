local giacqthoeojs = fk.CreateSkill {
  name = "giacqthoeojs",
}

Fk:loadTranslationTable{
  ["giacqthoeojs"] = "彊貸",
  [":giacqthoeojs"] = "｢殺｣對目幖A生效前,伱可發動.伱令A抽1,A可起動1元實牌,若A不爲伱,此結算終,A需交予伱2牌",

  ["#giacqthoeojs-self"] = "彊貸：伱可抽1",
  ["#giacqthoeojs-invoke"] = "彊貸：伱可令 %dest 抽1",
  ["#giacqthoeojs-give"] = "彊貸：交给 %dest 2牌",
  ["#giacqthoeojs-use"] = "彊貸：伱可起動1牌",

  -- ["$giacqthoeojs1"] = "典将军，比比看谁杀敌更多！",
  -- ["$giacqthoeojs2"] = "父亲快走，有我殿后！"
}

giacqthoeojs:addEffect(fk.PreCardEffect, {
  anim_type = "support",
  can_trigger = function(self, event, target, player, data)
    return player:hasSkill(giacqthoeojs.name) and data.card.trueName == "ssaet"
  end,
  on_cost = function (self, event, target, player, data)
    local room = player.room
    if target == player then
      return room:askToSkillInvoke(player, {
        skill_name = giacqthoeojs.name,
        prompt = "#giacqthoeojs-self",
      })
    elseif room:askToSkillInvoke(player, {
      skill_name = giacqthoeojs.name,
      prompt = "#giacqthoeojs-invoke::"..target.id,
    }) then
      event:setCostData(self, {tos = {target}})
      return true
    end
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
    data.to:drawCards(1, giacqthoeojs.name)
    if target.dead then return end
    room:askToUseRealCard(target, {
        pattern = ".",
        skill_name = giacqthoeojs.name,
        prompt = "#giacqthoeojs-use",
        extra_data = {
          bypass_times = false,
          extraUse = false,
          bypass_distances=false,
        },
      cancelable=true,
      })
    if  target == player then return end
    data.use =data.use or {}
    data.use.extra_data=data.use.extra_data or {}
    data.use.extra_data.giacqthoeojs=data.use.extra_data.giacqthoeojs or {}
    table.insert(data.use.extra_data.giacqthoeojs, player.id)
    data.original_to=data.original_to or data.to.id
    -- room.logic:getCurrentEvent():findParent(GameEvent.UseCard):addCleaner(function()  --可以被跳
    --   if  target:isNude() or player.dead or target.dead then return end
    --   local card = room:askToCards(target, {
    --     skill_name = giacqthoeojs.name,
    --     min_num = 2,
    --     max_num = 2,
    --     prompt = "#giacqthoeojs-give::"..player.id,
    --     include_equip = true,
    --     cancelable = false,
    --   })
    --   room:moveCardTo(card, Card.PlayerHand, player, fk.ReasonGive, giacqthoeojs.name, nil, false, target)

    -- end)

  end,
})

giacqthoeojs:addEffect(fk.PreCardEffect, { 
  can_trigger = function(self, event, target, player, data) --敘基于起動者
    if data.extra_data and data.extra_data.giacqthoeojs 
      -- and not player.room:getPlayerById(data.extra_data.giacqthoeojs[2]).dead
      and not player.room:getPlayerById(data.original_to).dead
      and not player.room:getPlayerById(data.original_to):getHandcardNum()>0
    then
      return true
    end

  end,
  on_trigger = function (self, event, target, player, data)
    local room=player.room
    local from = player.room:getPlayerById(data.original_to)
    for _, id in ipairs(data.extra_data.giacqthoeojs ) do
      local p=room:getPlayerById(id)
      if not p.dead and from:getHandcardNum()>0 then
              local cards = room:askToCards(from, {
          skill_name = giacqthoeojs.name,
          min_num = 2,
          max_num = 2,
          prompt = "#giacqthoeojs-give::"..to.id,
          include_equip = true,
          cancelable = false,
        })
      room:moveCardTo(cards, Card.PlayerHand, to, fk.ReasonGive, giacqthoeojs.name, nil, false, from)
      end
    end

  end,
})
return giacqthoeojs

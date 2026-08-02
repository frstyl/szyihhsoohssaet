local giacqthoeojs = fk.CreateSkill {
  name = "giacqthoeojs",
}

Fk:loadTranslationTable{
  ["giacqthoeojs"] = "彊貸",
  [":giacqthoeojs"] = "一脚色A成爲殺目幖後,伱可發動.伱令A抽1,A可起動1元實牌,若A不爲伱,此殺起動結算終,A需交予伱2牌",

  ["#giacqthoeojs-self"] = "彊貸：伱可抽1",
  ["#giacqthoeojs-invoke"] = "彊貸：伱可令 %dest 抽1",
  ["#giacqthoeojs-give"] = "彊貸：交给 %dest 2牌",
  ["#giacqthoeojs-use"] = "彊貸：伱可起動1牌",

  -- ["$giacqthoeojs1"] = "典将军，比比看谁杀敌更多！",
  -- ["$giacqthoeojs2"] = "父亲快走，有我殿后！"
}

giacqthoeojs:addEffect(fk.TargetConfirmed, {
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
    data.use.extra_data.giacqthoeojs={data.to.id, player.id}
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

giacqthoeojs:addEffect(fk.CardUseFinished, { 
  can_trigger = function(self, event, target, player, data) --敘基于起動者
    if data.extra_data and data.extra_data.giacqthoeojs 
      and not player.room:getPlayerById(data.extra_data.giacqthoeojs[1]).dead
      and  not player.room:getPlayerById(data.extra_data.giacqthoeojs[2]).dead
      and not player.room:getPlayerById(data.extra_data.giacqthoeojs[1]):getHandcardNum()>0
    then
      return true
    end

  end,
  on_trigger = function (self, event, target, player, data)
    local room=player.room
    local to = player.room:getPlayerById(data.extra_data.giacqthoeojs[2])
    local from=player.room:getPlayerById(data.extra_data.giacqthoeojs[1])
      local card = room:askToCards(from, {
        skill_name = giacqthoeojs.name,
        min_num = 2,
        max_num = 2,
        prompt = "#giacqthoeojs-give::"..to.id,
        include_equip = true,
        cancelable = false,
      })
      room:moveCardTo(card, Card.PlayerHand, to, fk.ReasonGive, giacqthoeojs.name, nil, false, from)
  end,
})
return giacqthoeojs

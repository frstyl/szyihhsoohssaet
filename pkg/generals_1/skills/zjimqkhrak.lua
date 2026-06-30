local zjimqkhrak = fk.CreateSkill{
  name = "zjimqkhrak",
}

local S = require "packages/szyihhsoohssaet/szyih_guos" 

Fk:loadTranslationTable{
  ["zjimqkhrak"] = "尋隙",
  [":zjimqkhrak"] = "其它角色A主段始旹,(若其未被此發動技能)伱可發動.伱弃其1牌,本段內其至伱距離爲1,使用牌需指定伱爲目幖.當段終旹,若其未對伱致傷,伱可打出1手牌予其1傷",

--无距離次數限制
  ["@@zjimqkhrak-phase"] = "尋隙",
  ["#zjimqkhrak-invoke"] = "尋隙 %src主段始 是否攪事",
  ["#zjimqkhrak-damage"] = "尋隙 打出1牌 予%src 1傷",

  ["$zjimqkhrak1"] = "伱昰幹何",
}

zjimqkhrak:addEffect(fk.EventPhaseStart, {
  anim_type = "control",
  can_trigger = function(self, event, target, player, data)
    return target ~= player and player:hasSkill(zjimqkhrak.name) and target.phase == Player.Play
    and target:getMark("@@zjimqkhrak-phase") ==0
  end,
  on_cost = function(self, event, target, player, data)
    return player.room:askToSkillInvoke(player,{
      skill_name=zjimqkhrak.name,
      prompt="#zjimqkhrak-invoke:"..target.id,
    })
  end,
  on_use = function(self, event, target, player, data)
    local room = player.room
   local cards=room:askToChooseCard(player, { target = target, flag = "he", skill_name = zjimqkhrak.name })

    room:throwCard(cards,zjimqkhrak.name,target,player)
   room:setPlayerMark(target,"@@zjimqkhrak-phase",player.id)
  end,
})

zjimqkhrak:addEffect("distance", {
    fixed_func = function(self, from, to)
    if from:getMark("@@zjimqkhrak-phase") == to.id then
      return 1
    end
  end,
})

zjimqkhrak:addEffect("prohibit", {
  is_prohibited = function(self, from, to, card)
    return from and from:getMark("@@zjimqkhrak-phase")~=0  and card and (to and from:getMark("@@zjimqkhrak-phase")~= to.id) 
  end,
  prohibit_use = function(self, player, card)
    if player:getMark("@@zjimqkhrak-phase")~=0  then 
      return card and card.skill and card.skill:getMinTargetNum(player)==0
    end
  end,
})

zjimqkhrak:addEffect(fk.Damage, {
  is_delay_effect=true,
  can_refresh = function(self, event, target, player, data)
    return player==target and target:getMark("@@zjimqkhrak-phase")==data.to.id
  end,
  on_refresh = function(self, event, target, player, data)
    player.room:addPlayerMark(player,"@@zjimqkhrak-damage-phase",1)
  end,
})

zjimqkhrak:addEffect(fk.EventPhaseEnd, {  --應該記錄phase id,防段中段
  is_delay_effect=true,
  can_trigger = function(self, event, target, player, data)
    return  
    player==target
    and
    target:getMark("@@zjimqkhrak-phase")~=0 
    and target:getMark("@@zjimqkhrak-damage-phase")==0

  end,
  on_trigger = function(self, event, target, player, data)
    local room=player.room
    -- room:loseHp(player,1,zjimqkhrak.name,player)
    local from = room:getPlayerById(target:getMark("@@zjimqkhrak-phase"))
    -- local re=S.askToResponseReal(from,{
      -- skillName= zjimqkhrak.name,
      -- prompt= "#zjimqkhrak-damage:"..target.id,
      -- skip=true,
      -- includeArea="he",
      -- tos={target},
    -- })
    -- if re and re[1] then
            -- room:responseCard(re[1])
    local cards = room:askToCards(from, {
      min_num = 1,
      max_num = 1,
      skill_name = zjimqkhrak.name,
      pattern = tostring(Exppattern{ id = table.filter(from:getHandlyIds(), function (id)
      return not from:prohibitResponse(Fk:getCardById(id))
    end)}),
      prompt = "#zjimqkhrak-damage:"..target.id,
      cancelable = true,
    })
      if #cards == 1 then
      room:responseCard({
				card=Fk:getCardById(cards[1]),
				from=from,
				attachedSkillAndUser={muteCard=true},
			})
      room:damage{
        from = from,
        to = target,
        damage = 1,
        skillName = zjimqkhrak.name,
      }
      end
  end,
})
return zjimqkhrak
